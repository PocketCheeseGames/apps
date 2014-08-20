//
//  DRTimer.h
//  Draco Engine
//
//  Created by yan zhang on 8/17/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DRTimerManager : NSObject {
@private
	double _dPrevStep;
	double _dDifference;
	double TimeElapseRatio;
}

@property (nonatomic, assign) double TimeElapseRatio;

+ (DRTimerManager*) CreateInstance;
+ (DRTimerManager*) GetInstance;
+ (void) DeleteInstance;

- (void) Init;
- (void) Update;
- (void) Destroy;

@end
