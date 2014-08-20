//
//  StopSignTile.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "StopSignTile.h"
#import "DREngine.h"
#import "GameDefines.h"


@implementation StopSignTile

- (StopSignTile*)InitTile
{
	self = [super init];
	
	pBaseTileImage = 0;
	pTileImage = 0;
	
	[super SetBaseImage];
	
	pTileImage = [[DRResourceManager GetInstance] LoadTexture:@"StopSign.png"];
	
	return self;
}


-(void) DrawTile
{
	[super DrawTile];
	
	if( pTileImage )
		[pTileImage BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:1.0f Green:1.0f Blue:1.0f Alpha:1.0f];
}


- (void)PlayerChanges:(Player*)pPlayer
{
	if( pPlayer.bJumpingActive )
		return;
	
	// stop the player
	pPlayer.arrowCollisionTimer = ARROW_COLLISION_TIME;
	[pPlayer StopPlayerMovement];
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
