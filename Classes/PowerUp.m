//
//  PowerUp.m
//  DREngine
//
//  Created by Rob DelBianco on 2/20/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//

#import "PowerUp.h"
#import "DREngine.h"
#import "GameDefines.h"
#import "Tile.h"

@implementation PowerUp

@synthesize xPos;
@synthesize yPos;
@synthesize available;


- (id)InitPowerUp
{
	self = [super init];
	
	alpha = 1.0f;
	available = true;
	timeout = POWER_UP_AND_HAZARD_DURATION;
	
	return self;
}

- (void) DrawPowerUp
{
	if( pPowerUpImage )
		[pPowerUpImage BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:1.0f Green:1.0f Blue:1.0f Alpha:alpha];
}

- (Tile*) GetTileLocation
{
	return tileLoc;
}

- (void) SetTileLocation:(Tile*)tile
{
	xPos = tile.xPos;
	yPos = tile.yPos;
	[tile SetItemOnTile:PowerUpOnTileBit];
	tileLoc = tile;
}

// should never get called
- (bool)PlayerChanges:(Player*)pPlayer
{
	return false;
}

- (void) UpdatePowerUp
{
	if( timeout > 0 )
		timeout--;
	if( timeout <= 0 )
	{
		available = false;
	}
	
	// show the pu fading away
	if( timeout <= 300 )
	{
		alpha += 0.05f;
		
		if( alpha > 1.0f )
			alpha = 0.5f;
	}
}

- (void) dealloc {
	
	[pPowerUpImage release];
	[super dealloc];
}

@end
