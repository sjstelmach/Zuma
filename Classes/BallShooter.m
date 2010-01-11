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
- (BallShooter *) initWithLoc: (CGPoint) loc
{
	if(self = [super init]){
		gltexture = [g_ResManager getTexture:@"shooter.png"];
		angle = 0;
		_loc = loc;
		toBeFired = [[Ball alloc] initWithColor: BALL_BLUE atPos: _loc withVelocity: CGPointMake(0,0)];
		shootingSpeed = SHOOTER_SPEED;
		return self;
	}
	
	return nil;
}
- (void) moveToLoc: (CGPoint) loc{
	_loc = loc;
}
- (void) aimAt: (CGPoint) aimTo{
	angle = -atan2(aimTo.y-_loc.y, aimTo.x-_loc.x);
}
- (Ball *) fire{
	Ball * fired = toBeFired;
	fired.velocity = CGPointMake(shootingSpeed*cos(angle), shootingSpeed*sin(angle));
	toBeFired = [[Ball alloc] initWithColor: BALL_BLUE atPos: _loc withVelocity: CGPointMake(0,0)];
	return fired;
}
- (void) draw{
	[toBeFired draw];
	[gltexture drawAtPoint:_loc withRotation: angle*180/M_PI withScale: 1.0f];	
}


@end
