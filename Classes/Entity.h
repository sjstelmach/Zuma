//
//  Entity.h
//
//  Objects that have a texture and need to be displayed on the screen.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "GLTexture.h"

@interface Entity : NSObject {
	GLTexture * gltexture;
	CGPoint loc;
}

@property(readonly) CGPoint loc;

- (void) draw;

@end
