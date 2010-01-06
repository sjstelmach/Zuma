//
//  gsZuma.m
//

#import "gsZuma.h"
#import "gsMainMenu.h"

@implementation gsZuma

-(void)Render{
	CGContextRef g = UIGraphicsGetCurrentContext(); 
	//fill background with blue 
	CGContextSetFillColorWithColor(g, [UIColor blueColor].CGColor); 
	CGContextFillRect(g, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
	//draw text in black 
	CGContextSetFillColorWithColor(g, [UIColor blackColor].CGColor);
	[@"it works!" drawAtPoint:CGPointMake(10.0,20.0) withFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
}

@end
