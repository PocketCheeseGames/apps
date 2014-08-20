//
//  RumorStarter.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "RumorStarter.h"
#import "DREngine.h"
#import "GameDefines.h"

//Rumor-Starter	- speed (3), stress (1), power up (2), and stop (0)

@implementation RumorStarter

-(id) InitRumorStarter
{
	return self;
}

-(void) SetupRumorStarter
{
	[super InitializePlayer];
	
	// speed, stopDur, stressAdj, puAdj
	[super SetPlayerAttributes:3:0:1:2];
	
	//	newPlayer.xPos = ii*TILE_SIZE+HALF_TILE;
	//	newPlayer.yPos = TILE_SIZE+HALF_TILE;
	xPos = TYPE_RUMOR_STARTER*TILE_SIZE+HALF_TILE;
	yPos = TILE_SIZE+5;//HALF_TILE;
	
	type = TYPE_RUMOR_STARTER;
	
	directions[ANIMATION_UP_1]		= [[DRResourceManager GetInstance] LoadTexture:@"RumorStarter_Up0.png"];
	directions[ANIMATION_UP_2]		= [[DRResourceManager GetInstance] LoadTexture:@"RumorStarter_Up1.png"];
	directions[ANIMATION_RIGHT_1]	= [[DRResourceManager GetInstance] LoadTexture:@"RumorStarter_Right0.png"];
	directions[ANIMATION_RIGHT_2]	= [[DRResourceManager GetInstance] LoadTexture:@"RumorStarter_Right1.png"];
	directions[ANIMATION_DOWN_1]	= [[DRResourceManager GetInstance] LoadTexture:@"RumorStarter_Down0.png"];
	directions[ANIMATION_DOWN_2]	= [[DRResourceManager GetInstance] LoadTexture:@"RumorStarter_Down1.png"];
	directions[ANIMATION_LEFT_1]	= [[DRResourceManager GetInstance] LoadTexture:@"RumorStarter_Left0.png"];
	directions[ANIMATION_LEFT_2]	= [[DRResourceManager GetInstance] LoadTexture:@"RumorStarter_Left1.png"];
}

- (void)Update
{
	[super Update];
}

- (void)CheckStressFromPlayer:(int) plrType
{
	// there are two players that give stress
	if( plrType == TYPE_OVER_ACHIEVER ||
	   plrType == TYPE_GOOF_BALL )
	{
		[super IncreaseStress];
	}
	else {
		
		[super IncreasePowerUp];
	}
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
