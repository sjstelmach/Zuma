//
//  DirectedPath.m
//  Zuma
//
//  Created by Andy Lei on 1/7/10.
//  Copyright 2010 Harvard. All rights reserved.
//

#import <math.h>
#import "DirectedPath.h"
#import "ResourceManager.h"

float EPSILON = 0.00001;

float CGPointDistBetween(CGPoint p1, CGPoint p2)
{
	float dy = p1.y - p2.y;
	float dx = p1.x - p2.x;
	return sqrt(dx * dx + dy * dy);
}

/* angle between 2 vectors */
float angleBetween(CGPoint v1, CGPoint v2)
{
    return atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
}

@implementation Segment

@synthesize startPoint, endPoint, length;

- (CGPoint) pointFromStartWithOffset: (float) dist
{
	[self doesNotRecognizeSelector:_cmd];
	return startPoint;
}

- (Boolean) containsPoint: (CGPoint) point
{
	[self doesNotRecognizeSelector:_cmd];
	return false;
}
- (void) draw
{
	[self doesNotRecognizeSelector:_cmd];
}

@end

@implementation LineSegment

- (LineSegment *) initWithStart: (CGPoint) st andEnd: (CGPoint) ed
{
	if (self = [super init]) {
		startPoint = st;
		endPoint = ed;
		float dx = ed.x - st.x;
		float dy = ed.y - st.y;
		length = sqrt(dx * dx + dy * dy);
		dir.x = dx / length;
		dir.y = dy / length;
	}
	return self;
}

- (Boolean) containsPoint: (CGPoint) point
{
		// in the correct bounding box
	if (   point.x > MAX(startPoint.x, endPoint.x)
		|| point.x < MIN(startPoint.x, endPoint.x)
		|| point.y > MAX(startPoint.y, endPoint.y)
		|| point.y < MIN(startPoint.y, endPoint.y)
	)
		return false;
	
	float nslope = (point.y - startPoint.y) / (point.x - startPoint.x);
	return abs(dir.y / dir.x - nslope) < EPSILON;
}

- (CGPoint) pointFromStartWithOffset: (float) dist
{
	return CGPointMake(startPoint.x + dir.x * dist, startPoint.y + dir.y * dist);
}

- (void) draw
{
	GLfloat line[] = {
		startPoint.x, startPoint.y,
		endPoint.x, endPoint.y,
	};
	glDisable(GL_TEXTURE_2D);
	glColor4f(1.0, 0.0, 0.0, 1.0);
	glVertexPointer(2, GL_FLOAT, 0, line);
	glDrawArrays(GL_LINES, 0, 2);
	glEnable(GL_TEXTURE_2D);
}

@end

@implementation ArcSegment

- (ArcSegment *) initWithStart: (CGPoint) st 
					   withEnd: (CGPoint) ed 
					withRadius: (CGFloat) rad
				andIsClockwise: (Boolean) dir
{
	if (self = [super init]) {
		radius = rad;
		startPoint = st;
		endPoint = ed;
		clockwise = dir;
		
		// from http://www.sonoma.edu/users/w/wilsonst/Papers/Geometry/circles/default.html
		CGFloat d = CGPointDistBetween(startPoint, endPoint);
		CGFloat inSquareroot = sqrt((pow(2*rad,2)-pow(d,2))*pow(d,2));
		CGFloat plusMinus = (endPoint.y - startPoint.y)/(2*pow(d,2))*inSquareroot;
		CGFloat minusPlus = (endPoint.x - startPoint.x)/(2*pow(d,2))*inSquareroot;
		center = CGPointMake((startPoint.x + endPoint.x)/2 + plusMinus,
									 (startPoint.y + endPoint.y)/2 - minusPlus);
		
		// if sign matches
		CGPoint v1 = CGPointMake(startPoint.x - center.x, startPoint.y - center.y);
		CGPoint v2 = CGPointMake(endPoint.x - center.x, endPoint.y - center.y);
		angle = angleBetween(v1, v2);
		// switch to the other center in the case of counterclockwise with negative angle with first center
		if(angle * (dir ? -1 : 1) < 0){
			center = CGPointMake((startPoint.x + endPoint.x)/2 - plusMinus,
								 (startPoint.y + endPoint.y)/2 + minusPlus);
			// recalc vectors if length changes
			v1 = CGPointMake(startPoint.x - center.x, startPoint.y - center.y);
			v2 = CGPointMake(endPoint.x - center.x, endPoint.y - center.y);
			angle *= -1.0f;
		}
		
		length = fabs(angle) * radius;
		initialAngle = angleBetween(CGPointMake(1.0f, 0.0f), v1);
		initialAngle = initialAngle < 0 ? 2 * M_PI + initialAngle : initialAngle;
	}
	NSLog(@"center: (%f, %f)", center.x, center.y);
	NSLog(@"start angle: %f, for: %f", initialAngle, angle);
	return self;
}

