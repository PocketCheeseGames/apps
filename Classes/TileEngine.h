//
//  TileEngine.h
//  DREngine
//
//  Created by Rob DelBianco on 4/23/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"
#import "Player.h"


@interface TileEngine : NSObject {

	
	NSMutableArray	*GameBoard;
	int	nCurrentTile;
	int nPercentOfSpecialTiles;
	Utils	*uf;
}

- (TileEngine*) InitTileEngine:(int)nSpecTiles;

- (BOOL) ShutdownTileEngine;

- (void) ClickedOnGameBoard:(float)fxPos
						   :(float)fyPos;

- (BOOL) OkToSetTile;

- (void) PlayerOnTile:(Player*)pPlayer;

- (Tile*) GetSelectedTile;

- (void) DrawGameBoard;

- (Tile*)GetTileAtIndex:(int)nIdx;

- (int)GetTileTypeToAdd;

//- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue;

@end
