//
//  GameManager.m
//  DREngine
//
//  Created by Rob DelBianco on 3/21/10.
//  Copyright 2010 Pocket Cheese. All rights reserved.
//

#import "GameManager.h"
#import "DREngine.h"
#import "Button.h"
#import "Player.h"
#import "OverAchiever.h"
#import "Slacker.h"
#import "KnowItAll.h"
#import "RumorStarter.h"
#import "GoofBall.h"
#import "ArrowQueue.h"
#import "GameDefines.h"
#import "Tile.h"
#import <UIKit/UIFont.h>
#include <CoreGraphics/CGFont.h>


@implementation GameManager

@synthesize m_nGameType;
@synthesize m_nRound;
@synthesize TapXPos;
@synthesize TapYPos;
@synthesize bWinner;
@synthesize bGameOver;
@synthesize texHUD;
@synthesize m_nTapScreenTimer;
@synthesize tileEngine;
@synthesize arrowQueue;


#define SCREEN_TAP_DELAY 20


- (GameManager*) InitGame
{
	m_nGameType = PUZZLE_GAME_MODE;//TIME_GAME_MODE;//SPLIT_BALL_GAME_MODE;//TIME_GAME_MODE;//ARCADE_GAME_MODE;
	
	// load a Heads Up Display for the game
	// Time_HUD.png
	//texHUD = [[DRResourceManager GetInstance] LoadTexture:@"Time_HUD.png"];
	
	TapXPos = 0.0f;
	TapYPos = 0.0f;
	bWinner = false;
	bGameOver = false;
	m_nTapScreenTimer = 0;
	
	return self;
}


