//
//  DRObject.m
//  DREngine
//
//  Created by yan zhang on 10/8/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRObject.h"


@implementation DRObject

@synthesize RootFrame;
@synthesize Model;

- (void) Initialize{}
- (void) Update{}
- (void) Render{}
- (bool) TestCollision:(DRObject*) obj{return NO;}
- (void) ReactToCollision:(DRObject*) obj{}
- (void) dealloc
{
	if (Model != nil)
	{
		[Model release];
	}
	if (RootFrame != nil)
	{
		[RootFrame release];
	}
	[super dealloc];
}

@end
