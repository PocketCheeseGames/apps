//
//  ExplosiveArrow.h
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Arrow.h"


@interface ExplosiveArrow : Arrow {

}

- (ExplosiveArrow*)InitArrow:(int)nDir:(int)player;
- (void)DrawArrow:(float)alpha;
- (bool)PlayerChanges:(Player*)pPlayer;
- (int) GetArrowType;

@end
