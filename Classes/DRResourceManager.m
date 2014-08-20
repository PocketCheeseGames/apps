//
//  DRResourceManager.m
//  DREngine
//
//  Created by yan zhang on 10/7/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRResourceManager.h"

static DRResourceManager* gpRCMInstance = nil; // singleton instance

@implementation DRResourceManager

@synthesize Textures;
@synthesize Meshes;


// ----------------------------
+ (DRResourceManager*) CreateInstance
{
	if (gpRCMInstance != nil)
	{
		[gpRCMInstance release];
		gpRCMInstance = nil;
	}
	gpRCMInstance = [[DRResourceManager alloc] init];
	return gpRCMInstance;
}
// ----------------------------
+ (DRResourceManager*) GetInstance
{
	if (gpRCMInstance != nil)
	{
		return gpRCMInstance;
	}
	gpRCMInstance = [[DRResourceManager alloc] init];
	return gpRCMInstance;
}
// ----------------------------
+ (void) DeleteInstance
{
	if (gpRCMInstance != nil)
	{
		[gpRCMInstance Destroy];
		[gpRCMInstance release];
	}
}

// ----------------------------
- (DRResourceManager*) init
{
	Textures = [[DRList alloc] init];
	Meshes = [[DRList alloc] init];
	return self;
}

// ----------------------------
- (void) Destroy
{
	if (Textures != nil)
	{
		DRListIterator* it = [[DRListIterator alloc] init:Textures];
		id nextObj = [it Next];
		while (nextObj != nil)
		{
			[nextObj release];
			nextObj = [it Next];
		}
		[it release];
		[Textures release];
	}
	if (Meshes != nil)
	{
		DRListIterator* it = [[DRListIterator alloc] init:Meshes];
		id nextObj = [it Next];
		while (nextObj != nil)
		{
			[nextObj release];
			nextObj = [it Next];
		}
		[it release];
		[Meshes release];
	}
}

- (DRTexture*) LoadTexture:(NSString*) resourceName
{
	DRTexture* texture = [DRTexture alloc];
	[texture InitWithResourceName:resourceName];
	[Textures AddValue:texture];
	return texture;
}

- (void) AddMesh:(id) mesh
{
	[Meshes AddValue:mesh];
}

- (DRMesh*) GetMesh:(NSString*) name
{
	DRListIterator* it = [[DRListIterator alloc] init:Meshes];
	DRMesh* nextMesh = [it Next];
	while(nextMesh != nil)
	{
		if ([nextMesh.Name isEqualToString: name])
		{
			break;
		}
		nextMesh = [it Next];
	}
	return nextMesh;
}

- (DRTexture*) GetTexture:(NSString*) name
{
	DRListIterator* it = [[DRListIterator alloc] init:Textures];
	DRTexture* nextTexture = [it Next];
	while(nextTexture != nil)
	{
		if ([nextTexture.Name isEqualToString: name])
		{
			break;
		}
		nextTexture = [it Next];
	}
	if (nil == nextTexture)
	{
		nextTexture = [self LoadTexture:name];
	}
	return nextTexture;
}

@end
