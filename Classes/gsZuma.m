//
//  gsZuma.m
//  game state in which you actually play teh zuma
//

#import "gsZuma.h"
#import "gsMainMenu.h"
#import "Ball.h"
#import "DirectedPath.h"

@implementation gsZuma

-(gsZuma*) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager 
{
	self = [super initWithFrame:frame andManager:pManager];
	
	Path * tPath = [[Path alloc] init];
	[tPath createSquiqqlePath:300 
					   bounds:self.bounds];
	path = tPath;
	
	p = [[[DirectedPath alloc] initWithStart: CGPointMake(50.0f, 50.0f)] retain];
	[p addLineSegmentWithNextPoint: CGPointMake(50.0f, 100.0f)];
	[p addLineSegmentWithNextPoint: CGPointMake(100.0f, 100.0f)];
	[p addArcSegmentWithNextPoint: CGPointMake(150.0f, 150.0f) 
					   withRadius: 50.0f
				   andIsClockwise: true];
	ArcSegment * a = (ArcSegment *)[p.segments objectAtIndex:2];
	NSLog([NSString stringWithFormat:@"angle: %f\n", a->angle / M_PI * 180]);
	NSLog([NSString stringWithFormat:@"initAngle: %f\n", a->initialAngle / M_PI * 180]);
	NSLog([NSString stringWithFormat:@"length: %f\n", a.length]);
	CGPoint c = [a pointFromStartWithOffset:a.length / 2];
	NSLog([NSString stringWithFormat:@"midpoint: (%f, %f)\n", c.x, c.y]);
	
	Ball *tBall = [[Ball alloc] initWithColor:[UIColor blueColor] 
										atPos: c];
	ball = tBall;
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

	CGPoint start = CGPointMake(50, 250);
	CGPoint end = CGPointMake(100, 350);
	ArcSegment *arc = [[ArcSegment alloc] initWithStart:start withEnd:end withRadius: 56 andIsClockwise:YES];
	[arc draw];
	
	[p draw];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	/*CAKeyframeAnimation *animation;
	animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	animation.speed = .01;
	
	animation.rotationMode = kCAAnimationRotateAuto;
	animation.path = path.path;
	animation.repeatCount = 1e100f;
	
	animation.timingFunctions = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.calculationMode = kCAAnimationPaced;
	
	[ball addAnimation:animation forKey: @"balls"];*/
	
}


@end
