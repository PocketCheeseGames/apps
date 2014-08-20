//
//  KnowItAll.h
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"


@interface KnowItAll : Player
{

}


- (id) InitKnowItAll;
- (void) SetupKnowItAll;
- (void)Update;
- (void)DrawArrows;
- (void)DrawPlayerAnimation;
- (void)CheckStressFromPlayer:(int) plrType;
- (void)SetJumpActive;
- (void)StopPlayerMovement;
- (void)ChangeDirection:(int)newDir:(float)x:(float)y;
- (void)IncreaseStress;
- (void)DecreaseStress;
- (void)IncreasePowerUp;
- (void)DecreasePowerUp;


@end
