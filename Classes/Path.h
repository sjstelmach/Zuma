//
//  Path.h
//  Paths

#import <Foundation/Foundation.h>


@interface Path : NSObject {
	CGPathRef _path;
	NSArray* _points;
}

- (CGPathRef)path; // expose the CGPathRef obj
- (void)setPath:(CGPathRef)value;
- (void)drawPath:(CGContextRef)context;
- (void)createSquiqqlePath:(int)size bounds:(CGRect)bounds;
@end
