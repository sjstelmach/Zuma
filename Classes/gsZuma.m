//
//  gsZuma.m
//  game state in which you actually play teh zuma
//


#import "gsZuma.h"
#import "ResourceManager.h"
#import "gsMainMenu.h"
#import "Ball.h"
#import "DirectedPath.h"

@implementation gsZuma

-(gsZuma*) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager 
{
	if (self = [super initWithFrame:frame andManager:pManager])
	{
		
		p = [[[DirectedPath alloc] initWithStart: CGPointMake(50.0f, 120.0f)] 
			 retain];
		[p addLineSegmentWithNextPoint: CGPointMake(50.0f, 320.0f)];
		[p addArcSegmentWithNextPoint: CGPointMake(250.0f, 320.0f) 
						   withRadius: 100.0f
					   andIsClockwise: true];
		[p addLineSegmentWithNextPoint: CGPointMake(250.0f, 120.0f)];
		[p addArcSegmentWithNextPoint: CGPointMake(0.0f, 120.0f) 
						   withRadius: 125.0f
					   andIsClockwise: true];
		
		ballchain = [[BallChain	alloc] initOnPath:p withNumberBalls:30 withSpeed:1.0 withNumColors:3];
		[ballchain retain];
		
		ballshooter = [[BallShooter alloc] initWithLoc:CGPointMake(160, 240)];
		
		background = [g_ResManager getTexture:@"spacebackground.png"];

	}
	return self;
}

- (void) Update
{
	// todo: release shot ball if it's off of the screen
	[shotBall move];
	[ballchain move];
}

-(void) Render
{
	glLoadIdentity();
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[background drawAtPoint:CGPointMake(160, 240)];

	[p draw];
	[shotBall draw];
	[ballchain draw];
	[ballshooter draw];
	
	
	//you get a nice boring white screen if you forget to swap buffers.
	[self swapBuffers];
}


// TODO: get canceling working propertly, and potentially some sort of tracking line
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	NSSet *allTouches = [event allTouches];
	UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
	[ballshooter aimAt:[touch locationInView:self]];	
	readyToFire = YES;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	NSSet *allTouches = [event allTouches];
	UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
	[ballshooter aimAt:[touch locationInView:self]];	
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	readyToFire = NO;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	if(readyToFire){
		shotBall = [ballshooter fire];
		readyToFire = NO;
	}
}

@end
