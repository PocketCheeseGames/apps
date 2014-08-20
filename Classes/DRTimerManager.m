//
//  DRTimer.m
//  Draco Engine
//
//  Created by yan zhang on 8/17/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRTimerManager.h"

static DRTimerManager* gpTimerMInstance = nil; // singleton instance

@implementation DRTimerManager
@synthesize TimeElapseRatio;

// ----------------------------
+ (DRTimerManager*) CreateInstance
{
	if (gpTimerMInstance != nil)
	{
		[gpTimerMInstance release];
		gpTimerMInstance = nil;
	}
	gpTimerMInstance = [[DRTimerManager alloc] init];
	[gpTimerMInstance Init];
	return gpTimerMInstance;
}
// ----------------------------
+ (DRTimerManager*) GetInstance
{
	if (gpTimerMInstance != nil)
	{
		return gpTimerMInstance;
	}
	gpTimerMInstance = [[DRTimerManager alloc] init];
	return gpTimerMInstance;
}
// ----------------------------
+ (void) DeleteInstance
{
	if (gpTimerMInstance != nil)
	{
		[gpTimerMInstance Destroy];
		[gpTimerMInstance release];
	}
}
// ----------------------------
- (void) Init
{
	TimeElapseRatio = 1.0;
	_dPrevStep = 0.0;
}
// ----------------------------
- (void) Update
{	
	NSDate* curDate = [[NSDate alloc] init];
	double dCurStep = [curDate timeIntervalSince1970];
	double difference = (dCurStep - _dPrevStep);
	if (_dPrevStep == 0.0)
	{
		difference = 0.035;
	}
	_dPrevStep = dCurStep;
	TimeElapseRatio = difference / 0.035;
	[curDate release];
}
// ----------------------------
- (void) Destroy
{
}

@end
