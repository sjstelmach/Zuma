//
//  DirectedPath.h
//  Zuma
//
//  Created by Andy Lei on 1/7/10.
//  Copyright 2010 Harvard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>

inline float CGPointDistSquared(CGPoint p1, CGPoint p2);

@interface Segment : NSObject
{
	CGPoint startPoint;
	CGPoint endPoint;
	float length;
}

/*
 * the point on the segment @dist after @point
 * if @point is not on the segment or @dist is too great, returns @point
 */
- (CGPoint) nextPointAfter: (CGPoint) point withOffset: (float) dist;
- (Boolean) containsPoint: (CGPoint) point;

@end


@interface LineSegment : Segment
{
	CGPoint dir; // unit vector pointing from startPoint to endPoint
}

- (LineSegment *) initWithStart: (CGPoint) st andEnd: (CGPoint) ed;

@end

/*
 * ArcSegments have angle <= 180 deg
 */
@interface ArcSegment : Segment
{
	CGPoint center;
	float radius;
	float angle;
	Boolean clockwise;
	float initialAngle;
}

- (ArcSegment *) initWithStart: (CGPoint) st 
					   withEnd: (CGPoint) ed 
					withRadius: (CGFloat) rad
				andIsClockwise: (Boolean) dir;

@end


@interface DirectedPath : NSObject {
	NSMutableArray * segments;
}

@end
