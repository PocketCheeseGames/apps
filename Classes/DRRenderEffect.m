//
//  DRRenderEffect.m
//  DREngine
//
//  Created by yan zhang on 11/3/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRRenderEffect.h"
#import "DRTexture.h"

@implementation DRRenderEffect

@synthesize Textures;

- (DRRenderEffect*) init
{
	Textures = [[DRList alloc] init];
	return self;
}
- (void) Bind
{
	if (Textures.NumberOfNodes > 0)
	{
		[Textures.FirstNode.Value Bind];
	}
}
-(void) dealloc
{
	[Textures release];
	[super dealloc];
}

@end