- (BOOL) Update
{
	Player	*pCurPlayer = 0;
	Player	*humanPlayer = 0;
	Tile	*pSelTile = 0;
	Tile	*boardTile = 0;
	Arrow	*pSelArrow = 0;
	float	oldXPos = 0.0f;
	int		nTileIdx = 0;
	int		nPlayers = 0;
	int		puItem = 0;
	bool	playerAddedArrow = false;
	uf = [Utils GetInstance];
	
	if( m_nGameStartDelay > 0 )
	{
		m_nGameStartDelay--;
		return true;
	}
	
	[[DRInputManager GetInstance] Update];
	
	// let the current turns player add an arrow
	nPlayers = [playerArray count];
	pCurPlayer = [playerArray objectAtIndex:nCurPlayer];
	humanPlayer = [playerArray objectAtIndex:playerIndex];
	
	if( m_nTapScreenTimer == 0 )
	{
		TapXPos = [[DRInputManager GetInstance] GetLocationX: 0 ];
		TapYPos = [[DRInputManager GetInstance] GetLocationY: 0 ];
	}
	else {
		TapXPos = 0;
		TapYPos = 0;
	}

	if( m_nTapScreenTimer > 0 )
		m_nTapScreenTimer--;
	else
		m_nTapScreenTimer = 0;
	
	// player can click on arrows in the queue even when it's not their turn
	if( TapXPos != 0 && TapYPos != 0 )
	{
		m_nTapScreenTimer = SCREEN_TAP_DELAY;
		
		// set the click position to a vertical screen
		[self SetMousePositionxPos:TapXPos yPos: TapYPos];
		
		// find out if the player clicked on an arrow in the queue
		[arrowQueue ArrowClicked:TapXPos:TapYPos];
	}
	
	if( nCurPlayer == playerIndex )
	{
		// update the arrow queue
		[arrowQueue UpdateArrowQueue];
		
		// find out where the person taps on the screen
		// should only work for the player
		if( TapXPos != 0 && TapYPos != 0 )
		{
			//// set the click position to a vertical screen
			//[self SetMousePositionxPos:TapXPos yPos: TapYPos];
			
			// find out if the player clicked on the game board
			[tileEngine ClickedOnGameBoard:TapXPos :TapYPos];
			
			// check to see if the player clicked the game board
			pSelTile = [tileEngine GetSelectedTile];
			
			// check to see if there is a selected arrow in the queue
			pSelArrow = [arrowQueue GetCurrentSelectedArrow];
			
			// check to see if there is an arrow and a Tile selected
			if( pSelArrow && pSelTile )
			{
				oldXPos = pSelArrow.xPos;
				
				// make sure we can place an arrow here
				if( [tileEngine OkToSetTile] )
				{
					// need to create an arrow onto the gameboard
					[pCurPlayer PlayerAddedArrow:pSelTile
												:pSelArrow.nDirection
												:[pSelArrow GetArrowType]
												:m_nMaxArrowsAllowed];
					
					// now need to add a new arrow to the queue
					[arrowQueue AddNewArrowToQueue:oldXPos];
					
					// next player turn
					playerAddedArrow = true;
				}
				else
				{
					// need to block the space in the arrow queue
					[arrowQueue BlockCurrentSelectedTile:oldXPos];
				}
				
				// either way, we delete the arrow from the queue
				[arrowQueue RemoveSelectedArrow];
				//// and reset the arrow queue timer
				//[arrowQueue ResetArrowQueueTimer];
				[arrowQueue StopArrowQueueTimer];
			}
			else if( pSelTile ) // just a tile selected
			{
			}
			else
			{
				// nothing selected or just the arrow queue...
			}
		}
	}
	else
	{
		// computer
		if( nTimerForCPU > 0 )
			nTimerForCPU--;
		else
		{
			nTileIdx = [uf GetRandomNumber:0 :MAX_GAME_TILES];
			boardTile = [tileEngine GetTileAtIndex:nTileIdx];
			
			if( boardTile && [boardTile OkToPlaceArrow] )
			{
				int nDirection = [uf GetRandomNumber:1 :4];
				int nType = [uf GetRandomNumber:1:10];
				
				[pCurPlayer PlayerAddedArrow:boardTile
											:nDirection
											:nType
											:m_nMaxArrowsAllowed];
				
				// next player turn
				playerAddedArrow = true;
			}
		}
	}
	
	// run through all players and update them
	for( int ii = 0; ii < nPlayers; ++ii )
	{
		pCurPlayer = [playerArray objectAtIndex:ii];
		
		[pCurPlayer Update];
		
		if( pCurPlayer.arrowCollisionTimer <= 0 )
			[tileEngine PlayerOnTile:pCurPlayer];
	}
	
	[powerUpItems Update];
	
	Player *pCmpPlayer = 0;
	bool	playerCollision = false;
	
	// update all players
	for( int ii = 0; ii < nPlayers; ++ii )
	{
		playerCollision = false;
		pCurPlayer = [playerArray objectAtIndex:ii];
		
		if( [pCurPlayer IsPlayerDone] )
			continue;
		
		// need to loop through all of the players
		for( int jj = 0; jj < nPlayers; ++jj )
		{
			if( jj == ii )
				continue;
			
			pCmpPlayer = [playerArray objectAtIndex:jj];
			
			if( [pCmpPlayer IsPlayerDone] )
				continue;
			
			// check for players colliding with players and arrows
			if( [pCurPlayer PlayerChanges:pCmpPlayer] )
			{
				[pCurPlayer CheckStressFromPlayer:pCmpPlayer.type];
				playerCollision = true;
			}
		}
		
		[pCurPlayer SetStressActivity:playerCollision];
		
		// check for players colliding with power ups and hazards
		[powerUpItems PlayerCollisions:pCurPlayer];
		
		// if the player needs to respawnm
		if( [pCurPlayer ShouldRespawnPlayer] )
		{
			// get a random tile for x and y pos
			nTileIdx = [uf GetRandomNumber:0 :MAX_GAME_TILES];
			boardTile = [tileEngine GetTileAtIndex:nTileIdx];
			if( boardTile )
			{
				[pCurPlayer RespawnPlayer:boardTile.xPos :boardTile.yPos];
			}
		}
		else if( pCurPlayer.bGetNewPosition )
		{
			// get a random tile for x and y pos
			nTileIdx = [uf GetRandomNumber:0 :MAX_GAME_TILES];
			boardTile = [tileEngine GetTileAtIndex:nTileIdx];
			
			if( boardTile )
			{
				[pCurPlayer SetNewPlayerPosition:boardTile.xPos :boardTile.yPos];
			}
		}
		
	}
	
	if( powerUpItems.addItem )
	{
		puItem = [uf GetRandomNumber:1 :PU_ITEM_MAX ];
		nTileIdx = [uf GetRandomNumber:0 :MAX_GAME_TILES];
		boardTile = [tileEngine GetTileAtIndex:nTileIdx];
		
		if( boardTile && [boardTile OkToPlacePowerUp] )
			[powerUpItems AddPowerUpItemToGame:puItem:boardTile];
	}
	
	// set up for the next players turn
	if( playerAddedArrow || arrowQueue.bTimerRanOut )
		[self NextPlayer];
	
	[self RemoveDoppleGangers];
	
	// do this last so we have the most recent information
	[self UpdateSwapPowerUps];
	
	[hud Update:humanPlayer];
	
	return bGameOver;
}


