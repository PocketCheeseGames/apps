//
//  NormalAllArrow.h
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Arrow.h"


@interface NormalAllArrow : Arrow {

}

- (id)InitNormalAllArrow:(int)nDir:(int)player;
- (void)DrawArrow:(float)alpha;
- (bool)PlayerChanges:(Player*)pPlayer;
- (int) GetArrowType;

@end
