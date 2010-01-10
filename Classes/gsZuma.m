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
		
		ArcSegment * a = (ArcSegment *)[p.segments objectAtIndex:2];
		
		ballchain = [[BallChain	alloc] initOnPath:p withNumberBalls:30 withSpeed:3.0 withNumColors:3];
		[ballchain retain];
	}
	return self;
}

- (void) Update
{
	[ball move];
	[ballchain move];
}

-(void) Render
{
	glLoadIdentity();
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[p draw];
		//[ball draw];
	[ballchain draw];
	
	//you get a nice boring white screen if you forget to swap buffers.
	[self swapBuffers];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[ball setVelocity:CGPointMake((float)(random()-RAND_MAX/2)/RAND_MAX*10, 
								  (float)(random()-RAND_MAX/2)/RAND_MAX*10)];
}


@end
