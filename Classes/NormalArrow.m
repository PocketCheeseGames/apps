//
//  NormalArrow.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "NormalArrow.h"
#import "DREngine.h"
#import "GameDefines.h"


@implementation NormalArrow

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
		return true;
	}
	
	return false;
}

- (NormalArrow*)InitArrow:(int)nDir:(int)player
{	
	[super InitArrow:nDir:player];
	
	switch (nDirection)
	{
		case DIR_UP:
			
			pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"ArrowUp.png"];
			break;
			
		case DIR_DOWN:
			
			pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"ArrowDown.png"];
			break;
			
		case DIR_LEFT:
			
			pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"ArrowLeft.png"];
			break;
			
		case DIR_RIGHT:
			
			pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"ArrowRight.png"];
			break;
			
		default:
			
			pArrowImage = [[DRResourceManager GetInstance] LoadTexture:@"BadArrowPlaced.png"];
			break;
	}
	return self;
}

- (void)DrawArrow:(float)alpha;
{
	// get the color of the tile based on the player who sent it in...
	uf = [Utils GetInstance];
	float plrRed = [uf GetPlayerRedValue:nOwner];
	float plrBlue = [uf GetPlayerBlueValue:nOwner];
	float plrGreen = [uf GetPlayerGreenValue:nOwner];
	
	if( pArrowImage )
		[pArrowImage BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:plrRed Green:plrGreen Blue:plrBlue Alpha:alpha];
}

- (int) GetArrowType
{
	return ARROW_TYPE_NORMAL;
}

- (void) dealloc
{
	[super dealloc];
}

@end
