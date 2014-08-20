//
//  FloorTile.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "FloorTile.h"
#import "DREngine.h"
#import "UtilFuncs.h"


@implementation FloorTile

- (FloorTile*)InitTile
{
	self = [super init];
	
	pBaseTileImage = 0;
	
	[super SetBaseImage];
	
	return self;
}


-(void) DrawTile
{
	[super DrawTile];
}


- (void)PlayerChanges:(Player*)pPlayer
{
	int nNewDir = 0;
	uf = [Utils GetInstance];
	
	if( pPlayer.bJumpingActive )
		return;
	
	// if player is in a tornado, then move them around
	if( [uf IsBitSet:pPlayer.powerUpBits:PU_TORNADO_BIT] )
	{
		// 1 - 4
		nNewDir = [uf GetRandomNumber:1:4];
		
		[pPlayer ChangeDirection:nNewDir:xPos:yPos];
	}
}

// if there is an arrow on the tile already, then no
- (bool) OkToPlaceArrow
{
	return [super OkToPlaceArrow];
}


- (bool) OkToPlacePowerUp
{
	return [super OkToPlacePowerUp];
}


- (void) dealloc
{
	[super dealloc];
}

@end
