//
//  Path.m
//  Paths

#import "Path.h"


@implementation Path

- (CGPathRef)path {
	return _path;
}

- (void)setPath:(CGPathRef)value {
	value = CGPathRetain(value);
	CGPathRelease(_path);
	_path = value;
}


- (void)drawPath:(CGContextRef)context {
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	
	float dashes[2] = {3,6};
	CGContextAddPath(context, _path);
	CGContextSetLineWidth(context, 1.0);
	CGContextSetLineDash(context, 0, dashes, 2);
	CGContextStrokePath(context);
}

/**
 * Create a complicated path with Bezier curves.
 */
- (void)createSquiqqlePath:(int)size bounds:(CGRect)bounds {
	CGPoint center = CGPointMake(bounds.size.width/2 - size/2, bounds.size.height/2 - size/2);
	CGPoint point1 = CGPointMake(center.x + 50, center.y + 50);
	CGPoint point2 = CGPointMake(center.x + size * 0.6, center.y + size * 0.3);
	CGPoint point3 = CGPointMake(center.x + size * 0.6, center.y + size * 0.9);
	CGPoint point4 = CGPointMake(center.x + size * 0.9, center.y + size * 0.8);
	
	CGPoint controlPoint1 = CGPointMake(center.x + size * 0.1, center.y + size * 0.9);
	CGPoint controlPoint2 = CGPointMake(center.x + size * 0.1, center.y + size * 0.2);
	CGPoint controlPoint3 = CGPointMake(center.x + size * 0.4, center.y + size * 0.8);
	CGPoint controlPoint4 = CGPointMake(center.x + size * 0.3, center.y + size * 0.5);
	CGPoint controlPoint5 = CGPointMake(center.x + size * 0.9, center.y + size * 0.1);
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, point1.x, point1.y);
	CGPathAddCurveToPoint(path, 
						  NULL, 
						  controlPoint1.x,
						  controlPoint1.y, 
						  controlPoint2.x, 
						  controlPoint2.y, 
						  point2.x, 
						  point2.y);
	CGPathAddCurveToPoint(path, 
						  NULL, 
						  controlPoint3.x,
						  controlPoint3.y, 
						  controlPoint2.x, 
						  controlPoint2.y, 
						  point3.x, 
						  point3.y);
	CGPathAddCurveToPoint(path, 
						  NULL, 
						  controlPoint4.x,
						  controlPoint4.y, 
						  controlPoint5.x, 
						  controlPoint5.y, 
						  point4.x, 
						  point4.y);
	CGPathCloseSubpath(path);
	[self setPath:path];
	CGPathRelease(path);
}



@end
