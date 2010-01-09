//
//  Ball.h
//  Zuma
//
//  Created by Steven Stelmach on 1/6/10.
//  Copyright 2010 Harvard University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLTexture.h"
#import "ResourceManager.h"
#import "Path.h"
#import "DirectedPath.h"

//CONSTANTS:

typedef enum {
	BALL_RED,
	BALL_GREEN,
	BALL_BLUE,
	BALL_YELLOW,
	BALL_WHITE,
	BALL_BLACK,
} BallColor;

#define BALLRADIUS 15.0f

@interface Ball : NSObject {
	BallColor _color;
	GLTexture * gltexture;
	DirectedPath * path;
	float pathPos;
	float speed; // speed of the ball
	float angle; // angle of the ball in radians
	CGPoint velocity; // velocity vector 
	CGPoint loc;
}

@property float speed;
@property CGPoint velocity;
@property(readonly) CGPoint loc;

/*
 * creates a ball with a color.  this is only used internally for DRYness.
 *  you should use the other two init functions b/c other methods assume
 *  that init'd Balls have either a path or nonzero velocity.
 */
- (Ball *) initWithColor: (BallColor) color;
/*
 * creates a ball with a position and a velocity
 */
- (Ball *) initWithColor: (BallColor) color 
					atPos: (CGPoint) pos 
			withVelocity: (CGPoint) vel;
/*
 * creates a ball, sticks it at the beginning of the path
 */
- (Ball *) initWithColor: (BallColor) color onPath: (DirectedPath *) pth;

/*
 * attaches the ball to a path at the beginning of the path
 */
- (void) attachToPath: (DirectedPath *) pth;
/*
 * attaches the ball to a path offset into the path
 */
- (void) attachToPath: (DirectedPath *) pth withOffset: (float) offset;
/*
 * advances the ball by one frame (based on speed)
 *  returns the new position of the ball
 */
- (CGPoint) move;
/*
 * advances the ball by numFrames frames (based on speed)
 *  returns the new position of the ball
 */
- (CGPoint) moveByFrames: (int) numFrames;
/*
 * advances ball by dist
 */
- (CGPoint) movebyDist: (float) dist;

- (void) draw;

@end
