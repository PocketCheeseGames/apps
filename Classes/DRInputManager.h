//
//  DRInputManager.h
//  Draco Engine
//
//  Created by yan zhang on 5/30/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#ifndef _DRINPUTMANAGER_H_
#define _DRINPUTMANAGER_H_

#import <Foundation/Foundation.h>
#import "DRMath.h"
#import "DRFrame.h"

#define INPUT_NUMBER_OF_POINTS 10

#define TOUCHSTATE_INACTIVE 0
#define TOUCHSTATE_BEGIN 1
#define TOUCHSTATE_MOVE 2
#define TOUCHSTATE_END 3
#define TOUCHSTATE_STATIONARY 4

#define ACCBUFFER 0.05f

struct DRInputInfo
{
	float x;
	float y;
	int numberOfTaps;
	int touchState;
	void* ID;
	bool active;
};
typedef struct DRInputInfo DRInputInfo;

@interface DRInputManager : NSObject {
@private
	DRInputInfo _pLocations[INPUT_NUMBER_OF_POINTS];
	int _nCounter;
	int _nUnchangedCounter;
	
	// Accelerometer values;
	float AccX;
	float AccY;
	float AccZ;
	float YOffset;
}

@property (nonatomic, assign) float AccX;
@property (nonatomic, assign) float AccY;
@property (nonatomic, assign) float AccZ;
@property (nonatomic, assign) float YOffset;

+ (DRInputManager*) CreateInstance;
+ (DRInputManager*) GetInstance;
+ (void) DeleteInstance;

- (DRInputManager*) Init;
- (void) Reset;
- (void) Update;
- (void) AddLocationX:(float) fX Y:(float) fY ID:(void*) pID;
- (void) AddLocationX:(float) fX Y:(float) fY ID:(void*) pID NumberOfTaps:(int) nNumberOfTaps TouchState:(int) nTouchState;
- (void) SetInactiveWithID:(void*) pID;
- (DRInputInfo*) Locations;
- (DRInputInfo) GetLocation:(int) nIndex;
- (float) GetLocationX:(int) nIndex;
- (float) GetLocationY:(int) nIndex;

- (int) GetNumberOfLocations;

@end

#endif
