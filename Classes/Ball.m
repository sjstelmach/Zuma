//
//  Ball.m
//  Zuma
//
//  Created by Steven Stelmach on 1/6/10.
//  Copyright 2010 Harvard University. All rights reserved.
//

#import <math.h>
#import "Ball.h"


@implementation Ball

@synthesize loc, velocity;

- (float) speed
{
	return speed;
}

/*
 * sets the speed of the ball
 *  if the ball has a path, sets the speed directly
 *  otherwise, assumes the ball has a velocity, and scales the velocity
 *  to have magnitude sp
 */
- (void) setSpeed: (float) sp
{
	if (!path) {
		velocity.x = velocity.x / speed * sp;
		velocity.y = velocity.y / speed * sp;
	}
	speed = sp;
}

-(Ball *)initWithColor: (UIColor *) color {
	if (self = [super init]) {
		_color = color;
		gltexture = [g_ResManager getTexture:@"red.png"];
		loc = CGPointMake(0.0f, 0.0f);
		path = nil;
		pathPos = 0.0f;
		speed = 0.0f;
		velocity = CGPointMake(0.0f, 0.0f);
	}
	return self;
}

- (Ball *) initWithColor: (UIColor *) color 
				   atPos: (CGPoint) pos 
			withVelocity: (CGPoint) vel 
{
	if (self = [self initWithColor: color]) {
		loc = pos;
		velocity = vel;
		speed = sqrt(vel.x * vel.x + vel.y * vel.y);
	}
	return self;
}

-(Ball *)initWithColor: (UIColor *) color onPath: (DirectedPath *) pth {
	if (self = [self initWithColor: color]) {
		// todo: some sort of speed variable
		speed = 1;
		[self attachToPath: pth];
	}
	return self;
}

- (void) attachToPath: (DirectedPath *) pth
{
	[self attachToPath:pth withOffset:0.0f];
}

- (void) attachToPath: (DirectedPath *) pth withOffset: (float) offset
{
	path = pth;
	pathPos = offset;
	loc = [path pointAtOffset: offset];
}

- (CGPoint) move
{
	return [self moveByFrames:1];
}

- (CGPoint) moveByFrames: (int) numFrames
{
	if (path) {
		pathPos += speed * numFrames;
		loc = [path pointAtOffset: pathPos];
		angle = [path tangentAtOffset: pathPos];
	} else {
		loc.x += numFrames * velocity.x;
		loc.y += numFrames * velocity.y;
		angle = atan(velocity.y/velocity.x);
	}
	return loc;
}

- (CGPoint) movebyDist: (float) dist
{
	if (path) {
		pathPos += dist;
		loc = [path pointAtOffset: pathPos];
	} else {
		loc.x += dist * velocity.x / speed;
		loc.y += dist * velocity.y / speed;
	}
	return loc;
}

- (void) draw
{
	[gltexture drawAtPoint:loc withRotation: angle*180/M_PI withScale: 1.0f];
}

@end
