//
//  GameManager.h
//  DREngine
//
//  Created by Rob DelBianco on 3/21/10.
//  Copyright 2010 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTexture.h"
#import "TileEngine.h"
#import "ArrowQueue.h"
#import "PowerUpManager.h"
#import "HUDManager.h"
#import "UtilFuncs.h"


#define ARCADE_GAME_MODE		1
#define PUZZLE_GAME_MODE		2
#define TIME_GAME_MODE			3
#define SPLIT_BALL_GAME_MODE	4


#define MAX_NUM_PLAYERS			3

@interface GameManager : NSObject {
	
	//NSMutableArray	*arrowQueue;
	NSMutableArray	*playerArray;
	TileEngine		*tileEngine;
	ArrowQueue		*arrowQueue;
	PowerUpManager	*powerUpItems;
	HUDManager		*hud;
	Utils			*uf;
	
	DRTexture		*texHUD;
	
	int		m_nGameType;
	int		m_nRound;
	int		m_nMaxArrowsAllowed;
	int		playerIndex; // this is our human player
	int		nCurPlayer;
	int		nTimerForCPU;
	float	TapXPos;
	float	TapYPos;
	bool    bWinner;
	bool	bGameOver;
	int		m_nTapScreenTimer;
	int		m_nGameStartDelay;
}

@property(nonatomic, assign) int m_nGameType;
@property(nonatomic, assign) int m_nTapScreenTimer;
@property(nonatomic, assign) int m_nRound;
@property(nonatomic, assign) float TapXPos;
@property(nonatomic, assign) float TapYPos;
@property(nonatomic, assign) bool bWinner;
@property(nonatomic, assign) bool bGameOver;
@property(nonatomic, assign) DRTexture *texHUD;
@property(nonatomic, assign) TileEngine *tileEngine;
@property(nonatomic, assign) ArrowQueue *arrowQueue;

- (GameManager*) InitGame;
- (BOOL) Update;
- (BOOL) Render;
- (BOOL) SetupGame;
- (BOOL) Shutdown;
- (void) NextPlayer;
- (void) RemoveDoppleGangers;
- (void) SetMousePositionxPos:(float)fx
						 yPos:(float)fy;
- (void) ResetCurrentGame;
- (BOOL) CheckForGameOver;
- (void) UpdateSwapPowerUps;

@end