- (void) NextPlayer
{
	int totalPlayers = [playerArray count];
	Player *curPlayer = 0;
	nCurPlayer++;
	
	while( true )
	{
		if( nCurPlayer >= totalPlayers )
			nCurPlayer = 0;
	
		curPlayer = [playerArray objectAtIndex:nCurPlayer];
		
		// player is out of lives or player is a doppleganger
		if( [curPlayer IsPlayerDone] || curPlayer.bDoppleGanger )
			nCurPlayer++;
		// should be good...
		else
			break;
	}
	
	if( nCurPlayer != playerIndex )
	   nTimerForCPU = CPU_TIME_TO_ADD_ARROW;
	else
		[arrowQueue ResetArrowQueueTimer];
}

- (void) RemoveDoppleGangers
{
	int totalPlayers = [playerArray count];
	Player *curPlayer = 0;
	
	// loop through all of the players
	for( int ii = 0; ii < totalPlayers; ++ii )
	{
		curPlayer = [playerArray objectAtIndex:ii];
		
		if( curPlayer.bDoppleGanger && curPlayer.numLives <= 0 )
		{
			[playerArray removeObjectAtIndex:ii ];
			break;
		}
	}
}

// loop through the players (this is not the clicked swap)
// while were at it, check for dopplegangers...
- (void) UpdateSwapPowerUps
{
	int totalPlayers = [playerArray count];
	int swapIdx = 0;
	uf = [Utils GetInstance];
	Player *curPlayer = 0;
	Player *compPlr = 0;
	Player *newPlayer = 0;
	
	// loop through all of the players
	for( int ii = 0; ii < totalPlayers; ++ii )
	{
		curPlayer = [playerArray objectAtIndex:ii];
		
		// no need to update if he's out of lives
		if( [curPlayer IsPlayerDone] )
			continue;
		
		if( [uf IsBitSet:curPlayer.powerUpBits :PU_DOPPLEGANGER_BIT] )
		{
			curPlayer.powerUpBits = [uf ClearBit:curPlayer.powerUpBits :PU_DOPPLEGANGER_BIT];
			
			switch (curPlayer.type)
			{
				case TYPE_KNOW_IT_ALL:
					newPlayer = [[KnowItAll	alloc] InitKnowItAll];
					[newPlayer SetupKnowItAll];
					break;
				case TYPE_OVER_ACHIEVER:
					newPlayer = [[OverAchiever alloc] InitOverAchiever];
					[newPlayer SetupOverAchiever];
					break;
				case TYPE_SLACKER:
					newPlayer = [[Slacker alloc] InitSlacker];
					[newPlayer SetupSlacker];
					break;
				case TYPE_RUMOR_STARTER:
					newPlayer = [[RumorStarter alloc] InitRumorStarter];
					[newPlayer SetupRumorStarter];
					break;
				case TYPE_GOOF_BALL:
					newPlayer = [[GoofBall alloc] InitGoofBall];
					[newPlayer SetupGoofBall];
					break;
			}
			[newPlayer SetupDoppleganger:curPlayer];
			[playerArray addObject:newPlayer];
			[newPlayer release];
		}
		
		swapIdx++;
		
		if( swapIdx >= totalPlayers )
			swapIdx = 0;
		compPlr = [playerArray objectAtIndex:swapIdx];
		[curPlayer PlayerSwapPowerUp:compPlr];
	}
}

