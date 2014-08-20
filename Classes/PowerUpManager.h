//
//  PowerUpManager.h
//  DREngine
//
//  Created by Rob DelBianco on 2/24/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PowerUp.h"
#import "Hazard.h"
#import "GameDefines.h"
#import "Player.h"


@interface PowerUpManager : NSObject {

	NSMutableArray *pPowerUpItems;
	int			timer;
	bool		addItem;
}

@property(nonatomic, assign) bool addItem;

- (PowerUpManager*) InitPowerUpManager;

- (void) AddPowerUpItemToGame:(int)type:(Tile*)curTile;
- (void) Update;
- (void) PlayerCollisions:(Player*)curPlayer;
- (void) Draw;

@end
