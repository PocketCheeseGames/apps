//
//  DRStoryBoard.h
//  DREngine
//
//  Created by yan zhang on 10/29/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRKeyFrameAnimation.h"
#import "DRList.h"
#import "DRModel.h"

@interface DRStoryBoard : NSObject {
@protected
	double AnimationStartTime;
	double BeginTime;
	double EndTime;
	bool	Loop;
	DRList* Animations;
}

@property (nonatomic, assign) DRList* Animations;
@property (nonatomic, assign) bool Loop;
@property (nonatomic, assign) double BeginTime;
@property (nonatomic, assign) double EndTime;

- (DRStoryBoard*) init;
- (void) SetTarget:(DRModel*) model;

- (void) Initialize;
- (void) Begin;
- (void) Update;
- (void) Stop;

@end
