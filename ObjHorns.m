//
// ObjHorns.m
// DREngine
//
// Created by Yan Zhang on 10/13/2009.
// Copyright 2009 Silver Ram Studio.  All rights reserved.


#import "ObjHorns.h"
#import "ObjHornsData.h"
#import "HornD.h"
#import "DRResourceManager.h"
#import "DRRenderManager.h"

@implementation ObjHorns

- (void) Initialize
{
		Model = [[DRModel alloc] init];
		RootFrame = [[DRFrame alloc] init];

		DRMesh* meshHorn = [[DRResourceManager GetInstance] GetMesh:_HornMeshName_];

		if (meshHorn == nil)
		{
			meshHorn = [[DRMesh alloc] init];
			[[DRResourceManager GetInstance] AddMesh:meshHorn];
			meshHorn->VertexData = (float*)HornDVertexData;
			meshHorn->NormalData = (float*)HornDNormalData;
			DRDataHolder* dh1 = [[DRDataHolder alloc] init];
			dh1->Data = (float*)HornDUVSet1;
			[meshHorn->UVSets AddValue:dh1];
			meshHorn->Name = _HornMeshName_;
			meshHorn.NumberOfVertices = 7920;
			[meshHorn.Effect.Textures AddValue:[[DRResourceManager GetInstance] GetTexture:@"Horn.png"]];
		}

		DRFrame* framepolySurface2 = [[DRFrame alloc] init];
		[framepolySurface2 SetLocRotationX:polySurface2FrameRotation[0] Y:polySurface2FrameRotation[1] Z:polySurface2FrameRotation[2]];
		[framepolySurface2 SetLocOriginX:polySurface2FramePosition[0] Y:polySurface2FramePosition[1] Z:polySurface2FramePosition[2]];
		framepolySurface2.Mesh = meshHorn;

		[Model.Frames AddValue:framepolySurface2];

		DRFrame* framepolySurface3 = [[DRFrame alloc] init];
		[framepolySurface3 SetLocRotationX:polySurface3FrameRotation[0] Y:polySurface3FrameRotation[1] Z:polySurface3FrameRotation[2]];
		[framepolySurface3 SetLocOriginX:polySurface3FramePosition[0] Y:polySurface3FramePosition[1] Z:polySurface3FramePosition[2]];
		framepolySurface3.Mesh = meshHorn;

		[framepolySurface2 AddChild:framepolySurface3];

}
- (void) Update
{
		DRListIterator* it = [[DRListIterator alloc] init:Model.Frames];
		DRFrame* frame = [it Next];
		while (frame != nil)
		{
			[frame UpdateWithParent:nil];
			frame = [it Next];
		}
		[it release];

}
- (void) Render
{
		DRListIterator* it = [[DRListIterator alloc] init:Model.Frames];
		DRFrame* frame = [it Next];
		while (frame != nil)
		{
			// [[DRRenderManager GetInstance] RenderFrame:frame];
			[[DRRenderManager GetInstance] AddToRenderQueue:frame];
			frame = [it Next];
		}
		[it release];

}

@end
