//
//  TileEngine.m
//  DREngine
//
//  Created by Rob DelBianco on 4/23/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "TileEngine.h"
#import "DREngine.h"
#import "GameDefines.h"
#import "FloorTile.h"
#import "StopSignTile.h"
#import "WaterCoolerTile.h"
#import "TrampolineTile.h"
#import "RandomDirectionTile.h"
#import	"UtilFuncs.h"


@implementation TileEngine


// return an instance of our tile engine to the game
- (TileEngine*) InitTileEngine:(int)nSpecTiles
{
	bool specialTile = false;
	self = [super init];
	
	nPercentOfSpecialTiles = nSpecTiles;
	
	int nTileType = 0;
	GameBoard = [[NSMutableArray alloc] init ];
	Tile	*pNewTile = 0;
	
	for( int ii = 0; ii < MAX_ROWS; ++ii )
	{
		for( int jj = 1; jj <= MAX_COLS; ++jj )
		{
			specialTile = false;
			nTileType = [self GetTileTypeToAdd];
			
			switch (nTileType)
			{
				case TILE_TYPE_UNKNOWN_ARROW:
				{
					pNewTile = [[RandomDirectionTile alloc] init];
					specialTile = true;
				}
					break;
				case TILE_TYPE_STOP:
				{
					pNewTile = [[StopSignTile alloc] init];
					specialTile = true;
				}
					break;
				case TILE_TYPE_WATER_COOLER:
				{
					pNewTile = [[WaterCoolerTile alloc] init];
					specialTile = true;
				}
					break;
				case TILE_TYPE_BUMPER:
				{
					pNewTile = [[TrampolineTile alloc] init];
					specialTile = true;
				}
					break;
				default:
				{
					pNewTile = [[FloorTile alloc] init];
				}
					break;
			}
			
			[pNewTile InitTile];
			
			if( specialTile )
				[pNewTile SetItemOnTile:ObjectOnTileBit];
			pNewTile.xPos = ii*TILE_SIZE+HALF_TILE;
			pNewTile.yPos = jj*TILE_SIZE+5;
			
			[GameBoard addObject:pNewTile];
			[pNewTile release];
			pNewTile = 0;
		}
	}
	
	return self;
}


//- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue
//{
//	return (arc4random() % (nHighValue-nLowRange+1)+nLowRange);
//}

- (int)GetTileTypeToAdd
{
	uf = [Utils GetInstance];
	return [uf GetRandomNumber:1 :nPercentOfSpecialTiles];
}

// randomly determine if an object should be added to the game board
- (BOOL)ShouldAddObjectToGameBoard
{
	uf = [Utils GetInstance];
	// a 10% chance???
	int nRand = [uf GetRandomNumber:1 :100];
	
	if( nRand <= 10 )
		return TRUE;
	return FALSE;
}

- (void) DrawGameBoard
{
	Tile *pCurTile = 0;
	int ii = 0;// our loop counter
	int nNumTiles = [GameBoard count];
	
	// draw the game board first
	for( ii = 0 ; ii < nNumTiles; ++ii )
	{
		pCurTile = [GameBoard objectAtIndex:ii];
		[pCurTile DrawTile];
	}
}

- (void) PlayerOnTile:(Player*)pPlayer
{
	Tile *pTile = 0;
	int nArrayCount = [GameBoard count];
	bool bFoundTile = false;
	float offset = 1;
	uf = [Utils GetInstance];
	
	offset = [uf GetVelocityOffset:pPlayer.xVel :pPlayer.yVel];
	
	// run through the tile array and find our tile
	for( int ii = 0; ii < nArrayCount; ++ii )
	{
		// find out if the x and y match up
		pTile = [GameBoard objectAtIndex:ii];
		
		if( [uf isCollision:pPlayer.xPos :pPlayer.yPos :pTile.xPos :pTile.yPos :offset] )
		{
			bFoundTile = true;
			break;
		}
		
		//if( pPlayer.xVel != 0 )
		//	offset = pPlayer.xVel;
		//else if( pPlayer.yVel != 0 )
		//	offset = pPlayer.yVel;
		
		//if( offset < 0 )
		//	offset *= -1;
		
		//offset = 1+offset;
		
		//if( pPlayer.xPos < pTile.xPos-offset )
		//	continue;
		//if( pPlayer.xPos > (pTile.xPos+offset))
		//	continue;
		//if( pPlayer.yPos < pTile.yPos-offset )
		//	continue;
		//if( pPlayer.yPos > (pTile.yPos+offset))
		//	continue;
		
		//// if we got here, we found our tile
		//bFoundTile = true;
		//break;
	}
	
	if( bFoundTile )
	{
		[pTile PlayerChanges:pPlayer];
	}
}



