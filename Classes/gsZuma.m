//
//  gsZuma.m
//

#import "gsZuma.h"
#import "gsMainMenu.h"
#import "Ball.h"

@implementation gsZuma

@synthesize path, ball;

-(gsZuma*) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager 
{
	self = [super initWithFrame:frame andManager:pManager];
	
	Path * tPath = [[Path alloc] init];
	[tPath createSquiqqlePath:300 bounds:self.bounds];
	[self setPath: tPath];

	Ball *tBall = [[Ball alloc] initWithColor:[UIColor blueColor]];
	[self setBall:tBall];
	[self.layer addSublayer:ball];
	
	[self setNeedsDisplay];
	
	return self;
}

-(void) Render
{
	//[self setNeedsDisplay];
}

-(void) drawRect:(CGRect) rect 
{
	CGContextRef g = UIGraphicsGetCurrentContext();
	//fill background with blue
	CGContextSetFillColorWithColor(g, [UIColor blackColor].CGColor);
	CGContextFillRect(g, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
	[path drawPath:g];	
}
@end
