//
//  Ball.m
//  Zuma
//
//  Created by Steven Stelmach on 1/6/10.
//  Copyright 2010 Harvard University. All rights reserved.
//

#import "Ball.h"


@implementation Ball

@synthesize _color;
@synthesize path;

-(Ball *)initWithColor: (UIColor *) color {
	return [self initWithColor: color
						 atPos: CGPointMake(0.0f, 0.0f)
						onPath: nil];
}

-(Ball *)initWithColor: (UIColor *) color atPos: (CGPoint) pos {
	return [self initWithColor: color
						 atPos: pos
						onPath: nil];
}

-(Ball *)initWithColor: (UIColor *) color onPath: (Path *) pth {
	return [self initWithColor: color
						 atPos: CGPointMake(0.0f, 0.0f)
						onPath: pth];
}

-(Ball *)initWithColor: (UIColor *) color atPos: (CGPoint) pos onPath: (Path *) pth {
	if (self = [super init]) {
		_color = color;
		UIImage *ballImage = [UIImage imageNamed:@"coloredwheel.png"];
		self.contents = (id)[ballImage CGImage];
		self.bounds = CGRectMake(0.0f, 0.0f, ballImage.size.width, ballImage.size.height);
		self.position = pos;
		path = pth;
	}
	return self;
}


@end
