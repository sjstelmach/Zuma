//
//  BallShooter.m
//  Zuma
//
//  Created by Steven Stelmach on 1/10/10.
//  Copyright 2010 Harvard University. All rights reserved.
//

#import "BallShooter.h"
#import "ResourceManager.h"
#import <math.h>

@implementation BallShooter

#define SHOOTER_SPEED 10

- (BallShooter *) initWithLoc: (CGPoint) pos
{
	if(self = [super init]){
		gltexture = [g_ResManager getTexture:@"shooter.png"];
		angle = 0;
		loc = pos;
		toBeFired = [[Ball alloc] initWithColor:BALL_BLUE 
										  atPos: loc 
								   withVelocity: CGPointMake(0,0)];
		shootingSpeed = SHOOTER_SPEED;
		return self;
	}
	
	return nil;
}

- (void) moveToLoc: (CGPoint) pos{
	loc = pos;
}

- (void) aimAt: (CGPoint) pos{
	angle = -atan2(pos.y - loc.y, pos.x - loc.x);
}

- (Ball *) fire{
	Ball * fired = toBeFired;
	fired.velocity = CGPointMake(shootingSpeed * cos(angle), 
								 shootingSpeed * sin(angle));
	toBeFired = [[Ball alloc] initWithColor:BALL_BLUE 
									  atPos:loc 
							   withVelocity: CGPointMake(0,0)];
	return fired;
}

- (void) draw{
	[toBeFired draw];
	[gltexture drawAtPoint:loc 
			  withRotation:angle * 180 / M_PI 
				 withScale:1.0f];
}

@end
