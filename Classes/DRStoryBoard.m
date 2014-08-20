//
//  DRStoryBoard.m
//  DREngine
//
//  Created by yan zhang on 10/29/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRStoryBoard.h"
#import "DRListIterator.h"
#import "DRRenderManager.h"

@implementation DRStoryBoard

@synthesize Animations;
@synthesize Loop;
@synthesize BeginTime;
@synthesize EndTime;

- (DRStoryBoard*) init
{
	Animations = [[DRList alloc] init];
	Loop = YES;
	BeginTime = 0.0;
	EndTime = 0.0;
	[self Initialize];
	return self;
}

- (void) SetTarget:(DRModel*) model
{
	DRListIterator* it = [[DRListIterator alloc] init:Animations];
	
	DRKeyFrameAnimation* anim = [it Next];
	while (anim != nil)
	{
		DRFrame* targetFrame = [model GetFrameByName:anim.TargetName];
		anim.Target = targetFrame;
		anim = [it Next];
	}
	
	[it release];
}

- (void) dealloc
{
	DRListIterator* it = [[DRListIterator alloc] init:Animations];
	DRKeyFrameAnimation* anim = [it Next];
	while (anim != nil)
	{
		[anim release];
		anim = [it Next];
	}
	[it release];
	[Animations release];
	[super dealloc];
}

- (void) Initialize
{
}

- (void) Begin
{
	NSDate* curDate = [[NSDate alloc] init];
	AnimationStartTime = [curDate timeIntervalSince1970];
	[curDate release];
	
	[[DRRenderManager GetInstance] AddActiveStoryBoard:self];
}

- (void) Update
{
	NSDate* curDate = [[NSDate alloc] init];
	double curTime = [curDate timeIntervalSince1970] - AnimationStartTime;
	double denom = (EndTime - BeginTime);
	denom = denom == 0 ? 1.0 : denom;
	curTime = curTime - ((int)(curTime / denom) * denom);
	[curDate release];
	if (! Loop &&
		curTime > EndTime)
	{
		[self Stop];
		return;
	}
	
	DRListIterator* it = [[DRListIterator alloc] init:Animations];
	DRKeyFrameAnimation* anim = [it Next];
	while (anim != nil)
	{
		[anim Update:curTime];
		anim = [it Next];
	}
	[it release];
}

- (void) Stop
{
	[[DRRenderManager GetInstance] RemoveActiveStorBoard:self];
}

@end
