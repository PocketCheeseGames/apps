//
//  HUDManager.h
//  DREngine
//
//  Created by Rob DelBianco on 2/24/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTexture.h"

@class Utils;
@class Player;

@interface HUDManager : NSObject {

	float		curStress;
	float		curPU;
	float		fStressAlpha;
	float		fPuAlpha;
	int			curLives;
	int			curKills;
	DRTexture	*pMeter;
	Utils		*uf;
}


- (HUDManager*) InitHUDManager;

- (void) Update:(Player*)plr;
- (void) Draw;

@end
