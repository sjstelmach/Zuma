//
//  gsZuma.m
//  game state in which you actually play teh zuma
//

#import "gsZuma.h"
#import "gsMainMenu.h"
#import "Ball.h"

@implementation gsZuma

//@synthesize path, ball;

-(gsZuma*) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager 
{
	self = [super initWithFrame:frame andManager:pManager];
	
	Path * tPath = [[Path alloc] init];
	[tPath createSquiqqlePath:300 
					   bounds:self.bounds];
	path = tPath;

	Ball *tBall = [[Ball alloc] initWithColor:[UIColor blueColor] 
										atPos: CGPointMake(50.0f, 50.0f)];
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
	[path drawPath:g];	
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	CAKeyframeAnimation *animation;
	animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	animation.speed = .01;
	
	animation.rotationMode = kCAAnimationRotateAuto;
	animation.path = path.path;
	animation.repeatCount = 1e100f;
	
	animation.timingFunctions = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.calculationMode = kCAAnimationPaced;
	
	[ball addAnimation:animation forKey: @"balls"];
	
}


@end
