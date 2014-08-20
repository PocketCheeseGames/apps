/*
 *  PowerUp.h
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

@class Tile;

// arrow blows up when player crosses
@interface PowerUp : NSObject
{
	float	xPos;
	float	yPos;
	bool	available;
	int		timeout;
	float	alpha;
	DRTexture *pPowerUpImage;
	Utils	*uf;
	Tile	*tileLoc;
}

@property(nonatomic, assign) float xPos;
@property(nonatomic, assign) float yPos;
@property(nonatomic, assign) bool available;


- (id)InitPowerUp;
- (void) DrawPowerUp;
- (void) UpdatePowerUp;
- (bool)PlayerChanges:(Player*)pPlayer;
- (Tile*) GetTileLocation;
- (void) SetTileLocation:(Tile*)tile;

@end