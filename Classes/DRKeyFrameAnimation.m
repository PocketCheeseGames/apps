//
//  DRKeyFrameAnimation.m
//  DREngine
//
//  Created by yan zhang on 10/29/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRKeyFrameAnimation.h"
#import "DRListIterator.h"

@implementation DRKeyFrameAnimation

@synthesize TargetName;
@synthesize Target;
@synthesize StartTime;
@synthesize EndTime;

- (DRKeyFrameAnimation*) initWithTargetName:(NSString*) targetName StartTime:(float) startTime EndTime:(float) endTime
{
	Target = nil;
	TargetName = targetName;
	StartTime = StartTime;
	EndTime = endTime;
	KeyFrames = [[DRList alloc] init];
	return self;
}

- (void) AddKeyFrame:(DRKeyFrame*) keyFrame
{
	[KeyFrames AddValue:keyFrame];
}

- (void) SetTarget:(DRFrame*) target
{
	Target = target;
}


- (void) Update:(double) time
{
	if (Target == nil)
		return;
	
	DRListIterator* it = [[DRListIterator alloc] init:KeyFrames];
	DRVector* vtFrom = nil;
	DRVector* vrFrom = nil;
	double timeFrom = 0.0;
	DRVector* vtTo = nil;
	DRVector* vrTo = nil;
	double timeTo = 0.0;
	
	double timeFromDiff = EndTime;
	double timeToDiff = -1.0 * EndTime;
	
	DRKeyFrame* curKeyFrame = [it Next];
	while (curKeyFrame != nil)
	{
		double timeTemp = time - curKeyFrame.Time;
		if (timeTemp >= 0.0 &&
			timeTemp <= timeFromDiff)
		{
			timeFromDiff = timeTemp;
			timeFrom = curKeyFrame.Time;
			vtFrom = curKeyFrame.Translation;
			vrFrom = curKeyFrame.Rotation;
		}
		
		if (timeTemp <= 0.0 &&
			timeTemp >= timeToDiff)
		{
			timeToDiff = timeTemp;
			timeTo = curKeyFrame.Time;
			vtTo = curKeyFrame.Translation;
			vrTo = curKeyFrame.Rotation;
		}
		
		curKeyFrame = [it Next];
	}
	
	// Apply the animations
	float tX = Target.LocOrigin->Data[0], tY = Target.LocOrigin->Data[1], tZ = Target.LocOrigin->Data[2];
	float rX = Target.LocRotation->Data[0], rY = Target.LocRotation->Data[1], rZ = Target.LocRotation->Data[2];
	
	if (vtFrom != nil)
	{
		tX = vtFrom->Data[0]; tY = vtFrom->Data[1]; tZ = vtFrom->Data[2];
	}
	if (vrFrom != nil)
	{
		rX = vrFrom->Data[0]; rY = vrFrom->Data[1]; rZ = vrFrom->Data[2];
	}
	
	if (vtTo != nil)
	{
		if (vtFrom == nil)
		{
			tX = vtTo->Data[0]; tY = vtTo->Data[1]; tZ = vtTo->Data[2];
		}
		else
		{
			float ratio = (time - timeFrom) / (timeTo - timeFrom);
			tX = vtFrom->Data[0] + (vtTo->Data[0] - vtFrom->Data[0]) * ratio;
			tY = vtFrom->Data[1] + (vtTo->Data[1] - vtFrom->Data[1]) * ratio;
			tZ = vtFrom->Data[2] + (vtTo->Data[2] - vtFrom->Data[2]) * ratio;
		}
	}
	
	if (vrTo != nil)
	{
		if (vrFrom == nil)
		{
			rX = vrTo->Data[0]; rY = vrTo->Data[1]; rZ = vrTo->Data[2];
		}
		else
		{
			float ratio = (time - timeFrom) / (timeTo - timeFrom);
			rX = vrFrom->Data[0] + (vrTo->Data[0] - vrFrom->Data[0]) * ratio;
			rY = vrFrom->Data[1] + (vrTo->Data[1] - vrFrom->Data[1]) * ratio;
			rZ = vrFrom->Data[2] + (vrTo->Data[2] - vrFrom->Data[2]) * ratio;
		}
	}
	
	[Target SetLocOriginX:tX OriginY:tY OriginZ:tZ RotationX:rX RotationY:rY RotationZ:rZ];
	
	[it release];
}

- (void) dealloc
{
	DRListIterator* it = [[DRListIterator alloc] init:KeyFrames];
	DRKeyFrame* keyFrame = [it Next];
	while (keyFrame != nil)
	{
		[keyFrame release];
		keyFrame = [it Next];
	}
	[it release];
	[KeyFrames release];
	[super dealloc];
}

@end
