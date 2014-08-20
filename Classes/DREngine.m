//
//  DREngine.m
//  Draco Engine
//
//  Created by yan zhang on 5/30/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DREngine.h"

static DREngine* gpDREngineInstance = nil; // singleton instance

@implementation DREngine
// ----------------------------
+ (DREngine*) CreateInstance
{
	if (gpDREngineInstance != nil)
	{
		[gpDREngineInstance release];
		gpDREngineInstance = nil;
	}
	gpDREngineInstance = [DREngine alloc];
	[gpDREngineInstance Init];
	return gpDREngineInstance;
}
// ----------------------------
+ (DREngine*) GetInstance
{
	if (gpDREngineInstance != nil)
	{
		return gpDREngineInstance;
	}
	gpDREngineInstance = [[DREngine alloc] init];
	return gpDREngineInstance;
}
// ----------------------------
+ (void) DeleteInstance
{
	if (gpDREngineInstance != nil)
	{
		[gpDREngineInstance Destroy];
		[gpDREngineInstance release];
	}
}

// ----------------------------
- (DREngine*) Init
{
	[DRTimerManager CreateInstance];
	[DRRenderManager CreateInstance];
	[[DRMath CreateInstance] Init];
	[[DRInputManager CreateInstance]  Init];
	[[DRAL CreateInstance] init];
	[DRResourceManager CreateInstance];
	return self;
}
// ----------------------------
- (void) Destroy
{
	[DRResourceManager DeleteInstance];
	[DRTimerManager DeleteInstance];
	[DRAL DeleteInstance];
	[DRInputManager DeleteInstance];
	[DRRenderManager DeleteInstance];
	[DRMath DeleteInstance];
}

@end
