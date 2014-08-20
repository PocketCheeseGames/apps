//
//  SpeedBoost.h
//  DREngine
//
//  Created by Rob DelBianco on 2/20/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PowerUp.h"


@interface SpeedBoost : PowerUp {

	
}

- (SpeedBoost*)InitSpeedBoost;
- (bool)PlayerChanges:(Player*)pPlayer;
- (void)UpdatePowerUp;
- (void)DrawPowerUp;

@end
