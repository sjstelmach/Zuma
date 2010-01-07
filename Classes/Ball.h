//
//  Ball.h
//  Zuma
//
//  Created by Steven Stelmach on 1/6/10.
//  Copyright 2010 Harvard University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "Path.h"

@interface Ball : Entity {
	@private
	UIColor *_color;
	Path * path;
}

-(Ball *)initWithColor: (UIColor *) color;
-(Ball *)initWithColor: (UIColor *) color atPos: (CGPoint) pos;
-(Ball *)initWithColor: (UIColor *) color onPath: (Path *) pth;
	// it's unlikely that you'd init a ball with an absolute position and a path
	// this method only exists for DRYness
-(Ball *)initWithColor: (UIColor *) color atPos: (CGPoint) pos onPath: (Path *) pth;

@property (retain) UIColor *_color;
@property (retain) Path * path;
@end
