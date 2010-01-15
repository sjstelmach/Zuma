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
		/* ==== all this stuff should be handled by the level obj ==== */
			// init ball paths
		paths[0] = [[[DirectedPath alloc] initWithStart: CGPointMake(50.0f, 120.0f)] 
			 retain];
		for (int i = 1; i < NUM_PATHS; i++) {
			paths[i] = nil;
		}
		[paths[0] addLineSegmentWithNextPoint: CGPointMake(50.0f, 320.0f)];
		[paths[0] addArcSegmentWithNextPoint: CGPointMake(250.0f, 320.0f) 
								  withRadius: 100.0f
							  andIsClockwise: true];
		[paths[0] addLineSegmentWithNextPoint: CGPointMake(250.0f, 120.0f)];
		[paths[0] addArcSegmentWithNextPoint: CGPointMake(0.0f, 120.0f) 
								  withRadius: 125.0f
							  andIsClockwise: true];
		
			// init starting ball chains
		ballchains = [[NSMutableArray arrayWithCapacity:5] retain];
		[ballchains addObject:[[BallChain alloc] initOnPath:paths[0]
											withNumberBalls:30
												  withSpeed:1.0
											  withNumColors:3]];
		
			// init freeballs
		freeballs = [[NSMutableArray arrayWithCapacity:5] retain];
		
		ballshooter = [[BallShooter alloc] initWithLoc:CGPointMake(160, 240)];
		
		background = [g_ResManager getTexture:@"spacebackground.png"];
	}
	return self;
}

- (void) Update
{
	// todo: release shot ball if it's off of the screen
	int i = 0;
	
	BallChain * bc;
	int l = [ballchains count];
	while (i < l && (bc = (BallChain *) [ballchains objectAtIndex:i++])) {
		[bc move];
	}
	
	i = 0;
	Ball * b;
	l = [freeballs count];
	while(i < l && (b = (Ball *) [freeballs objectAtIndex:i++])) {
		[b move];
	}
}

-(void) Render
{
	glLoadIdentity();
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[background drawAtPoint:CGPointMake(160, 240)];
	
	int i = 0;
	DirectedPath * p; 
	Ball * b; 
	BallChain * bc;
	int l = NUM_PATHS;
	while (i < l && (p = paths[i++])) {
		[p draw];
	}
	
	i = 0;
	l = [freeballs count];
	while (i < l && (b = (Ball *)[freeballs objectAtIndex:i++])) {
		[b draw];
	}
	
	i = 0;
	l = [ballchains count];
	while (i < l && (bc = (BallChain *)[ballchains objectAtIndex:i++])) {
		[bc draw];
	}
	
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
		[freeballs addObject:[ballshooter fire]];
		readyToFire = NO;
	}
}
- (void) dealloc {
	int i = 0;
	while (i < NUM_PATHS && paths[i++]) {
		[paths[i] release];
	}
	[ballchains release];
	[freeballs release];
	[super dealloc];
}

@end
