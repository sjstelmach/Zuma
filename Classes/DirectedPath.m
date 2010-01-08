//
//  DirectedPath.m
//  Zuma
//
//  Created by Andy Lei on 1/7/10.
//  Copyright 2010 Harvard. All rights reserved.
//

#import "DirectedPath.h"

float CGPointDistSquared(CGPoint p1, CGPoint p2)
{
	float dy = p1.y - p2.y;
	float dx = p1.x - p2.x;
	return dx * dx + dy * dy;
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
		startPoint = st;
		endPoint = ed;
		clockwise = dir ? -1 : 1;
		
		// from http://www.sonoma.edu/users/w/wilsonst/Papers/Geometry/circles/default.html
		CGFloat d = sqrt(CGPointDistSquared(startPoint, endPoint));
		CGFloat inSquareroot = sqrt((pow(2*rad,2)-pow(d,2))*pow(d,2));
		CGFloat plusMinus = (endPoint.y - startPoint.y)/(2*pow(d,2))*inSquareroot;
		CGFloat minusPlus = (endPoint.x - startPoint.x)/(2*pow(d,2))*inSquareroot;
		CGPoint origin1 = CGPointMake((startPoint.x + endPoint.x)/2 + plusMinus,
									  (startPoint.y + endPoint.y)/2 - minusPlus);
		CGPoint origin2 = CGPointMake((startPoint.x + endPoint.x)/2 - plusMinus,
									  (startPoint.y + endPoint.y)/2 + minusPlus);
		// if sign matches
		if(angleBetween(startPoint, endPoint)/dir > 0){
			center = origin1;
		}
		else {
			center = origin2;
		}
	}
	return self;
}
								 
@end

@implementation DirectedPath

@end
