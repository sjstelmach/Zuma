//
//  DirectedPath.h
//  Zuma
//
//  Created by Andy Lei on 1/7/10.
//  Copyright 2010 Harvard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>

float CGPointDistBetween(CGPoint p1, CGPoint p2);

@interface Segment : NSObject
{
	CGPoint startPoint;
	CGPoint endPoint;
	float length;
}

@property(readonly) CGPoint startPoint;
@property(readonly) CGPoint endPoint;
@property(readonly) float length;

- (CGPoint) pointFromStartWithOffset: (float) dist;
- (Boolean) containsPoint: (CGPoint) point;
- (void) draw;

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
	CGPoint start;
	CGPoint end;
	float length;
}

- (DirectedPath *) initWithStart: (CGPoint) point;
- (void) addLineSegmentWithNextPoint: (CGPoint) point;
- (void) addArcSegmentWithNextPoint: (CGPoint) point 
						 withRadius: (float) rad 
					 andIsClockwise: (Boolean) dir;
- (CGPoint) pointAtOffset: (float) dist;
@private

- (void) addSegment: (Segment *) seg;

@end
