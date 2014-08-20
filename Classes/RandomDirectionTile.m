//
//  RandomDirectionTile.m
//  DREngine
//
//  Created by Rob DelBianco on 12/28/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "RandomDirectionTile.h"
#import "DREngine.h"
#import "GameDefines.h"
#import "UtilFuncs.h"


@implementation RandomDirectionTile

- (RandomDirectionTile*)InitTile
{
	self = [super init];
	
	pBaseTileImage = 0;
	pTileImage = 0;
	
	[super SetBaseImage];
	
	pTileImage = [[DRResourceManager GetInstance] LoadTexture:@"QuestionMark.png"];
	return self;
}

-(void) DrawTile
{
	[super DrawTile];
	
	if( pTileImage )
		[pTileImage BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:1.0f Green:1.0f Blue:1.0f Alpha:1.0f];
}


- (void)PlayerChanges:(Player*)pPlayer
{
	int nNewDir = 0;
	uf = [Utils GetInstance];
	
	if( pPlayer.bJumpingActive )
		return;
	
	// 1 - 4
	nNewDir = [uf GetRandomNumber:1:4];
	
	[pPlayer ChangeDirection:nNewDir:xPos:yPos];
}

//- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue
//{
//	return (arc4random() % (nHighValue-nLowRange+1)+nLowRange);
//}

- (bool) OkToPlaceArrow
{
	return [super OkToPlaceArrow];
}

- (bool) OkToPlacePowerUp
{
	return [super OkToPlacePowerUp];
}

- (void) dealloc
{
	[super dealloc];
}


@end
