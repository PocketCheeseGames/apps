//
//  DoppleGanger.h
//  DREngine
//
//  Created by Rob DelBianco on 2/24/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PowerUp.h"


@interface DoppleGanger : PowerUp {

}

- (DoppleGanger*)InitDoppleGanger;
- (bool)PlayerChanges:(Player*)pPlayer;
- (void)UpdatePowerUp;
- (void)DrawPowerUp;

@end
