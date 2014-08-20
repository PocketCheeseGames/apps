//
//  GameSettings.m
//  DREngine
//
//  Created by Rob DelBianco on 2/24/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//


//#import "DREngine.h"
//#import "GameDefines.h"
#import "GameSettings.h"

static GameSettings* gpSettingsInstance = nil;

@implementation GameSettings


- (GameSettings *) Init
{
	return self;
}

+ (GameSettings*) CreateInstance
{
	if (gpSettingsInstance != nil)
	{
		[gpSettingsInstance release];
		gpSettingsInstance = nil;
	}
	gpSettingsInstance = [[GameSettings alloc] Init];
	return gpSettingsInstance;
}
+ (GameSettings*) GetInstance
{
	return gpSettingsInstance;
}
+ (void) DeleteInstance
{
	[gpSettingsInstance release];
}

@end
