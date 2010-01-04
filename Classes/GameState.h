//
//  GameState.h
//  Test_Framework
//
//  Created by Joe Hogue and Paul Zirkle
//

#import <UIKit/UIKit.h>

#import "GameStateManager.h"
#import <UIKit/UIView.h>

@interface GameState : UIView {
	GameStateManager* m_pManager;
}
-(id) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager;
-(void) Render;
-(void) Update;

@end
