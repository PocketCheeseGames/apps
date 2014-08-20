//
//  RandomDirectionTile.h
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"


@interface RandomDirectionTile : Tile
{
	DRTexture *pTileImage;
}

- (id)InitTile;
- (void)DrawTile;
- (void)PlayerChanges:(Player*)pPlayer;
//- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue;
- (bool) OkToPlaceArrow;
- (bool) OkToPlacePowerUp;

@end
