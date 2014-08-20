//
//  HUDManager.m
//  DREngine
//
//  Created by Rob DelBianco on 2/24/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//

#import "HUDManager.h"
#import "Player.h"
#import "UtilFuncs.h"
#import "DREngine.h"


@implementation HUDManager


- (HUDManager*) InitHUDManager
{
	self = [super init];
	
	pMeter = [[DRResourceManager GetInstance] LoadTexture:@"Meter.png"];
	
	//always start at 1.0f
	fStressAlpha = 1.0f;
	fPuAlpha = 1.0f;
	
	return self;
}


- (void) Update:(Player*)plr
{
	//uf = [Utils GetInstance];
	curStress = plr.stressMeter;
	curPU = plr.powerUpMeter;
	curLives = plr.numLives;
	//curKills;
	
	// blink for power up
	if( curPU >= 100.0f )
	{
		fPuAlpha += 0.05f;
		
		if( fPuAlpha > 1.0f )
			fPuAlpha = 0.1f;
	}
	else
	{
		fPuAlpha = 1.0f;
	}
	
	// blink for stress concern
	if( curStress >= 85.0f )
	{
		fStressAlpha += 0.05f;
		
		if( fStressAlpha > 1.0f )
			fStressAlpha = 0.1f;
	}
	else
	{
		fStressAlpha = 1.0f;
	}
}

// this draws the stress meter and the power up meter
// when the power up meter gets to 100% it should flash
- (void) Draw
{
	float fRed = 0.0f;
	float fBlue = 0.0f;
	float fGreen = 1.0f;
	float xOffset = 100.0f-curStress;
	
	uf = [Utils GetInstance];
	
	xOffset *= .5;
	xOffset = 60.0f-xOffset;
	
	// show green for the no stress part
	[pMeter BlitTranslateX:60.0f TranslateY:10.0f Rotate:0.0f ScaleX:100.0f ScaleY:(TILE_SIZE*-.5f) Red:fRed Green:fGreen Blue:fBlue Alpha:fStressAlpha];
	
	// show red for the stress part
	fGreen = 0.0f;
	fRed = 1.0f;
	fBlue = 0.0f;
	[pMeter BlitTranslateX:xOffset TranslateY:10.0f Rotate:0.0f ScaleX:curStress ScaleY:(TILE_SIZE*-.5f) Red:fRed Green:fGreen Blue:fBlue Alpha:1.0f];
	
	fGreen = 1.0f;
	fBlue = .25f;
	fRed = 1.0f;
	// show yellow for no power up
	[pMeter BlitTranslateX:170.0f TranslateY:10.0f Rotate:0.0f ScaleX:100.0f ScaleY:(TILE_SIZE*-.5f) Red:fRed Green:fGreen Blue:fBlue Alpha:1.0f];
	
	xOffset = 100.0f-curPU;
	xOffset *= .5f;
	xOffset = 170.0f-xOffset;
	
	fGreen = 0.0f;
	fBlue = 1.0f;
	fRed = 0.0f;
	
	// show blue for power up
	[pMeter BlitTranslateX:xOffset TranslateY:10.0f Rotate:0.0f ScaleX:curPU ScaleY:(TILE_SIZE*-.5f) Red:fRed Green:fGreen Blue:fBlue Alpha:fPuAlpha];
	
	// draw the number of lives a player has left...
	[uf DrawNumber:curLives :250.0f :10.0f :TILE_SIZE :TILE_SIZE :0.0f :1.0f :0.0f :1.0f];
}


- (void) dealloc {
	
	[pMeter release];
	
	[super dealloc];
}


@end
