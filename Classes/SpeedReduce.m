//
//  SpeedReduce.m
//  DREngine
//
//  Created by Rob DelBianco on 2/24/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//

#import "SpeedReduce.h"

#import "DREngine.h"
#import "GameDefines.h"
#import "UtilFuncs.h"


@implementation SpeedReduce


- (SpeedReduce*)InitSpeedReduce
{
	[super InitPowerUp];
	
	alpha = 1.0f;
	available = true;
	timeout = POWER_UP_AND_HAZARD_DURATION;
	
	pPowerUpImage = 0;
	pPowerUpImage = [[DRResourceManager GetInstance] LoadTexture:@"PowerUpSlowSpeed.png"];
	
	return self;
}

- (bool)PlayerChanges:(Player*)pPlayer
{
	float offset = 0;
	
	// if the player is jumping or the power up is not available
	if( pPlayer.bJumpingActive || !available)
		return false;
	
	uf = [Utils GetInstance];
	
	offset = [uf GetVelocityOffset:pPlayer.xVel:pPlayer.yVel];
	
	if( [uf isCollision:pPlayer.xPos :pPlayer.yPos :xPos :yPos :offset] )
	{
		// make change to player
		[pPlayer AddPowerUp:PU_ITEM_SPEED_REDUCE];
		available = false;
		
		return true;
	}
	
	return false;
}

- (void)UpdatePowerUp
{
	[super UpdatePowerUp];
}

- (void)DrawPowerUp
{
	[super DrawPowerUp];
	//if( pPowerUpImage )
	//	[pPowerUpImage BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:1.0f Green:1.0f Blue:1.0f Alpha:alpha];
}

- (void) dealloc {
	
	[super dealloc];
}

@end
