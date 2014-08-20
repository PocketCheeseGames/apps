//
//  Player.h
//  DREngine
//
//  Created by Rob DelBianco on 4/1/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTexture.h"
#import "GameDefines.h"

#define MAX_PLAYER_STRESS_LEVEL	100.0f

@class Utils;
@class Tile;

@interface Player : NSObject
{
	float	xPos;
	float	yPos;
	float	xVel;
	float	yVel;
	float	stressMeter;
	float	powerUpMeter;
	
	// player settings
	int		nSpeedSetting; // 0-3
	int		nStopSetting; // 0-3
	int		nStressSetting; // 0-3
	int		nPowerUpSetting; // 0-3
	
	int		score;
	int		numLives;
	int		numKills;
	int		type;
	int		timer;
	
	unsigned int	powerUpBits;
	int				powerUpTimers[PU_MAX_INDEX];
	unsigned int	playerActions;
	unsigned int	gameActions;
	
	int		arrowCollisionTimer;
	int		stoppedTimer;
	int		animationTimer;
	int		animationIndex;
	int		respawnTimer;
	int		jumpTimer;
	float	jumpScale;
	
	float	fAlpha;
	
	bool	bBlowUp;
	bool	bStressActive;
	bool	bRespawnActive;
	bool	bRespawnPlayer;
	bool	bJumpingActive;
	bool	bGetNewPosition;
	bool	bDoppleGanger;
	bool	bHumanPlayer;
	
	NSMutableArray	*playerArrows;
	Utils	*uf;
	
	DRTexture *directions[8];
	DRTexture *stressAnimation; // make this an array later
	DRTexture *playerShadow;
}

- (void)Update;
- (void)InitializePlayer;
- (void)KeepInPlay;
- (id)initPlayer:(float)newXPos
			yPos:(float)newYPos;
- (void) SetAsHuman;
- (void)PlayerAddedArrow:(Tile*)_tile
						:(int)_Dir
						:(int)_type
						:(int)maxAllowed;

- (void)SetPlayerAttributes:(int)speedSetting
						   :(int)stopDur
						   :(int)stressAdj
						   :(int)puAdj;

- (bool)PlayerChanges:(Player*)pPlayer;
//- (void)CPUAddedArrow;
//- (void)SetImage;
- (void)DrawArrows;
- (void)IncreaseStress;
- (void)DecreaseStress;
- (void)IncreasePowerUp;
- (void)UseSpecialPowerUp;
- (void)RespawnCountDown;
- (void)SetupDoppleganger:(Player*)plr;
//- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue;
- (void)ChangeDirection:(int)newDir:(float)x:(float)y;
- (void)StopPlayerMovement;
- (void)CheckForPoints:(int)playerType;
- (void)SetStressActivity:(bool)newStressActive;
- (void)DrawPlayerAnimation;
- (void)UpdateAnimationIndex;
- (BOOL)IsCollidingWithPlayer:(float)p2xPos
							 :(float)p2yPos;
- (void)ChangeAnimation;
- (bool)ShouldRespawnPlayer;
- (void)SetJumpActive;
//- (bool)IsPlayerRespawning;
- (void) GetCurrentPlayerVelocity;

- (BOOL) IsPlayerDone;

- (void) SetNewPlayerPosition:(float)newXPos
							 :(float)newYPos;

- (void)RespawnPlayer:(float)newXPos
					 :(float)newYPos;
- (void)AddPowerUp:(unsigned int) type;
- (void)ClearPowerUpBits;
- (void)CheckStressFromPlayer:(int) plrType;
- (void)PlayerSwapPowerUp:(Player*)plr;

@property(nonatomic, assign) float xPos;
@property(nonatomic, assign) float yPos;
@property(nonatomic, assign) float xVel;
@property(nonatomic, assign) float yVel;
@property(nonatomic, assign) float stressMeter;
@property(nonatomic, assign) float powerUpMeter;
@property(nonatomic, assign) int score;
@property(nonatomic, assign) int type;
@property(nonatomic, assign) int numLives;
@property(nonatomic, assign) int arrowCollisionTimer;
@property(nonatomic, assign) bool bBlowUp;
@property(nonatomic, assign) bool bJumpingActive;
@property(nonatomic, assign) bool bGetNewPosition;
@property(nonatomic, assign) bool bDoppleGanger;
@property(nonatomic, assign) unsigned int powerUpBits;

@end