- (CGPoint) pointFromStartWithOffset: (float) dist
{
	float t = initialAngle + dist * angle / length;
	float x = center.x + radius * cos(t);
	float y = center.y + radius * sin(t);
	return CGPointMake(x, y);
}

- (Boolean) containsPoint: (CGPoint) point
{
		// inverse of parametric equations
	float ft = acos((point.x - center.x) / radius);
	if (abs(ft - asin((point.y - center.y) / radius)) > EPSILON)
		return false;
	float t = (ft - initialAngle) / angle;
	return (t >= -EPSILON && t <= 1.0f + EPSILON);
}

- (void) draw
{	
	GLint numVertices = ceil(100*fabs(angle)/(2 * M_PI));
	GLfloat *vertices = malloc(2*numVertices*sizeof(float));
	for(int i=0; i<numVertices; i++){
		float dist = (float)i/(numVertices-1)*length;
		CGPoint loc = [self pointFromStartWithOffset: dist];
		vertices[2*i] = loc.x; //x
		vertices[2*i+1] = loc.y; //y
	}

	glDisable(GL_TEXTURE_2D);
	glColor4f(1.0, 0.0, 0.0, 1.0);
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_LINE_STRIP, 0, numVertices);
	glEnable(GL_TEXTURE_2D);
	
}

@end



@implementation DirectedPath

@synthesize segments, start, end, length;

- (DirectedPath *) initWithStart: (CGPoint) point
{
	if (self = [super init]) {
		start = point;
		end = point;
		segments = [[NSMutableArray array] retain];
		length = 0.0f;
	}
	return self;
}

- (int) addLineSegmentWithNextPoint: (CGPoint) point
{
	LineSegment * l = [[LineSegment alloc] initWithStart:end 
												  andEnd:point];
	return [self addSegment: l];
}

- (int) addArcSegmentWithNextPoint: (CGPoint) point 
						 withRadius: (float) rad 
					 andIsClockwise: (Boolean) dir
{
	ArcSegment * a = [[ArcSegment alloc] initWithStart:end 
											   withEnd:point 
											withRadius:rad 
										andIsClockwise:dir];
	return [self addSegment: a];
}

/*
 * returns the point on the directed path dist from the start
 *  if dist > length of the directed path, returns the end of
 *  the directed path.
 */
- (CGPoint) pointAtOffset: (float) dist
{
	if (dist > length) {
		return end;
	}
	NSEnumerator * e = [segments objectEnumerator];
	Segment * s;
	while(s = [e nextObject]){
		if(s.length > dist){
			return [s pointFromStartWithOffset: dist];
		}
		dist -= s.length;
	}
	/*while (s = (Segment *)[e nextObject] && s.length > dist) {
		dist -= s.length;
	}*/
	return [s pointFromStartWithOffset:dist];
}

- (int) addSegment: (Segment *) seg
{
	end = seg.endPoint;
	length += seg.length;
	[segments addObject: seg];
	return [segments count];
}

- (void) draw
{
	Segment * s;
	NSEnumerator * e = [segments objectEnumerator];
	while (s = (Segment *)[e nextObject]) {
		[s draw];
	}
}

- (void) dealloc
{
	[segments release];
	[super dealloc];
}

@end
