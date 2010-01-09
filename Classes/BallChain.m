//
//  BallChain.m
//  Zuma
//
//  Created by Andy Lei on 1/9/10.
//  Copyright 2010 Harvard. All rights reserved.
//

#import "BallChain.h"


@implementation BallChain

- (float) speed
{
	return speed;
}

- (void) setSpeed:(float)spe
{
	NSEnumerator * e = [balls objectEnumerator];
	Ball * b;
	while (b = [e nextObject]) {
		[b setSpeed:spe];
	}
}

- (BallChain *) initOnPath: (DirectedPath *) pth
		   withNumberBalls: (int) num
				 withSpeed: (float) spe
			 withNumColors: (int) colors
{
	Ball * b;
	if (self = [super init]) {
		posOnPath = 0.0f;
		path = pth;
		balls = [[NSMutableArray arrayWithCapacity:num] retain];
		speed = spe;
		for (int i = 0; i < num; i++) 
		{
			UIColor * c = nil;	// TODO: pick a random color
			b = [[Ball alloc] initWithColor:c onPath:pth];
			[b setSpeed:spe];
			[b movebyDist: ((float) -i) * BALLRADIUS * 2.0f];
			[balls addObject: b];
		}
	}
	return self;
}

/*
 * updates the location (based on speed) by one frame
 */
- (void) move
{
	[self moveByNumFrames:1];
}
/*
 * updates the location (based on speed) by num frames
 */
- (void) moveByNumFrames: (int) num
{
	posOnPath += speed * num;
	NSEnumerator * e = [balls objectEnumerator];
	Ball * b;
	while (b = [e nextObject]) {
		[b moveByFrames:num];
	}
}
- (void) draw
{
	NSEnumerator * e = [balls objectEnumerator];
	Ball * b;
	while (b = [e nextObject]) {
		[b draw];
	}
}

- (void) dealloc
{
	[balls release];
	[super dealloc];
}

@end
