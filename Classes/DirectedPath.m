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

- (ArcSegment *) initWithStart: (CGPoint) st 
						withEnd: (CGPoint) ed 
					 withOrigin: (CGPoint) cent
				   andIsClockwise: (Boolean) dir
{
	if (self = [super init]) {
		startPoint = st;
		endPoint = ed;
		clockwise = dir;
		center = cent;
			// ensure that the circle is properly specified
		float d1 = CGPointDistSquared(st, cent);
		float d2 = CGPointDistSquared(ed, cent);
		if (d1 - d2 < EPISLON) {
			[self dealloc];
			return nil;
		}
		radius = sqrt(d1);
		CGPoint v1 = CGPointMake((st.x - cent.x) / radius,
								 (st.y - cent.y) / radius);
		CGPoint v2 = CGPointMake((ed.x - cent.x) / radius,
								 (ed.y - cent.y) / radius);
		angle = acos(v1.x * v2.x + v1.y * v2.y);
	}
	return self;
}

@end



@implementation DirectedPath

@end
