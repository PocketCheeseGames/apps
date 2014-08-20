//
//  Utils.m
//  DREngine
//
//  Created by Rob DelBianco on 2/24/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//


//#import "DREngine.h"
//#import "GameDefines.h"
#import "UtilFuncs.h"
#import "DREngine.h"

static Utils* gpUtilInstance = nil;

@implementation Utils

// there will be six of these to differentiate normal arrows and who they belong to
const float red[]	= {0.5f, 1.0f, 0.0f, 0.25f, 0.75f};
const float blue[]	= {1.0f, 0.25f, 0.75f, 0.0f, 0.5f};
const float green[]	= {0.75f, 0.0f, 0.25f, 0.5f, 1.0f};


- (Utils *) Init
{
	//char szName[16];
	//for( int ii = 0; ii < 9; ++ii )
	{
		pNumbers[0] = [[DRResourceManager GetInstance] LoadTexture:@"1.png"];
		pNumbers[1] = [[DRResourceManager GetInstance] LoadTexture:@"2.png"];
		pNumbers[2] = [[DRResourceManager GetInstance] LoadTexture:@"3.png"];
		pNumbers[3] = [[DRResourceManager GetInstance] LoadTexture:@"4.png"];
		pNumbers[4] = [[DRResourceManager GetInstance] LoadTexture:@"5.png"];
		pNumbers[5] = [[DRResourceManager GetInstance] LoadTexture:@"6.png"];
		pNumbers[6] = [[DRResourceManager GetInstance] LoadTexture:@"7.png"];
		pNumbers[7] = [[DRResourceManager GetInstance] LoadTexture:@"8.png"];
		pNumbers[8] = [[DRResourceManager GetInstance] LoadTexture:@"9.png"];
	}
	return self;
}

+ (Utils*) CreateInstance
{
	if (gpUtilInstance != nil)
	{
		[gpUtilInstance release];
		gpUtilInstance = nil;
	}
	gpUtilInstance = [[Utils alloc] Init];
	return gpUtilInstance;
}
+ (Utils*) GetInstance
{
	return gpUtilInstance;
}
+ (void) DeleteInstance
{
	for( int ii = 0; ii < 9; ++ii )
	{
		[pNumbers [ii] release];
	}
	[gpUtilInstance release];
}


- (void) DrawNumber:(int)numToDraw
				   :(float)xLoc
				   :(float)yLoc
				   :(float)xScale
				   :(float)yScale
				   :(float)red
				   :(float)green
				   :(float)blue
				   :(float)alpha;
{
	// show number for lives left (this will be green...
	if( numToDraw <= 9 && numToDraw > 0 )
		[pNumbers[numToDraw-1] BlitTranslateX:xLoc TranslateY:yLoc Rotate:0.0f ScaleX:xScale ScaleY:yScale*-1 Red:red Green:green Blue:blue Alpha:alpha];
}

- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue
{
	return (arc4random() % (nHighValue-nLowRange+1)+nLowRange);
}

- (bool) isCollision:(float)x1:(float)y1:(float)x2:(float)y2:(float)offset
{
	if( x1 < x2-offset )
		return false;
	if( x1 > (x2+offset))
		return false;
	if( y1 < y2-offset )
		return false;
	if( y1 > (y2+offset))
		return false;
	
	return true;
}

- (bool) IsBitSet:(unsigned int) AllBits:(unsigned int) BitToCheck
{
	if( (AllBits & BitToCheck) == BitToCheck )
		return true;
	return false;
}

- (unsigned int) SetBit:(unsigned int) AllBits:(unsigned int) BitToSet
{
	return AllBits |= BitToSet;
}

- (unsigned int) ClearBit:(unsigned int) AllBits:(unsigned int) BitToClear
{
	return AllBits &= ~BitToClear;
}

- (unsigned int) ToggleBit:(unsigned int) AllBits:(unsigned int) BitToToggle
{
	return AllBits ^= BitToToggle;
}

- (float) GetVelocityOffset:(float)xV:(float)yV
{
	float vel = 0.0f;
	
	if( xV != 0.0f )
		vel = xV;
	else if( yV != 0.0f )
		vel = yV;
	
	if( vel < 0 )
		vel *= -1;
	
	if( vel < 1.0f )
		vel = 1.0f;
		
	return vel;
}


- (float) GetPlayerRedValue:(int)index
{
	return red[index];
}

- (float) GetPlayerBlueValue:(int)index
{
	return blue[index];
}

- (float) GetPlayerGreenValue:(int)index
{
	return green[index];
}


@end
