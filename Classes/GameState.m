//
//  GameState.m
//  Test_Framework
//
//  Created by Joe Hogue and Paul Zirkle
//

#import "GameState.h"


@implementation GameState


-(id) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager;
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		m_pManager = pManager;
		self.userInteractionEnabled = true;
    }
    return self;
}

- (void) Update 
{
	
}

- (void) Render
{
	
}

- (void)drawRect:(CGRect)rect {
}


- (void)dealloc {
    [super dealloc];
}


@end
