//
//  BallShooter.h
//  Zuma
//
//  Created by Steven Stelmach on 1/10/10.
//  Copyright 2010 Harvard University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ball.h"
#import "GLTexture.h"

#define BALL_SHOOTER_SPEED 3

@interface BallShooter : NSObject {
	GLTexture * gltexture;
	float angle; // in radians
	CGPoint _loc;
	Ball * toBeFired;
	float shootingSpeed;
}

- (BallShooter *) initWithLoc: (CGPoint) loc;
- (void) moveToLoc: (CGPoint) loc;
- (void) aimAt: (CGPoint) aimTo;
- (Ball *) fire;
- (void) draw;

@end