//// find out if a player is on a tile
//- (Tile*) PlayerOnSpecialTile:(float)fxPos
//					   yPos:(float)fyPos
//{
//	// x and y position of player should be the same as tiles
//	Tile *pTile = 0;
//	int nArrayCount = [GameBoard count];
//	bool bFoundTile = false;
//	
//	// run through the tile array and find our tile
//	for( int ii = 0; ii < nArrayCount; ++ii )
//	{
//		// find out if the x and y match up
//		pTile = [GameBoard objectAtIndex:ii];
//		
//		// this works nicely for keeping players lined up with the arrows
//		if( fxPos < pTile.xPos-1 )
//			continue;
//		if( fxPos > (pTile.xPos+1))
//			continue;
//		if( fyPos < pTile.yPos-1 )
//			continue;
//		if( fyPos > (pTile.yPos+1))
//			continue;
//		
//		// if we got here, we found our tile
//		bFoundTile = true;
//		break;
//	}
//	
//	// will either return the file found or 0
//	if( bFoundTile )
//		return pTile;
//	return 0;
//}


// find out if the use clicked on the game board
- (void) ClickedOnGameBoard:(float)fxPos
						   :(float)fyPos
{
	Tile *pTile = 0;
	int nArrayCount = [GameBoard count];
	
	nCurrentTile = NO_TILE_SELECTED;
	
	// run through the tile array and find our tile
	for( int ii = 0; ii < nArrayCount; ++ii )
	{
		// find out if the x and y match up
		pTile = [GameBoard objectAtIndex:ii];
		
		if( fxPos < pTile.xPos )
			continue;
		if( fxPos > (pTile.xPos+TILE_SIZE))
			continue;
		if( fyPos < pTile.yPos )
			continue;
		if( fyPos > (pTile.yPos+TILE_SIZE))
			continue;
		
		// if we are here, then we have our tile
		
		nCurrentTile = ii;
		break;
	}
}

// the calling function must check for null
- (Tile*) GetSelectedTile
{
	Tile *pSelTile = 0;
	
	if( nCurrentTile != NO_TILE_SELECTED )
		pSelTile = [GameBoard objectAtIndex:nCurrentTile];
	
	return pSelTile;
}

// return true if it's ok to set a tile at the current selected tile
- (BOOL) OkToSetTile
{
	Tile *pTile = 0;
	
	if( nCurrentTile != NO_TILE_SELECTED )
		pTile = [GameBoard objectAtIndex:nCurrentTile];
	
	if( pTile )
	{
		return [pTile OkToPlaceArrow];
	}
	
	// we got down here, so maybe we didn't click on the GameBoard
	return FALSE;
}


//// pass in the information of a tile to change on the game board
//- (void) ChangeToArrowTile:(Tile*)pNewTile
//{
//	// it has to be an arrow tile...
//	Tile	*pOldTile = 0;
//	
//	if( nCurrentTile != NO_TILE_SELECTED )
//		pOldTile = [GameBoard objectAtIndex:nCurrentTile];
//	
//	if( pOldTile )
//	{
//		[pOldTile ChangeGameBoardTile:pNewTile];
//	}
//}


//// function to randomly create a hazard arrow
//// to the game board
//- (void)AddHazardArrowToGameBoard:(int)nRand
//								 :(int)nType;
//{
//	int nIndex = nRand;
//	int nArrayCount = [GameBoard count];
//	Tile *pOldTile = 0;
//	bool bArrowAdded = false;
//	
//	// we have a tile, now make sure we can change it
//	while( true )
//	{
//		//// we don't want too many of these things around...
//		//if( nTotalHazardArrows >= MAX_HAZARD_ARROWS )
//		//	break;
//		
//		// make sure we stay within the bounds of our array
//		// call them lucky, I guess.  No hazard arrow?
//		if(nIndex >= nArrayCount )
//			break;
//		
//		pOldTile = [GameBoard objectAtIndex:nIndex];
//		
//		if( [pOldTile GetTileType] == TILE_TYPE_GROUND )
//		//if( [pOldTile CanTileChange:0] )
//		{
//			//// increment our counter
//			//nTotalHazardArrows++;
//			
//			[pOldTile HazardGameBoardTile:nType];
//			
//			// mark that we found a spot for the arrow
//			bArrowAdded = true;
//			
//			// get out of the loop
//			break;
//		}
//		
//		// couldn't change it, move on to the next tile
//		nIndex++;
//	}
//	
//	// we didn't add an arrow...
//	if( !bArrowAdded )
//	{
//		// show a "lucky" message???
//	}
//}

// make sure we have a valid index to a tile
- (Tile*)GetTileAtIndex:(int)nIdx
{
	int nArrayCount = [GameBoard count];
	
	if( nIdx >= 0 && nIdx < nArrayCount )
	{
		return [GameBoard objectAtIndex:nIdx];
	}
	return 0;
}


- (BOOL) ShutdownTileEngine
{
	BOOL bRet = TRUE;
	
	[GameBoard release];
	
	return bRet;
}


- (void) dealloc {
	
	[super dealloc];
}


@end
