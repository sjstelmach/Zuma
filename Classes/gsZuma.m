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
		
		p = [[[DirectedPath alloc] initWithStart: CGPointMake(50.0f, 50.0f)] retain];
		[p addLineSegmentWithNextPoint: CGPointMake(50.0f, 100.0f)];
		[p addLineSegmentWithNextPoint: CGPointMake(100.0f, 100.0f)];
		[p addArcSegmentWithNextPoint: CGPointMake(150.0f, 150.0f) 
						   withRadius: 50.0f
					   andIsClockwise: true];
		[p addArcSegmentWithNextPoint: CGPointMake(300.0f, 300.0f) 
						   withRadius: 200.0f
					   andIsClockwise: false];
		
		ArcSegment * a = (ArcSegment *)[p.segments objectAtIndex:2];
		CGPoint c = [a pointFromStartWithOffset:a.length / 2];
		
		
		Ball *tBall = [[[Ball alloc] initWithColor:[UIColor blueColor] 
											atPos: c
									 withVelocity: CGPointMake(0.1, 0.2)] retain];
		ball = tBall;
	}
	return self;
}

- (void) Update
{
	[ball move];
}

-(void) Render
{
		//clear anything left over from the last frame, and set background color.
	glClearColor(0x00/256.0f, 0x00/256.0f, 0x00/256.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[ball draw];
	
		//you get a nice boring white screen if you forget to swap buffers.
	[self swapBuffers];
}

//-(void) drawRect:(CGRect) rect 
//{
//	CGContextRef g = UIGraphicsGetCurrentContext();
//	//fill background with black
//	CGContextSetFillColorWithColor(g, [UIColor blackColor].CGColor);
//	CGContextFillRect(g, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
//	
//	[p drawInContext:g];
//	[ball drawInContext:g];
//}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[ball setVelocity:CGPointMake((float)(random()-RAND_MAX/2)/RAND_MAX*10, (float)(random()-RAND_MAX/2)/RAND_MAX*10)];
}


@end
