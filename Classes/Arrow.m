//
//  Arrow.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "Arrow.h"
#import "DREngine.h"
#import "GameDefines.h"
#import "Tile.h"

@implementation Arrow

@synthesize xPos;
@synthesize yPos;
@synthesize nDirection;



- (id)InitArrow:(int)nDir:(int)player
{
	self = [super init];
	
	pArrowImage = 0;
	nOwner = player;
	nDirection = nDir;
	
	return self;
}


- (Tile*) GetTileLocation
{
	return tileLoc;
}

- (void) SetTileLocation:(Tile*)tile
{
	xPos = tile.xPos;
	yPos = tile.yPos;
	[tile SetItemOnTile:ArrowOnTileBit];
	tileLoc = tile;
}

- (void)DrawArrow:(float)alpha
{
	if( pArrowImage )
		[pArrowImage BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:1.0f Green:1.0f Blue:1.0f Alpha:alpha];
}


- (void) LoadBadArrowImage:(float)_xPos
{
	xPos = _xPos;
	yPos = 460;
	pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"BadArrowPlaced.png"];
}


// this should never get called...
- (int) GetArrowType
{
	return ARROW_TYPE_UNKNOWN;
}

// shouldn't ever get called
- (bool) PlayerChanges:(Player *)pPlayer
{
	return false;
}


- (void) dealloc {
	
	[pArrowImage release];
	[super dealloc];
}

@end
