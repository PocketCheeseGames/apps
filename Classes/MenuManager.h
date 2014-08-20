//
//  MenuManager.h
//  DREngine
//
//  Created by Rob DelBianco on 3/21/10.
//  Copyright 2010 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTexture.h"
#import "Button.h"

#define MAIN_MENU_STATE		1
#define GAME_MENU_STATE		2
#define EMPTY_MENU_STATE	3


@interface MenuManager : NSObject {
	
	int		nButtonClicked;
	int		nMenuState;
	float	TapXPos;
	float	TapYPos;
	
	DRTexture	*menuBackGround;
	
	NSMutableArray *buttonArray;
}

- (MenuManager*) InitMenu;
- (BOOL) Update;
- (void) SetMousePosition:(float)nX:(float)nY;
- (BOOL) Render;
- (void) ClearAllButtons;
- (void) SetUpMainMenu;
- (void) SetupGameOverOptions;
- (void) SetupWinner;
- (void) SetupLoser;

@property(nonatomic, assign) int nButtonClicked;
@property(nonatomic, assign) int nMenuState;
@property(nonatomic, assign) float TapXPos;
@property(nonatomic, assign) float TapYPos;

@end