// function to translate our mouse taps
// from horizontal mode to vertical mode
- (void) SetMousePositionxPos:(float)fx
						 yPos:(float)fy
{
	TapXPos = (fx + 180);
	TapYPos = (fy - 260)*-1;
}


// this is called in the app to find out if the game is over
- (BOOL) CheckForGameOver
{
	return bGameOver;
}


// reset the current game we are playing
- (void) ResetCurrentGame
{
	bWinner = false;
	bGameOver = false;
}


// setup a game based on type and difficulty
- (BOOL) SetupGame
{
	BOOL bRet = true;
	bWinner = false;
	bGameOver = false;
	m_nMaxArrowsAllowed = 3; // this will be configurable later
	playerIndex = TYPE_OVER_ACHIEVER; // this will be sent in from the settings file
	nCurPlayer = 0;
	m_nGameStartDelay = 250;
	
	playerArray = [[NSMutableArray alloc] init ];
	arrowQueue = [[ArrowQueue alloc] initArrowQueue:playerIndex];
	tileEngine = [[TileEngine alloc] InitTileEngine:85];
	powerUpItems = [[PowerUpManager alloc] InitPowerUpManager];
	hud = [[HUDManager alloc] InitHUDManager];
	
	// add each player individually
	// must go in this order...
	// TYPE_KNOW_IT_ALL
	// TYPE_OVER_ACHIEVER
	// TYPE_SLACKER
	// TYPE_RUMOR_STARTER
	// TYPE_GOOF_BALL
	Player *newPlayer = 0;
	
	// add the know it all
	newPlayer = [[KnowItAll	alloc] InitKnowItAll];
	[newPlayer SetupKnowItAll];
	[playerArray addObject:newPlayer];
	[newPlayer release];
	
	// add the over achiever
	newPlayer = [[OverAchiever alloc] InitOverAchiever];
	[newPlayer SetupOverAchiever];
	[newPlayer SetAsHuman];
	[playerArray addObject:newPlayer];
	[newPlayer release];
	
	// add the slacker
	newPlayer = [[Slacker alloc] InitSlacker];
	[newPlayer SetupSlacker];
	[playerArray addObject:newPlayer];
	[newPlayer release];
	
	// add the rumor starter
	newPlayer = [[RumorStarter alloc] InitRumorStarter];
	[newPlayer SetupRumorStarter];
	[playerArray addObject:newPlayer];
	[newPlayer release];
	
	// add the goof ball
	newPlayer = [[GoofBall alloc] InitGoofBall];
	[newPlayer SetupGoofBall];
	[playerArray addObject:newPlayer];
	[newPlayer release];
	
	return bRet;
}

- (BOOL) Render
{
	BOOL bRet = true;
	
	Player	*curPlayer = 0;
	int		ii = 0;
	int		nNumPlayers = [playerArray count];
	
	// draw the game board first
	[tileEngine DrawGameBoard];
	
	// draw the players
	for( ii = 0; ii < nNumPlayers; ++ii )
	{
		curPlayer = [playerArray objectAtIndex:ii];
		
		if( [curPlayer IsPlayerDone] )
			continue;
		
		[curPlayer DrawPlayerAnimation];
		[curPlayer DrawArrows];
	}
	
	// draw any power ups or hazards that may appear
	[powerUpItems Draw];
	
	// draw any special effects or particles
	
	// draw the arrow queue
	[arrowQueue DrawArrowQueue];
	
	// draw the HUD
	[hud Draw];
	
	return bRet;
}

- (BOOL) Shutdown
{
	BOOL bRet = true;
	[playerArray release];
	[powerUpItems release];
	[arrowQueue release];
	[tileEngine release];
	
	return bRet;
}


- (void) dealloc {
	
	[super dealloc];
}

@end
