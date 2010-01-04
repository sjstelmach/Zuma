//
//  gsStorageTest.h
//  Chapter3 Framework
//
//  Created by Joe Hogue and Paul Zirkle
//

#import <Foundation/Foundation.h>

#include "GameState.h"

@interface gsStorageTest : GameState {
	IBOutlet UIView* subview;
	IBOutlet UISwitch* toggle;
}

- (void) runTests;
- (IBAction) toggled;
- (IBAction) back;

@end
