//
//  GoofBall.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "GoofBall.h"
#import "DREngine.h"
#import "GameDefines.h"

//Goof-Ball		- speed (1), stress (2), power up (3), and stop (0)

@implementation GoofBall

-(id) InitGoofBall
{
	return self;
}

-(void) SetupGoofBall
{
	[super InitializePlayer];
	
	
	// speed, stopDur, stressAdj, puAdj
	[super SetPlayerAttributes:1:0:2:3];
	
	//	newPlayer.xPos = ii*TILE_SIZE+HALF_TILE;
	//	newPlayer.yPos = TILE_SIZE+HALF_TILE;
	xPos = TYPE_GOOF_BALL*TILE_SIZE+HALF_TILE;
	yPos = TILE_SIZE+5;//HALF_TILE;
	
	type = TYPE_GOOF_BALL;
	
	directions[ANIMATION_UP_1]		= [[DRResourceManager GetInstance] LoadTexture:@"GoofBall_Up0.png"];
	directions[ANIMATION_UP_2]		= [[DRResourceManager GetInstance] LoadTexture:@"GoofBall_Up1.png"];
	directions[ANIMATION_RIGHT_1]	= [[DRResourceManager GetInstance] LoadTexture:@"GoofBall_Right0.png"];
	directions[ANIMATION_RIGHT_2]	= [[DRResourceManager GetInstance] LoadTexture:@"GoofBall_Right1.png"];
	directions[ANIMATION_DOWN_1]	= [[DRResourceManager GetInstance] LoadTexture:@"GoofBall_Down0.png"];
	directions[ANIMATION_DOWN_2]	= [[DRResourceManager GetInstance] LoadTexture:@"GoofBall_Down1.png"];
	directions[ANIMATION_LEFT_1]	= [[DRResourceManager GetInstance] LoadTexture:@"GoofBall_Left0.png"];
	directions[ANIMATION_LEFT_2]	= [[DRResourceManager GetInstance] LoadTexture:@"GoofBall_Left1.png"];
}


- (void)CheckStressFromPlayer:(int) plrType
{
	// there are two players that give stress
	if( plrType == TYPE_KNOW_IT_ALL ||
	    plrType == TYPE_SLACKER )
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
