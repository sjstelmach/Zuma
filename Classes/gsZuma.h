//
//  gsZuma.h
//  Zuma
//
//  Created by Steven Stelmach on 1/6/10.
//  Copyright 2010 Harvard University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKIt/UIKit.h>
#import "GameState.h"
#import "Path.h"
#import "Ball.h"

@interface gsZuma : GameState{
	Path *path;
	Ball *ball;
}

@end
