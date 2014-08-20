/*
 *  Arrow.h
 *  DREngine
 *
 *  Created by Rob DelBianco on 12/27/12.
 *  Copyright 2012 Pocket Cheese. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import "DRTexture.h"
#import "Player.h"
#import "UtilFuncs.h"


@interface Arrow : NSObject
{
	float xPos;
	float yPos;
	int nDirection;
	int nOwner;
	DRTexture *pArrowImage;
	Utils	*uf;
	Tile	*tileLoc;
}

@property(nonatomic, assign) float xPos;
@property(nonatomic, assign) float yPos;
@property(nonatomic, assign) int nDirection;

- (id)InitArrow:(int)nDir:(int)player;
- (void)DrawArrow:(float)alpha;
- (bool)PlayerChanges:(Player*)pPlayer;
- (int) GetArrowType;
- (void) LoadBadArrowImage:(float)_xPos;
- (Tile*) GetTileLocation;
- (void) SetTileLocation:(Tile*)tile;

@end
