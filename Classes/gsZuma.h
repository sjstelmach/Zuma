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

@interface gsZuma : GLESGameState{
	Path * path;
	Ball * shotBall;
	BallShooter * ballshooter;
	DirectedPath * p;
	BallChain * ballchain;
	GLTexture * background;
	bool readyToFire;
}

@end
