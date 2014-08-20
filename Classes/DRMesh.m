//
//  DRMesh.m
//  DREngine
//
//  Created by yan zhang on 9/21/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRMesh.h"
#import "DRListIterator.h"
#import "DRDataHolder.h"

@implementation DRMesh

@synthesize VertexData;
@synthesize NormalData;
@synthesize UVSets;
@synthesize Name;
@synthesize NumberOfVertices;
@synthesize Effect;
@synthesize IsAlpha;

-(void) dealloc
{
	DRListIterator* it = [[DRListIterator alloc] init:UVSets];
	DRDataHolder* dh = [it Next];
	while (dh != nil)
	{
		[dh release];
		dh = [it Next];
	}
	[Effect release];
	[UVSets release];
	[Name release];
	
	[super dealloc];
}

- (DRMesh*) init
{
	Effect = [[DRRenderEffect alloc] init];
	NumberOfVertices = 0;
	UVSets = [[DRList alloc] init];
	IsAlpha = NO;
	return self;
}

@end
