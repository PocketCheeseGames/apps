//
//  SlipperyArrow.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "SlipperyArrow.h"
#import "DREngine.h"
#import "GameDefines.h"


@implementation SlipperyArrow

- (bool)PlayerChanges:(Player*)pPlayer
{
	float offset = 0;
	
	if( pPlayer.bJumpingActive )
		return false;
	
	uf = [Utils GetInstance];
	
	offset = [uf GetVelocityOffset:pPlayer.xVel:pPlayer.yVel];
	
	if( [uf isCollision:pPlayer.xPos :pPlayer.yPos :xPos :yPos :offset] )
	{
		[pPlayer ChangeDirection:nDirection:xPos:yPos];
		[pPlayer AddPowerUp:SLIPPERY_ARROW];
		return true;
	}
	
	return false;
}

- (id)InitArrow:(int)nDir:(int)player
{
	[super InitArrow:nDir:player];
	
	switch (nDirection)
	{
		case DIR_UP:
			
			pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"SlipperyArrowUp.png"];
			break;
			
		case DIR_DOWN:
			
			pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"SlipperyArrowDown.png"];
			break;
			
		case DIR_LEFT:
			
			pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"SlipperyArrowLeft.png"];
			break;
			
		case DIR_RIGHT:
			
			pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"SlipperyArrowRight.png"];
			break;
			
		default:
			
			pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"BadArrowPlaced.png"];
			break;
	}
	return self;
}

- (void)DrawArrow:(float)alpha;
{
	[super DrawArrow:alpha];
}

- (int) GetArrowType
{
	return ARROW_TYPE_SLIPPERY;
}


- (void) dealloc
{
	[super dealloc];
}

@end
