//
//  FloorTile.h
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"


@interface FloorTile : Tile {
}

- (id)InitTile;
- (void)DrawTile;
- (void)PlayerChanges:(Player*)pPlayer;
- (bool) OkToPlaceArrow;
- (bool) OkToPlacePowerUp;


@end
