//
//  gsZuma.h
//  Zuma
//
//  Created by Steven Stelmach on 1/6/10.
//  Copyright 2010 Harvard University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLESGameState.h"
#import "Path.h"
#import "Ball.h"
#import "BallShooter.h"
#import "BallChain.h"
#import "DirectedPath.h"

// unlikely that we'd make a level w/ > 5 paths
#define NUM_PATHS 5

@interface gsZuma : GLESGameState{
	NSMutableArray * freeballs; // (Ball) balls not attached to paths
	BallShooter * ballshooter;
	DirectedPath * paths[NUM_PATHS];
	NSMutableArray * ballchains;// (BallChain) ballchains
	GLTexture * background;
	bool readyToFire;
}

@end
