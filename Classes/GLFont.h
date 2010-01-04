//
//  GLFont.h
//  Test_Framework
//
//  Created by Joe Hogue and Paul Zirkle
//

#import <Foundation/Foundation.h>
#import "GLTexture.h"

typedef struct {
	unichar character;
	GLfloat tx, ty, tx2, ty2; //texture position and height.
	GLfloat pw, ph; //width and height in pixels.
} Glyph;

@interface GLFont : GLTexture {
	int fontdata_length;
	Glyph* fontdata;
	GLfloat charspacing; //the extra spacing between letters.  will typically be negative, to consume padding.
}

- (void) drawString:(NSString*)string atPoint:(CGPoint)point;

- (id) initWithString:(NSString*)string fontName:(NSString*)name fontSize:(CGFloat)size;
- (id) initWithString:(NSString*)string fontName:(NSString*)name fontSize:(CGFloat)size strokeWidth:(CGFloat)strokeWidth fillColor:(UIColor*)fillColor strokeColor:(UIColor*)strokeColor;

@end
