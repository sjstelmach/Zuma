//
//  gsMainMenu.m
//  Chapter3 Framework
//
//  Created by Joe Hogue and Paul Zirkle
//

#import "gsMainMenu.h"
#import "gsSoundTest.h"
#import "gsTextureTest.h"
#import "gsStorageTest.h"

@implementation gsMainMenu

-(gsMainMenu*) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager 
{
	if(self = [super initWithFrame:frame andManager:pManager]) {
		//load the gsMainMenu.xib file here.
		//this will instantiate the 'subview' uiview.
		[[NSBundle mainBundle] loadNibNamed:@"gsmainmenu" owner:self options:nil];
		//add subview as... a subview.
		//this will let everything from the nib file show up on screen.
		[self addSubview:subview];
	}
	return self;
}

- (IBAction) doGraphicsTest {
	[m_pManager doStateChange:[gsTextureTest class]];
}

- (IBAction) doSoundTest {
	[m_pManager doStateChange:[gsSoundTest class]];
}

- (IBAction) doStorageTest {
	[m_pManager doStateChange:[gsStorageTest class]];
}

@end
