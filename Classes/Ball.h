//
//  Ball.h
//  Zuma
//
//  Created by Steven Stelmach on 1/6/10.
//  Copyright 2010 Harvard University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface Ball : Entity {
	@private
	UIColor *_color;
}

-(Ball *)initWithColor: (UIColor *) color;

@property (retain) UIColor *_color;
@end
