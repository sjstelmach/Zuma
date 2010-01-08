//
//  DirectedPath.m
//  Zuma
//
//  Created by Andy Lei on 1/7/10.
//  Copyright 2010 Harvard. All rights reserved.
//

#import <math.h>
#import "DirectedPath.h"

float CGPointDistBetween(CGPoint p1, CGPoint p2)
{
	float dy = p1.y - p2.y;
	float dx = p1.x - p2.x;
	return sqrt(dx * dx + dy * dy);
}

@implementation Segment

- (CGPoint) nextPointAfter: (CGPoint) point withOffset: (float) dist
{
	[self doesNotRecognizeSelector:_cmd];
	return point;
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

float EPISLON = 0.00001;

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
	return abs(dir.y / dir.x - nslope) < EPISLON;
}

- (CGPoint) pointFromStartWithOffset: (float) dist
{
	return [self nextPointAfter:startPoint withOffset:dist];
}

- (CGPoint) nextPointAfter: (CGPoint) point withOffset: (float) dist
{
		// make sure point is on the segment
	if (![self containsPoint:point]) {
		return point;
	}
	CGPoint p = CGPointMake(point.x + dir.x * dist, point.y + dir.y * dist);
		// make sure result is on the segment
	if (![self containsPoint:p]) {
		return point;
	}
	return p;
}

- (void) draw{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
	CGContextSetLineWidth(context, 5.0);
	CGContextMoveToPoint(context, startPoint.x, startPoint.y);
	CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
	CGContextStrokePath(context);	
}

@end


@implementation ArcSegment


/* angle between 2 vectors */
float angleBetween(CGPoint v1, CGPoint v2)
{
    return atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
}

- (ArcSegment *) initWithStart: (CGPoint) st 
					   withEnd: (CGPoint) ed 
					withRadius: (CGFloat) rad
				andIsClockwise: (Boolean) dir
{
	if (self = [super init]) {
		radius = rad;
		startPoint = st;
		endPoint = ed;
		clockwise = dir ? -1 : 1;
		
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
		if(angle * dir < 0){
			center = CGPointMake((startPoint.x + endPoint.x)/2 - plusMinus,
								 (startPoint.y + endPoint.y)/2 + minusPlus);
		}
		angle = angle < 0 ? angle * -1 : angle;
		
		length = angle * radius;
		initialAngle = angleBetween(CGPointMake(0.0f, 0.0f), v1);
		initialAngle = initialAngle < 0 ? 2 * M_PI - initialAngle : initialAngle;
	}
	return self;
}

- (CGPoint) pointFromStartWithOffset: (float) dist
{
	float t = initialAngle + dist * angle / length
	float x = center.x + radius * cos(t);
	float y = center.y + radius * sin(t);
	return CGPointMake(x, y);
}

- (void) draw{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextBeginPath(context);
	CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
	CGContextSetLineWidth(context, 1.0);
	float startAngle = M_PI + atan2(center.y - startPoint.y, center.x - startPoint.x);
	float endAngle = M_PI + atan2(center.y - endPoint.y, center.x - endPoint.x);
	CGContextAddArc(context , center.x, center.y, radius, startAngle, endAngle, 1-(clockwise+1)/2); // 1 = cc, 0 = clockwise
	CGContextStrokePath(context);	
	CGContextClosePath(context);
}

@end

@implementation DirectedPath

@end
