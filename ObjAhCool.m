//
// ObjAhCool.m
// DREngine
//
// Created by Yan Zhang on 11/3/2009.
// Copyright 2009 Silver Ram Studio.  All rights reserved.


#import "ObjAhCool.h"
#import "ObjAhCoolData.h"
#import "DRResourceManager.h"
#import "DRRenderManager.h"
#import "DRResourceManager.h"

@implementation ObjAhCool

- (void) Initialize
{
		Model = [[DRModel alloc] init];
		RootFrame = [[DRFrame alloc] init];
		RootFrame.Name = @"RootFrame";

		DRMesh* meshAhCoolBodyShape = [[DRResourceManager GetInstance] GetMesh:_AhCoolBodyShapeMeshName_];

		if (meshAhCoolBodyShape == nil)
		{
			meshAhCoolBodyShape = [[DRMesh alloc] init];
			[[DRResourceManager GetInstance] AddMesh:meshAhCoolBodyShape];
			meshAhCoolBodyShape->VertexData = (float*)AhCoolBodyShapeVertexData;
			meshAhCoolBodyShape->NormalData = (float*)AhCoolBodyShapeNormalData;
			DRDataHolder* dh1 = [[DRDataHolder alloc] init];
			dh1->Data = (float*)AhCoolBodyShapeUVSet1;
			[meshAhCoolBodyShape->UVSets AddValue:dh1];
			meshAhCoolBodyShape->Name = _AhCoolBodyShapeMeshName_;
			meshAhCoolBodyShape.NumberOfVertices = 330;
			[meshAhCoolBodyShape.Effect.Textures AddValue:[[DRResourceManager GetInstance] GetTexture:@"AhCool.png"]];
		}

		DRMesh* meshAhCoolHead = [[DRResourceManager GetInstance] GetMesh:_AhCoolHeadMeshName_];

		if (meshAhCoolHead == nil)
		{
			meshAhCoolHead = [[DRMesh alloc] init];
			[[DRResourceManager GetInstance] AddMesh:meshAhCoolHead];
			meshAhCoolHead->VertexData = (float*)AhCoolHeadVertexData;
			meshAhCoolHead->NormalData = (float*)AhCoolHeadNormalData;
			DRDataHolder* dh1 = [[DRDataHolder alloc] init];
			dh1->Data = (float*)AhCoolHeadUVSet1;
			[meshAhCoolHead->UVSets AddValue:dh1];
			meshAhCoolHead->Name = _AhCoolHeadMeshName_;
			meshAhCoolHead.NumberOfVertices = 972;
			[meshAhCoolHead.Effect.Textures AddValue:[[DRResourceManager GetInstance] GetTexture:@"AhCool.png"]];
		}

		DRMesh* meshAhCoolLeftLegShape = [[DRResourceManager GetInstance] GetMesh:_AhCoolLeftLegShapeMeshName_];

		if (meshAhCoolLeftLegShape == nil)
		{
			meshAhCoolLeftLegShape = [[DRMesh alloc] init];
			[[DRResourceManager GetInstance] AddMesh:meshAhCoolLeftLegShape];
			meshAhCoolLeftLegShape->VertexData = (float*)AhCoolLeftLegShapeVertexData;
			meshAhCoolLeftLegShape->NormalData = (float*)AhCoolLeftLegShapeNormalData;
			DRDataHolder* dh1 = [[DRDataHolder alloc] init];
			dh1->Data = (float*)AhCoolLeftLegShapeUVSet1;
			[meshAhCoolLeftLegShape->UVSets AddValue:dh1];
			meshAhCoolLeftLegShape->Name = _AhCoolLeftLegShapeMeshName_;
			meshAhCoolLeftLegShape.NumberOfVertices = 180;
			[meshAhCoolLeftLegShape.Effect.Textures AddValue:[[DRResourceManager GetInstance] GetTexture:@"AhCool.png"]];
		}

		DRMesh* meshAhCoolRightArmShape = [[DRResourceManager GetInstance] GetMesh:_AhCoolRightArmShapeMeshName_];

		if (meshAhCoolRightArmShape == nil)
		{
			meshAhCoolRightArmShape = [[DRMesh alloc] init];
			[[DRResourceManager GetInstance] AddMesh:meshAhCoolRightArmShape];
			meshAhCoolRightArmShape->VertexData = (float*)AhCoolRightArmShapeVertexData;
			meshAhCoolRightArmShape->NormalData = (float*)AhCoolRightArmShapeNormalData;
			DRDataHolder* dh1 = [[DRDataHolder alloc] init];
			dh1->Data = (float*)AhCoolRightArmShapeUVSet1;
			[meshAhCoolRightArmShape->UVSets AddValue:dh1];
			meshAhCoolRightArmShape->Name = _AhCoolRightArmShapeMeshName_;
			meshAhCoolRightArmShape.NumberOfVertices = 180;
			[meshAhCoolRightArmShape.Effect.Textures AddValue:[[DRResourceManager GetInstance] GetTexture:@"AhCool.png"]];
		}

		DRMesh* meshAhCoolRightLegShape = [[DRResourceManager GetInstance] GetMesh:_AhCoolRightLegShapeMeshName_];

		if (meshAhCoolRightLegShape == nil)
		{
			meshAhCoolRightLegShape = [[DRMesh alloc] init];
			[[DRResourceManager GetInstance] AddMesh:meshAhCoolRightLegShape];
			meshAhCoolRightLegShape->VertexData = (float*)AhCoolRightLegShapeVertexData;
			meshAhCoolRightLegShape->NormalData = (float*)AhCoolRightLegShapeNormalData;
			DRDataHolder* dh1 = [[DRDataHolder alloc] init];
			dh1->Data = (float*)AhCoolRightLegShapeUVSet1;
			[meshAhCoolRightLegShape->UVSets AddValue:dh1];
			meshAhCoolRightLegShape->Name = _AhCoolRightLegShapeMeshName_;
			meshAhCoolRightLegShape.NumberOfVertices = 180;
			[meshAhCoolRightLegShape.Effect.Textures AddValue:[[DRResourceManager GetInstance] GetTexture:@"AhCool.png"]];
		}

		DRMesh* meshAhCoolLeftArmShape = [[DRResourceManager GetInstance] GetMesh:_AhCoolLeftArmShapeMeshName_];

		if (meshAhCoolLeftArmShape == nil)
		{
			meshAhCoolLeftArmShape = [[DRMesh alloc] init];
			[[DRResourceManager GetInstance] AddMesh:meshAhCoolLeftArmShape];
			meshAhCoolLeftArmShape->VertexData = (float*)AhCoolLeftArmShapeVertexData;
			meshAhCoolLeftArmShape->NormalData = (float*)AhCoolLeftArmShapeNormalData;
			DRDataHolder* dh1 = [[DRDataHolder alloc] init];
			dh1->Data = (float*)AhCoolLeftArmShapeUVSet1;
			[meshAhCoolLeftArmShape->UVSets AddValue:dh1];
			meshAhCoolLeftArmShape->Name = _AhCoolLeftArmShapeMeshName_;
			meshAhCoolLeftArmShape.NumberOfVertices = 180;
			[meshAhCoolLeftArmShape.Effect.Textures AddValue:[[DRResourceManager GetInstance] GetTexture:@"AhCool.png"]];
		}

		DRFrame* frameAhCoolBody = [[DRFrame alloc] init];
		[frameAhCoolBody SetLocRotationX:AhCoolBodyFrameRotation[0] Y:AhCoolBodyFrameRotation[1] Z:AhCoolBodyFrameRotation[2]];
		[frameAhCoolBody SetLocOriginX:AhCoolBodyFramePosition[0] Y:AhCoolBodyFramePosition[1] Z:AhCoolBodyFramePosition[2]];
		frameAhCoolBody.Name = @"AhCoolBody";
		frameAhCoolBody.Mesh = meshAhCoolBodyShape;

		[Model.Frames AddValue:frameAhCoolBody];

		[RootFrame AddChild:frameAhCoolBody];

		DRFrame* frameFrameAhCoolHead = [[DRFrame alloc] init];
		[frameFrameAhCoolHead SetLocRotationX:FrameAhCoolHeadFrameRotation[0] Y:FrameAhCoolHeadFrameRotation[1] Z:FrameAhCoolHeadFrameRotation[2]];
		[frameFrameAhCoolHead SetLocOriginX:FrameAhCoolHeadFramePosition[0] Y:FrameAhCoolHeadFramePosition[1] Z:FrameAhCoolHeadFramePosition[2]];
		frameFrameAhCoolHead.Name = @"FrameAhCoolHead";
		frameFrameAhCoolHead.Mesh = meshAhCoolHead;

		[frameAhCoolBody AddChild:frameFrameAhCoolHead];
		DRFrame* frameAhCoolLeftLeg = [[DRFrame alloc] init];
		[frameAhCoolLeftLeg SetLocRotationX:AhCoolLeftLegFrameRotation[0] Y:AhCoolLeftLegFrameRotation[1] Z:AhCoolLeftLegFrameRotation[2]];
		[frameAhCoolLeftLeg SetLocOriginX:AhCoolLeftLegFramePosition[0] Y:AhCoolLeftLegFramePosition[1] Z:AhCoolLeftLegFramePosition[2]];
		frameAhCoolLeftLeg.Name = @"AhCoolLeftLeg";
		frameAhCoolLeftLeg.Mesh = meshAhCoolLeftLegShape;

		[frameAhCoolBody AddChild:frameAhCoolLeftLeg];
		DRFrame* frameAhCoolRightArm = [[DRFrame alloc] init];
		[frameAhCoolRightArm SetLocRotationX:AhCoolRightArmFrameRotation[0] Y:AhCoolRightArmFrameRotation[1] Z:AhCoolRightArmFrameRotation[2]];
		[frameAhCoolRightArm SetLocOriginX:AhCoolRightArmFramePosition[0] Y:AhCoolRightArmFramePosition[1] Z:AhCoolRightArmFramePosition[2]];
		frameAhCoolRightArm.Name = @"AhCoolRightArm";
		frameAhCoolRightArm.Mesh = meshAhCoolRightArmShape;

		[frameAhCoolBody AddChild:frameAhCoolRightArm];
		DRFrame* frameAhCoolRightLeg = [[DRFrame alloc] init];
		[frameAhCoolRightLeg SetLocRotationX:AhCoolRightLegFrameRotation[0] Y:AhCoolRightLegFrameRotation[1] Z:AhCoolRightLegFrameRotation[2]];
		[frameAhCoolRightLeg SetLocOriginX:AhCoolRightLegFramePosition[0] Y:AhCoolRightLegFramePosition[1] Z:AhCoolRightLegFramePosition[2]];
		frameAhCoolRightLeg.Name = @"AhCoolRightLeg";
		frameAhCoolRightLeg.Mesh = meshAhCoolRightLegShape;

		[frameAhCoolBody AddChild:frameAhCoolRightLeg];
		DRFrame* frameAhCoolLeftArm = [[DRFrame alloc] init];
		[frameAhCoolLeftArm SetLocRotationX:AhCoolLeftArmFrameRotation[0] Y:AhCoolLeftArmFrameRotation[1] Z:AhCoolLeftArmFrameRotation[2]];
		[frameAhCoolLeftArm SetLocOriginX:AhCoolLeftArmFramePosition[0] Y:AhCoolLeftArmFramePosition[1] Z:AhCoolLeftArmFramePosition[2]];
		frameAhCoolLeftArm.Name = @"AhCoolLeftArm";
		frameAhCoolLeftArm.Mesh = meshAhCoolLeftArmShape;

		[frameAhCoolBody AddChild:frameAhCoolLeftArm];

}
- (void) Update
{
		[RootFrame UpdateWithParent:nil];

}
- (void) Render
{
		[[DRRenderManager GetInstance] AddToRenderQueue:RootFrame];

}

@end
