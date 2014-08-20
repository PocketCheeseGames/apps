//
//  KnowItAll.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "KnowItAll.h"
#import "DREngine.h"
#import "GameDefines.h"

//Know-It-All	- speed (1), stress (1), power up (2), and stop (2)

@implementation KnowItAll

-(id) InitKnowItAll
{
	return self;
}

-(void) SetupKnowItAll
{
	[super InitializePlayer];
	
	// speed, stopDur, stressAdj, puAdj
	[super SetPlayerAttributes:1:2:1:2];
	
	//	newPlayer.xPos = ii*TILE_SIZE+HALF_TILE;
	//	newPlayer.yPos = TILE_SIZE+HALF_TILE;
	xPos = TYPE_KNOW_IT_ALL*TILE_SIZE+HALF_TILE;
	yPos = TILE_SIZE+5;//HALF_TILE;
	
	type = TYPE_KNOW_IT_ALL;
	
	directions[ANIMATION_UP_1]		= [[DRResourceManager GetInstance] LoadTexture:@"KnowItAll_Up0.png"];
	directions[ANIMATION_UP_2]		= [[DRResourceManager GetInstance] LoadTexture:@"KnowItAll_Up1.png"];
	directions[ANIMATION_RIGHT_1]	= [[DRResourceManager GetInstance] LoadTexture:@"KnowItAll_Right0.png"];
	directions[ANIMATION_RIGHT_2]	= [[DRResourceManager GetInstance] LoadTexture:@"KnowItAll_Right1.png"];
	directions[ANIMATION_DOWN_1]	= [[DRResourceManager GetInstance] LoadTexture:@"KnowItAll_Down0.png"];
	directions[ANIMATION_DOWN_2]	= [[DRResourceManager GetInstance] LoadTexture:@"KnowItAll_Down1.png"];
	directions[ANIMATION_LEFT_1]	= [[DRResourceManager GetInstance] LoadTexture:@"KnowItAll_Left0.png"];
	directions[ANIMATION_LEFT_2]	= [[DRResourceManager GetInstance] LoadTexture:@"KnowItAll_Left1.png"];
}


- (void)CheckStressFromPlayer:(int) plrType
{
	// there are two players that give stress
	if( plrType == TYPE_OVER_ACHIEVER ||
	   plrType == TYPE_RUMOR_STARTER )
	{
		[super IncreaseStress];
	}
	else {
		
		[super IncreasePowerUp];
	}
}

- (void)Update
{
	[super Update];
}

- (void)DrawArrows
{
	[super DrawArrows];
}

- (void)DrawPlayerAnimation
{
	[super DrawPlayerAnimation];
}


- (void)SetJumpActive
{
	[super SetJumpActive];
}

- (void)StopPlayerMovement
{
	// based on player setting
	[super StopPlayerMovement];
}

- (void)ChangeDirection:(int)newDir:(float)x:(float)y;
{
	[super ChangeDirection:newDir:x:y];
}


- (void)IncreaseStress
{
	[super IncreaseStress];
}

- (void)DecreaseStress
{
	[super DecreaseStress];
}

- (void)IncreasePowerUp
{
	[super IncreasePowerUp];
}

- (void)DecreasePowerUp
{
	[super DecreasePowerUp];
}

- (void) dealloc {
	
	[super dealloc];
}


//- (void) InitOverAchiever
//{
//	self = [super initPlayer:0.0 yPos:0.0];
//	[super InitializePlayer];
//}
//
//- (OverAchiever*) GetOverAchiever
//{
//	return self;
//}

@end
