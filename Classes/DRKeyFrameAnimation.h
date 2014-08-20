//
//  DRKeyFrameAnimation.h
//  DREngine
//
//  Created by yan zhang on 10/29/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRKeyFrame.h"
#import "DRFrame.h"
#import "DRList.h"

@interface DRKeyFrameAnimation : NSObject {
@protected
	NSString*	TargetName;
	DRFrame*	Target;
	float		StartTime;
	float		EndTime;
	DRList*		KeyFrames;
}

@property (nonatomic, assign) NSString* TargetName;
@property (nonatomic, assign) DRFrame* Target;
@property (nonatomic, assign) float StartTime;
@property (nonatomic, assign) float EndTime;

- (DRKeyFrameAnimation*) initWithTargetName:(NSString*) targetName StartTime:(float) startTime EndTime:(float) endTime;
- (void) SetTarget:(DRFrame*) target;
- (void) Update:(double) time;
- (void) AddKeyFrame:(DRKeyFrame*) keyFrame;

@end
