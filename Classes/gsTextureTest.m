//
//  gsTextureTest.m
//  Chapter3 Framework
//
//  Created by Joe Hogue and Paul Zirkle
//

#import "gsTextureTest.h"
#import "ResourceManager.h"
#import "gsMainMenu.h"

@implementation gsTextureTest

- (void) Render {
	//clear anything left over from the last frame, and set background color.
	glClearColor(0xff/256.0f, 0x66/256.0f, 0x00/256.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	
	//render textures here.
	//some rendering offsets
	int yspacing = -24, line = 0, yoff = 360;
	int leftcolumn = 10;
	
	//test our GLFont
	[[g_ResManager defaultFont] drawString:@"Font ok." atPoint:CGPointMake(leftcolumn, yoff+yspacing*line++)];
	
	//draw the scissors image, with a label.
	[[g_ResManager defaultFont] drawString:@"GLTexture test:" atPoint:CGPointMake(leftcolumn, yoff+yspacing*line++)];
	//make the image waggle back and forth.
	float x = (1+sin([[NSDate date] timeIntervalSince1970])) * self.frame.size.width / 2;
	[[g_ResManager getTexture:@"scissors.png"] drawAtPoint:CGPointMake(x, yoff+yspacing*line++)];
	yoff -= [[g_ResManager getTexture:@"scissors.png"] contentSize].height;
	
	//draw the clipped drawregion image, with a label.
	[[g_ResManager defaultFont] drawString:@"Clipped image test:" atPoint:CGPointMake(leftcolumn, yoff+yspacing*line++)];
	[[g_ResManager getTexture:@"drawregion.png"] drawInRect:CGRectMake(leftcolumn, yoff+yspacing*line++, 20, 20) withClip:CGRectMake(15, 30, 20, 20) withRotation:0];
	
	//you get a nice boring white screen if you forget to swap buffers.
	[self swapBuffers];
}

-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	UITouch* touch = [touches anyObject];
	NSUInteger numTaps = [touch tapCount];
	if (numTaps > 1) {
		[m_pManager doStateChange:[gsMainMenu class]];
	}
}
@end
