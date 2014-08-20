//
//  Slacker.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "Slacker.h"
#import "DREngine.h"
#import "GameDefines.h"

//Slacker		- speed (0), stress (3), power up (2), and stop (1)

@implementation Slacker

-(id) InitSlacker
{
	return self;
}

-(void) SetupSlacker
{
	[super InitializePlayer];
	
	// speed, stopDur, stressAdj, puAdj
	[super SetPlayerAttributes:0:1:3:2];
	
	//	newPlayer.xPos = ii*TILE_SIZE+HALF_TILE;
	//	newPlayer.yPos = TILE_SIZE+HALF_TILE;
	xPos = TYPE_SLACKER*TILE_SIZE+HALF_TILE;
	yPos = TILE_SIZE+5;//HALF_TILE;
	
	type = TYPE_SLACKER;
	
	directions[ANIMATION_UP_1]		= [[DRResourceManager GetInstance] LoadTexture:@"Slacker_Up0.png"];
	directions[ANIMATION_UP_2]		= [[DRResourceManager GetInstance] LoadTexture:@"Slacker_Up1.png"];
	directions[ANIMATION_RIGHT_1]	= [[DRResourceManager GetInstance] LoadTexture:@"Slacker_Right0.png"];
	directions[ANIMATION_RIGHT_2]	= [[DRResourceManager GetInstance] LoadTexture:@"Slacker_Right1.png"];
	directions[ANIMATION_DOWN_1]	= [[DRResourceManager GetInstance] LoadTexture:@"Slacker_Down0.png"];
	directions[ANIMATION_DOWN_2]	= [[DRResourceManager GetInstance] LoadTexture:@"Slacker_Down1.png"];
	directions[ANIMATION_LEFT_1]	= [[DRResourceManager GetInstance] LoadTexture:@"Slacker_Left0.png"];
	directions[ANIMATION_LEFT_2]	= [[DRResourceManager GetInstance] LoadTexture:@"Slacker_Left1.png"];
}

- (void)CheckStressFromPlayer:(int) plrType
{
	// there are two players that give stress
	if( plrType == TYPE_KNOW_IT_ALL ||
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
