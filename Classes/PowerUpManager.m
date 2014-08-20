//
//  PowerUpManager.m
//  DREngine
//
//  Created by Rob DelBianco on 2/24/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//

#import "PowerUpManager.h"
#import "SpeedBoost.h"
#import "SpeedReduce.h"
#import "Teleport.h"
#import	"IncreaseStress.h"
#import	"StressRelief.h"
#import	"LoseLife.h"
#import	"GainLife.h"
#import	"Invisible.h"
#import "Invincibility.h"
#import	"Shield.h"
#import "SwapPoints.h"
#import	"SwapPosition.h"
#import "SwapPowerUpMeter.h"
#import "SwapStress.h"
#import "Tornado.h"
#import "SwapLives.h"
#import "DoppleGanger.h"
#import "Tile.h"


@implementation PowerUpManager

@synthesize addItem;

- (PowerUpManager*) InitPowerUpManager
{
	self = [super init];
	
	timer = TIME_TO_ADD_POWER_UP_ITEM;
	
	pPowerUpItems = [[NSMutableArray alloc] init ];

	return self;
}


- (void) AddPowerUpItemToGame:(int)type:(Tile*)curTile
{
	int count = [pPowerUpItems count];
	PowerUp	*pPowerUp = 0;
	
	type = PU_ITEM_DOPPLEGANGER;
	
	if( count < MAX_POWER_UP_ITEMS )
	{
		switch (type) {
			case PU_ITEM_SPEED_BOOST:
				//create new speed boost pu
				pPowerUp = [[SpeedBoost alloc] InitSpeedBoost];
				break;
	
			case PU_ITEM_SPEED_REDUCE:
				//create new speed boost pu
				pPowerUp = [[SpeedReduce alloc] InitSpeedReduce];
				break;
			case PU_ITEM_TELEPORT:
				//create new speed boost pu
				pPowerUp = [[Teleport alloc] InitTeleport];
				break;
			case PU_ITEM_STRESS_REDUCE:
				//create new speed boost pu
				pPowerUp = [[StressRelief alloc] InitStressRelief];
				break;
			case PU_ITEM_STRESS_INDUCE:
				//create new speed boost pu
				pPowerUp = [[IncreaseStress alloc] InitIncreaseStress];
				break;
			case PU_ITEM_LOSE_A_LIFE:
				//create new speed boost pu
				pPowerUp = [[LoseLife alloc] InitLoseLife];
				break;
			case PU_ITEM_GAIN_A_LIFE:
				//create new speed boost pu
				pPowerUp = [[GainLife alloc] InitGainLife];
				break;
			case PU_ITEM_INVINCIBLE:
				//create new speed boost pu
				pPowerUp = [[Invincibility alloc] InitInvincibility];
				break;
			case PU_ITEM_INVISIBLE:
				//create new speed boost pu
				pPowerUp = [[Invisible alloc] InitInvisible];
				break;
			case PU_ITEM_SHIELD:
				//create new speed boost pu
				pPowerUp = [[Shield alloc] InitShield];
				break;
			case PU_ITEM_SWAP_POSITION:
				pPowerUp = [[SwapPosition alloc] InitSwapPosition];
				break;
			case PU_ITEM_SWAP_POINTS:
				pPowerUp = [[SwapPoints alloc] InitSwapPoints];
				break;
			case PU_ITEM_SWAP_PU_METER:
				pPowerUp = [[SwapPowerUpMeter alloc] InitSwapPowerUpMeter];
				break;
			case PU_ITEM_SWAP_HP_METER:
				pPowerUp = [[SwapStress alloc] InitSwapStress];
				break;
			case PU_ITEM_SWAP_LIVES:
				pPowerUp = [[SwapLives alloc] InitSwapLives];
				break;
			case PU_ITEM_TORNADO:
				pPowerUp = [[Tornado alloc] InitTornado];
				break;
			case PU_ITEM_DOPPLEGANGER:
				pPowerUp = [[DoppleGanger alloc] InitDoppleGanger];
				break;
			default:
				break;
		}
		[pPowerUp SetTileLocation:curTile];
		[pPowerUpItems addObject:pPowerUp];
		[pPowerUp release];
	}
	
	timer = TIME_TO_ADD_POWER_UP_ITEM;
	addItem = false;
}


- (void) PlayerCollisions:(Player*)curPlayer
{
	int count = [pPowerUpItems count];
	PowerUp	*pPowerUp = 0;
	
	for( int ii = 0; ii < count; ++ii )
	{
		pPowerUp = [pPowerUpItems objectAtIndex:ii]; 
		
		if( pPowerUp )
		{
			[pPowerUp PlayerChanges:curPlayer];
		}
	}
}

- (void) Update
{
	int count = [pPowerUpItems count];
	PowerUp	*pPowerUp = 0;
	Tile *pCurTile = 0;
	
	for( int ii = 0; ii < count; ++ii )
	{
		pPowerUp = [pPowerUpItems objectAtIndex:ii];
		
		if( pPowerUp )
		{
			[pPowerUp UpdatePowerUp ];
			
			if( !pPowerUp.available )
			{
				pCurTile = [pPowerUp GetTileLocation];
				[pCurTile RemoveItemOnTile:PowerUpOnTileBit];
				[pPowerUpItems removeObjectAtIndex:ii];
				break;
			}
		}
	}
	
	if( timer > 0 )
		timer--;
	
	if( timer <= 0 )
		addItem = true;
}


- (void) Draw
{
	int count = [pPowerUpItems count];
	PowerUp	*pPowerUp = 0;
	
	for( int ii = 0; ii < count; ++ii )
	{
		pPowerUp = [pPowerUpItems objectAtIndex:ii];
		
		if( pPowerUp )
			[pPowerUp DrawPowerUp];
	}
}


- (void) dealloc {
	
	[pPowerUpItems release];
	
	[super dealloc];
}


@end
