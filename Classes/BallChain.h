//
//  BallChain.h
//  Zuma
//
//  Created by Andy Lei on 1/9/10.
//  Copyright 2010 Harvard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectedPath.h"
#import "Ball.h"

@interface BallChain : NSObject 
{
	NSMutableArray * balls; // balls in the chain; zeroth ball is ball furthest 
							// from path origin
	DirectedPath * path;
	float posOnPath;		// how far on the path balls[0] is located
	float speed;
}

@property float speed;

/*
 * ball chains are generally created when they are spawned at the path source
 */
- (BallChain *) initOnPath: (DirectedPath *) pth
		   withNumberBalls: (int) num
				 withSpeed: (float) spe
			 withNumColors: (int) colors;
/*
 * updates the location (based on speed) by one frame
 */
- (void) move;
/*
 * updates the location (based on speed) by num frames
 */
- (void) moveByNumFrames: (int) num;
- (void) draw;

//- (void) insertBall: (Ball *) ball atPos: (int) pos;
//- (int) checkMatch;

@end
