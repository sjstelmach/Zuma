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
#import "Entity.h"

#define BALL_SHOOTER_SPEED 3

@interface BallShooter : Entity {
	float angle; // in radians
	Ball * toBeFired;
	float shootingSpeed;
}

/*
 * inits a new BallShooter with loc pos
 */
- (BallShooter *) initWithLoc: (CGPoint) pos;
/*
 * move the instance to pos
 */
- (void) moveToLoc: (CGPoint) pos;
- (void) aimAt: (CGPoint) pos;
- (Ball *) fire;

@end
