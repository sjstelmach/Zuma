//
//  gsSoundTest.h
//  Chapter3 Framework
//
//  Created by Joe Hogue and Paul Zirkle
//

#import <Foundation/Foundation.h>

#include "GameState.h"

@interface gsSoundTest : GameState {
	IBOutlet UIView* subview;
}

-(IBAction) playCafSfx;
-(IBAction) playMp3;
-(IBAction) stopMusic;
-(IBAction) back;

@end
