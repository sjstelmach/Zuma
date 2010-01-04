//
//  GLESGameState.h
//  Test_Framework
//
//  Created by Joe Hogue and Paul Zirkle
//

#import <Foundation/Foundation.h>
#import "GameState.h"

@interface GLESGameState : GameState {

}

- (void) startDraw;
- (void) swapBuffers;
- (BOOL) bindLayer;
+ (void) setup2D;

-(id) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager;

@end
