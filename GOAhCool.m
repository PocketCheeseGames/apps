//
//  GOAhCool.m
//  DREngine
//
//  Created by yan zhang on 11/2/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "GOAhCool.h"


@implementation GOAhCool

- (void) Initialize
{
	[super Initialize];
	
	WalkAnimation = [[StoryBoardAhCoolWalk alloc] init];
	[WalkAnimation Initialize];
	[WalkAnimation SetTarget:Model];
	[WalkAnimation Begin];
	
	[RootFrame SetLocOriginX:0.0f Y:-0.5f Z:-2.0f];
}

- (void) Update
{
	[super Update];
	
	[RootFrame RotateLocY:0.01f];
}

- (void) dealloc
{
	[WalkAnimation release];
	[super dealloc];
}

@end
