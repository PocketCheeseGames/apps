//
//  WaterCoolerTile.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "WaterCoolerTile.h"
#import "DREngine.h"
#import "GameDefines.h"


@implementation WaterCoolerTile

- (WaterCoolerTile*)InitTile
{
	self = [super init];
	
	pBaseTileImage = 0;
	pTileImage = 0;
	
	[super SetBaseImage];
	
	pTileImage = [[DRResourceManager GetInstance] LoadTexture:@"WaterCooler.png"];
	
	return self;
}


-(void) DrawTile
{
	[super DrawTile];
	
	// then draw the water cooler
	if( pTileImage )
		[pTileImage BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:1.0f Green:1.0f Blue:1.0f Alpha:1.0f];
}

- (void)PlayerChanges:(Player*)pPlayer
{
	if( pPlayer.bJumpingActive )
		return;
	
	// reduce the player stress for as many times as they are colliding with this tile
	// i.e. slower players get more stress reduced than faster players
	[pPlayer DecreaseStress];
}

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
