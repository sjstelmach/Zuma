//
//  gsSoundTest.m
//  Chapter3 Framework
//
//  Created by Joe Hogue and Paul Zirkle
//

#import "gsSoundTest.h"
#import "ResourceManager.h"
#import "gsMainMenu.h"

@implementation gsSoundTest

-(gsSoundTest*) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager 
{
	if(self = [super initWithFrame:frame andManager:pManager]) {
		//load the soundtest.xib file here.
		//this will instantiate the 'subview' uiview.
		[[NSBundle mainBundle] loadNibNamed:@"soundtest" owner:self options:nil];
		//add subview as... a subview.
		//this will let everything from the nib file show up on screen.
		[self addSubview:subview];
	}
	return self;
}

-(IBAction) playCafSfx {
	[g_ResManager playSound:@"tap.caf"];
}

-(IBAction) playMp3 {
	[g_ResManager playMusic:@"social.mp3"];
}

-(IBAction) stopMusic {
	[g_ResManager stopMusic];
}

-(IBAction) back {
	[m_pManager doStateChange:[gsMainMenu class]];
}

@end
