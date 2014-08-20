//
//  DRInputManager.m
//  Draco Engine
//
//  Created by yan zhang on 5/30/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRInputManager.h"
#import "DRMath.h"

static DRInputManager* gpIMInstance = nil; // singleton instance

@implementation DRInputManager

@synthesize AccX;
@synthesize AccY;
@synthesize AccZ;
@synthesize YOffset;
// ----------------------------
+ (DRInputManager*) CreateInstance
{
	if (gpIMInstance != nil)
	{
		[gpIMInstance release];
		gpIMInstance = nil;
	}
	gpIMInstance = [[DRInputManager alloc] init];
	return gpIMInstance;
}
// ----------------------------
+ (DRInputManager*) GetInstance
{
	if (gpIMInstance != nil)
	{
		return gpIMInstance;
	}
	gpIMInstance = [[DRInputManager alloc] init];
	return gpIMInstance;
}
// ----------------------------
+ (void) DeleteInstance
{
	if (gpIMInstance != nil)
	{
		[gpIMInstance release];
	}
}
// ----------------------------
- (DRInputManager*)Init 
{
	for (int i=0; i<INPUT_NUMBER_OF_POINTS; i++)
	{
		_pLocations[i].x = 0.0f;
		_pLocations[i].y = 0.0f;
		_pLocations[i].touchState = 0;
		_pLocations[i].numberOfTaps = 0;
		_pLocations[i].ID = 0;
		_pLocations[i].active = NO;
	}
	
	_nCounter = 0;
	
	_nUnchangedCounter = 0;
	
	YOffset = -0.5f;
	
	return self;
}
// ----------------------------
- (void) Update
{
	_nCounter++;
	_nUnchangedCounter++;
	if (_nUnchangedCounter > 30)
	{
		[self Reset];
	}
}
// ----------------------------
- (void) Reset
{
	for (int i=0; i<INPUT_NUMBER_OF_POINTS; i++)
	{
		_pLocations[i].x = 0.0f;
		_pLocations[i].y = 0.0f;
		_pLocations[i].ID = 0;
		_pLocations[i].active = NO;
	}
	_nUnchangedCounter = 0;
}
// ----------------------------
- (void) AddLocationX:(float) fX Y:(float) fY ID:(void*)pID
{
	for (int i=0; i<INPUT_NUMBER_OF_POINTS; i++)
	{
		if (_pLocations[i].ID == pID)
		{
			_pLocations[i].x = fX;
			_pLocations[i].y = fY;
			_pLocations[i].active = YES;
			return;
		}
	}
	for (int i=0; i<INPUT_NUMBER_OF_POINTS; i++)
	{
		if (!_pLocations[i].active)//_pActive[i])
		{
			_pLocations[i].x = fX;
			_pLocations[i].y = fY;
			_pLocations[i].ID = pID;
			_pLocations[i].active = YES;
			return;
		}
	}
}
// ----------------------------
- (void) AddLocationX:(float) fX Y:(float) fY ID:(void*) pID NumberOfTaps:(int) nNumberOfTaps TouchState:(int) nTouchState
{
	for (int i=0; i<INPUT_NUMBER_OF_POINTS; i++)
	{
		if (_pLocations[i].ID == pID)
		{
			_pLocations[i].x = fX;
			_pLocations[i].y = fY;
			_pLocations[i].numberOfTaps = nNumberOfTaps;
			_pLocations[i].touchState = nTouchState;
			_pLocations[i].active = YES;
			return;
		}
	}
	for (int i=0; i<INPUT_NUMBER_OF_POINTS; i++)
	{
		if (!_pLocations[i].active)
		{
			_pLocations[i].x = fX;
			_pLocations[i].y = fY;
			_pLocations[i].ID = pID;
			_pLocations[i].numberOfTaps = nNumberOfTaps;
			_pLocations[i].touchState = nTouchState;
			_pLocations[i].active = YES;
			return;
		}
	}
}
// ----------------------------
- (void) SetInactiveWithID:(void*) pID
{
	for (int i=0; i<INPUT_NUMBER_OF_POINTS; i++)
	{
		if (_pLocations[i].ID == pID)
		{
			_pLocations[i].ID = 0;
			_pLocations[i].active = NO;
		}
	}
}
// ----------------------------
- (DRInputInfo*) Locations
{
	return _pLocations;
}
// ----------------------------
- (DRInputInfo) GetLocation:(int) nIndex
{
	return _pLocations[nIndex];
}
// ----------------------------
- (float) GetLocationX:(int) nIndex
{
	return _pLocations[nIndex].x;
}
// ----------------------------
- (float) GetLocationY:(int) nIndex
{
	return _pLocations[nIndex].y;
}
// ----------------------------
- (int) GetNumberOfLocations
{
	int nNum = 0;
	for (int i=0; i<INPUT_NUMBER_OF_POINTS; i++)
	{
		if (_pLocations[i].active)
		{
			nNum+=1;
		}
	}
	return nNum;
}

@end
