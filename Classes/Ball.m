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

-(Ball *)initWithColor: (UIColor *) color{
	self = [CALayer layer];

	//self._color = color;
	// switch color
	
	UIImage *ballImage = [UIImage imageNamed:@"coloredwheel.png"];
	self.contents = (id)[ballImage CGImage];
	self.bounds = CGRectMake(0.0f, 0.0f, ballImage.size.width, ballImage.size.height);
	self.position = CGPointMake(50.0f, 50.0f);
	return self;
	
}


@end
