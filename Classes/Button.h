//
//  Button.h
//  DREngine
//
//  Created by Rob DelBianco on 3/24/10.
//  Copyright 2010 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTexture.h"

#define NO_BUTTON		-1
#define PLAY_AGAIN_BTN	0
#define MAIN_MENU_BTN	1
#define TIME_GAME_BTN	2
#define PUZZLE_GAME_BTN	3
#define SPLIT_BALL_BTN	4
#define ARCADE_GAME_BTN	5
#define WINNER_BTN		6
#define LOSER_BTN		7
#define TOTAL_BUTTONS	8

#define BUTTON_SIZE_X	64.0f
#define BUTTON_SIZE_Y	64.0f
#define FINGER_RADIUS	20

@interface Button : NSObject {
	
	bool	bDrawButton;
	float	xPos;
	float	yPos;
	int		nButtonType;
	DRTexture *btnTexture;
}

- (Button*)initButton:(float)newXPos
				 yPos:(float)newYPos
		  nButtonType:(int)newButtonType;

- (void) SetButtonType:(int)type;

- (BOOL) ButtonClickedX:(float)tapX;
- (BOOL) ButtonClickedY:(float)tapY;

@property(nonatomic, assign) DRTexture *btnTexture;
@property(nonatomic, assign) float xPos;
@property(nonatomic, assign) float yPos;
@property(nonatomic, assign) int nButtonType;
@property(nonatomic, assign) bool bDrawButton;

@end
