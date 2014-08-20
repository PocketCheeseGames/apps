//
//  DRFrame.m
//  Draco Engine
//
//  Created by yan zhang on 9/15/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRFrame.h"
#import "DRMath.h"

@implementation DRFrame

@synthesize LocOrigin;
@synthesize LocForwardVector;
@synthesize LocUpVector;
@synthesize LocRotation;
@synthesize LocMatrix;

@synthesize WorldOrigin;
@synthesize WorldForwardVector;
@synthesize WorldUpVector;
// @synthesize WorldRotation;
@synthesize WorldMatrix;

@synthesize Parent;
@synthesize Sibling;
@synthesize Child;

@synthesize Mesh;
@synthesize Name;

// ------------ Constructor -----------
// Set the default position and orientation.
-(DRFrame*) init
{	
	// Allocate
	LocOrigin = [[DRVector alloc] initWithAllocation];
	LocForwardVector = [[DRVector alloc] initWithAllocation];
	LocUpVector = [[DRVector alloc] initWithAllocation];
	LocRotation = [[DRVector alloc] initWithAllocation];
	LocMatrix = [DRMatrix alloc];
	[LocMatrix initWithAllocation];
	
	WorldOrigin = [[DRVector alloc] initWithAllocation];
	WorldForwardVector = [[DRVector alloc] initWithAllocation];
	WorldUpVector = [[DRVector alloc] initWithAllocation];
	// WorldRotation = [[DRVector alloc] initWithAllocation];
	WorldMatrix = [DRMatrix alloc];
	[WorldMatrix initWithAllocation];
	
	memset(LocOrigin->Data, 0, sizeof(float)*VECTOR_DIMENSION);
	memset(LocForwardVector->Data, 0, sizeof(float)*VECTOR_DIMENSION);
	LocForwardVector->Data[2] = 1.0f; // Forward is -Z (default OpenGL)
	memset(LocUpVector->Data, 0, sizeof(float)*VECTOR_DIMENSION);
	LocUpVector->Data[1] = 1.0f;
	memset(LocRotation->Data, 0, sizeof(float)*VECTOR_DIMENSION);
	
	memset(WorldOrigin->Data, 0, sizeof(float)*VECTOR_DIMENSION);
	memset(WorldForwardVector->Data, 0, sizeof(float)*VECTOR_DIMENSION);
	WorldForwardVector->Data[2] = 1.0f; // Forward is -Z (default OpenGL)
	memset(WorldUpVector->Data, 0, sizeof(float)*VECTOR_DIMENSION);
	WorldUpVector->Data[1] = 1.0f;
	// memset(WorldRotation->Data, 0, sizeof(float)*VECTOR_DIMENSION);
	
	[self GetLocMatrix:LocMatrix->Data RotationOnly:NO];
	[DRMath CopyMatrixSrc:LocMatrix->Data Dest:WorldMatrix->Data];
	
	IsDirty = NO;
	
	Parent = nil;
	Sibling	= nil;
	Child = nil;
	
	Mesh = nil;
	
	return self;
}
-(void) dealloc
{
	[LocOrigin release];
	[LocForwardVector release];
	[LocUpVector release];
	[LocRotation release];
	[LocMatrix release];
	
	[WorldOrigin release];
	[WorldForwardVector release];
	[WorldUpVector release];
	// [WorldRotation release];
	[WorldMatrix release];
	
	[super dealloc];
}

//=======================================
// -- Accessors --
-(void) SetLocOriginX:(float)x Y:(float)y Z:(float)z
{
	LocOrigin->Data[0] = x;
	LocOrigin->Data[1] = y;
	LocOrigin->Data[2] = z;
	IsDirty = YES;
	[self Update];
}
-(void) SetWorldOriginX:(float)x Y:(float)y Z:(float)z
{
	WorldOrigin->Data[0] = x;
	WorldOrigin->Data[1] = y;
	WorldOrigin->Data[2] = z;
	IsDirty = YES;
}
-(void) SetLocForwardVectorX:(float)x Y:(float)y Z:(float)z
{
	LocForwardVector->Data[0] = x;
	LocForwardVector->Data[1] = y;
	LocForwardVector->Data[2] = z;
	IsDirty = YES;
}
-(void) SetWorldForwardVectorX:(float)x Y:(float)y Z:(float)z
{
	WorldForwardVector->Data[0] = x;
	WorldForwardVector->Data[1] = y;
	WorldForwardVector->Data[2] = z;
	IsDirty = YES;
}
-(void) SetLocUpVectorX:(float)x Y:(float)y Z:(float)z
{
	LocUpVector->Data[0] = x;
	LocUpVector->Data[1] = y;
	LocUpVector->Data[2] = z;
	IsDirty = YES;
}
-(void) SetWorldUpVectorX:(float)x Y:(float)y Z:(float)z
{
	WorldUpVector->Data[0] = x;
	WorldUpVector->Data[1] = y;
	WorldUpVector->Data[2] = z;
	IsDirty = YES;
}
-(void) SetLocRotationX:(float)x Y:(float)y Z:(float)z
{
	LocRotation->Data[0] = x;
	LocRotation->Data[1] = y;
	LocRotation->Data[2] = z;
	[self RotateLocZ:z];
	[self RotateLocY:y];
	[self RotateLocX:x];
	IsDirty = YES;
	[self Update];
}
-(void) SetLocOriginX:(float)tX OriginY:(float)tY OriginZ:(float)tZ RotationX:(float)rX RotationY:(float)rY RotationZ:(float)rZ
{
	LocOrigin->Data[0] = tX;
	LocOrigin->Data[1] = tY;
	LocOrigin->Data[2] = tZ;
	LocRotation->Data[0] = rX;
	LocRotation->Data[1] = rY;
	LocRotation->Data[2] = rZ;
	[self SetLocForwardVectorX:0.0f Y:0.0f Z:1.0f];
	[self SetLocUpVectorX:0.0f Y:1.0f Z:0.0f];
	[self RotateLocZ:rZ];
	[self RotateLocY:rY];
	[self RotateLocX:rX];
	IsDirty = YES;
	[self Update];
}
/*-(void) SetWorldRotationX:(float)x Y:(float)y Z:(float)z
{
	WorldRotation->Data[0] = x;
	WorldRotation->Data[1] = y;
	WorldRotation->Data[2] = z;
}*/
-(void) GetLocRightVector:(float*)result
{
	[DRMath CrossProductRes:result U:LocUpVector->Data V:LocForwardVector->Data];
}
-(void) GetWorldRightVector:(float*)result
{
	[DRMath CrossProductRes:result U:WorldUpVector->Data V:WorldForwardVector->Data];
}

//=======================================
// -- Methods --
//====================
// -- Translate --
-(void) TranslateLocX:(float)x Y:(float)y Z:(float)z
{
	LocOrigin->Data[0] += x;
	LocOrigin->Data[1] += y;
	LocOrigin->Data[2] += z;
}
-(void) TranslateWorldX:(float)x Y:(float)y Z:(float)z
{
	WorldOrigin->Data[0] += x;
	WorldOrigin->Data[1] += y;
	WorldOrigin->Data[2] += z;
}
-(void) MoveForewardLoc:(float)delta
{
	LocOrigin->Data[0] += LocForwardVector->Data[0] * delta;
	LocOrigin->Data[1] += LocForwardVector->Data[1] * delta;
	LocOrigin->Data[2] += LocForwardVector->Data[2] * delta;
}
-(void) MoveForewardWorld:(float)delta
{
	WorldOrigin->Data[0] += WorldOrigin->Data[0] * delta;
	WorldOrigin->Data[1] += WorldOrigin->Data[1] * delta;
	WorldOrigin->Data[2] += WorldOrigin->Data[2] * delta;
}
-(void) MoveRightLoc:(float)delta
{
	DRVector* rightVector = [[DRVector alloc] initWithAllocation];
	
	[DRMath CrossProductRes:rightVector->Data U:LocUpVector->Data V:LocForwardVector->Data];
	LocOrigin->Data[0] += rightVector->Data[0] * delta;
	LocOrigin->Data[1] += rightVector->Data[1] * delta;
	LocOrigin->Data[2] += rightVector->Data[2] * delta;
	
	[rightVector release];
}
-(void) MoveRightWorld:(float)delta
{
	DRVector* rightVector = [[DRVector alloc] initWithAllocation];
	
	[DRMath CrossProductRes:rightVector->Data U:WorldUpVector->Data V:WorldForwardVector->Data];
	WorldOrigin->Data[0] += rightVector->Data[0] * delta;
	WorldOrigin->Data[1] += rightVector->Data[1] * delta;
	WorldOrigin->Data[2] += rightVector->Data[2] * delta;
	
	[rightVector release];
}
-(void) MoveUpLoc:(float)delta
{
	LocOrigin->Data[0] += LocUpVector->Data[0] * delta;
	LocOrigin->Data[1] += LocUpVector->Data[1] * delta;
	LocOrigin->Data[2] += LocUpVector->Data[2] * delta;
}
-(void) MoveUpWorld:(float)delta
{
	WorldOrigin->Data[0] += WorldUpVector->Data[0] * delta;
	WorldOrigin->Data[1] += WorldUpVector->Data[1] * delta;
	WorldOrigin->Data[2] += WorldUpVector->Data[2] * delta;
}
//====================
// -- Matrix --
-(void) GetLocMatrix:(float*)matrix RotationOnly:(bool)rotationOnly
{
	DRVector* XAxis = [[DRVector alloc] initWithAllocation];
	[DRMath CrossProductRes:XAxis->Data U:LocUpVector->Data V:LocForwardVector->Data];
	
	// Set the X axis
	[DRMath SetMatrixColumnFromVector:XAxis->Data Matrix:matrix Column:0];
	matrix[3] = 0.0f;
	
	// Set the Y axis
	[DRMath SetMatrixColumnFromVector:LocUpVector->Data Matrix:matrix Column:1];
	matrix[7] = 0.0f;
	
	// Set the Z axis
	[DRMath SetMatrixColumnFromVector:LocForwardVector->Data Matrix:matrix Column:2];
	matrix[11] = 0.0f;
	
	if (rotationOnly)
	{
		matrix[12] = matrix[13] = matrix[14] = 0.0f;
	}
	else
	{
		[DRMath SetMatrixColumnFromVector:LocOrigin->Data Matrix:matrix Column:3];
	}
	
	matrix[15] = 1.0f;
	
	[XAxis release];
}
-(void) GetWorldMatrix:(float*)matrix RotationOnly:(bool)rotationOnly
{
	DRVector* XAxis = [[DRVector alloc] initWithAllocation];
	[DRMath CrossProductRes:XAxis->Data U:WorldUpVector->Data V:WorldForwardVector->Data];
	
	// Set the X axis
	[DRMath SetMatrixColumnFromVector:XAxis->Data Matrix:matrix Column:0];
	matrix[3] = 0.0f;
	
	// Set the Y axis
	[DRMath SetMatrixColumnFromVector:WorldUpVector->Data Matrix:matrix Column:1];
	matrix[7] = 0.0f;
	
	// Set the Z axis
	[DRMath SetMatrixColumnFromVector:WorldForwardVector->Data Matrix:matrix Column:2];
	matrix[11] = 0.0f;
	
	if (rotationOnly)
	{
		matrix[12] = matrix[13] = matrix[14] = 0.0f;
	}
	else
	{
		[DRMath SetMatrixColumnFromVector:WorldOrigin->Data Matrix:matrix Column:3];
	}
	
	matrix[15] = 1.0f;
	
	[XAxis release];
}
//====================
- (void) Update
{
	if (IsDirty)
	{
		[self GetLocMatrix:LocMatrix->Data RotationOnly:NO];
		IsDirty = NO;
	}
}
- (void) UpdateWithParent:(DRFrame*) parent
{	
	[self Update];
	
	// Multiply the matrices
	if (parent != nil)
	{
		[DRMath MatrixMultiplyA:parent.WorldMatrix->Data B:LocMatrix->Data product:WorldMatrix->Data];
	}
	else
	{
		[DRMath CopyMatrixSrc:LocMatrix->Data Dest:WorldMatrix->Data];
	}
	
	// Update all the siblings
	DRFrame* temp = Sibling;
	while (temp != nil)
	{
		[temp UpdateWithParent:parent];
		temp = temp.Sibling;
	}
	
	if (Child != nil)
	{
		[Child UpdateWithParent:self];
	}
}
-(void) RotateLocX:(float)x
{
	LocRotation->Data[0] += x;
	DRMatrix* rotMat = [DRMatrix alloc];
	[rotMat initWithAllocation];
	DRVector* cross = [[DRVector alloc] initWithAllocation];
	
	[DRMath CrossProductRes:cross->Data U:LocUpVector->Data V:LocForwardVector->Data];
	[DRMath RotationMatrix:rotMat->Data Angle:(x) X:cross->Data[0] Y:cross->Data[1] Z:cross->Data[2]];
	
	DRVector* newVec = [[DRVector alloc] initWithAllocation];
	newVec->Data[0] = rotMat->Data[0] * LocForwardVector->Data[0] + rotMat->Data[4] * LocForwardVector->Data[1] + rotMat->Data[8] * LocForwardVector->Data[2];
	newVec->Data[1] = rotMat->Data[1] * LocForwardVector->Data[0] + rotMat->Data[5] * LocForwardVector->Data[1] + rotMat->Data[9] * LocForwardVector->Data[2];
	newVec->Data[2] = rotMat->Data[2] * LocForwardVector->Data[0] + rotMat->Data[6] * LocForwardVector->Data[1] + rotMat->Data[10] * LocForwardVector->Data[2];
	[DRMath CopyVectorSrc:newVec->Data Dest:LocForwardVector->Data];
	
	// Update the up vector
	newVec->Data[0] = rotMat->Data[0] * LocUpVector->Data[0] + rotMat->Data[4] * LocUpVector->Data[1] + rotMat->Data[8] * LocUpVector->Data[2];
	newVec->Data[1] = rotMat->Data[1] * LocUpVector->Data[0] + rotMat->Data[5] * LocUpVector->Data[1] + rotMat->Data[9] * LocUpVector->Data[2];
	newVec->Data[2] = rotMat->Data[2] * LocUpVector->Data[0] + rotMat->Data[6] * LocUpVector->Data[1] + rotMat->Data[10] * LocUpVector->Data[2];
	[DRMath CopyVectorSrc:newVec->Data Dest:LocUpVector->Data];
	
	[newVec release];
	[cross	release];
	[rotMat release];
	
	IsDirty = YES;
}
-(void) RotateLocY:(float)y
{
	LocRotation->Data[1] += y;
	DRMatrix* rotMat = [DRMatrix alloc];
	[rotMat	initWithAllocation];
	DRVector* newVec = [[DRVector alloc] initWithAllocation];
	
	[DRMath RotationMatrix:rotMat->Data Angle:(y) X:LocUpVector->Data[0] Y:LocUpVector->Data[1] Z:LocUpVector->Data[2]];
	
	// Update the forward vector
	newVec->Data[0] = rotMat->Data[0] * LocForwardVector->Data[0] + rotMat->Data[4] * LocForwardVector->Data[1] + rotMat->Data[8] * LocForwardVector->Data[2];
	newVec->Data[1] = rotMat->Data[1] * LocForwardVector->Data[0] + rotMat->Data[5] * LocForwardVector->Data[1] + rotMat->Data[9] * LocForwardVector->Data[2];
	newVec->Data[2] = rotMat->Data[2] * LocForwardVector->Data[0] + rotMat->Data[6] * LocForwardVector->Data[1] + rotMat->Data[10] * LocForwardVector->Data[2];
	[DRMath CopyVectorSrc:newVec->Data Dest:LocForwardVector->Data];
	
	[newVec release];
	[rotMat release];
	
	IsDirty = YES;
}
-(void) RotateLocZ:(float)z
{
	LocRotation->Data[2] += z;
	DRMatrix* rotMat = [DRMatrix alloc];
	[rotMat initWithAllocation];
	DRVector* newVec = [[DRVector alloc] initWithAllocation];
	
	[DRMath RotationMatrix:rotMat->Data Angle:(z) X:LocForwardVector->Data[0] Y:LocForwardVector->Data[1] Z:LocForwardVector->Data[2]];
	
	// Update the forward vector
	newVec->Data[0] = rotMat->Data[0] * LocUpVector->Data[0] + rotMat->Data[4] * LocUpVector->Data[1] + rotMat->Data[8] * LocUpVector->Data[2];
	newVec->Data[1] = rotMat->Data[1] * LocUpVector->Data[0] + rotMat->Data[5] * LocUpVector->Data[1] + rotMat->Data[9] * LocUpVector->Data[2];
	newVec->Data[2] = rotMat->Data[2] * LocUpVector->Data[0] + rotMat->Data[6] * LocUpVector->Data[1] + rotMat->Data[10] * LocUpVector->Data[2];
	[DRMath CopyVectorSrc:newVec->Data Dest:LocUpVector->Data];
	
	[newVec release];
	[rotMat release];
	
	IsDirty = YES;
}

//====================
// -- Rotate --
/*-(void) RotateWorldX:(float)x
{
	WorldRotation->Data[0] += x;
	DRMatrix* rotMat = [DRMatrix alloc];
	[rotMat	initWithAllocation];
	DRVector* cross = [[DRVector alloc] initWithAllocation];
	
	[DRMath CrossProductRes:cross->Data U:WorldUpVector->Data V:WorldForwardVector->Data];
	[DRMath RotationMatrix:rotMat->Data Angle:WorldRotation->Data[0] X:cross->Data[0] Y:cross->Data[1] Z:cross->Data[2]];
	
	DRVector* newVec = [[DRVector alloc] initWithAllocation];
	newVec->Data[0] = rotMat->Data[0] * WorldForwardVector->Data[0] + rotMat->Data[4] * WorldForwardVector->Data[1] + rotMat->Data[8] * WorldForwardVector->Data[2];
	newVec->Data[1] = rotMat->Data[1] * WorldForwardVector->Data[0] + rotMat->Data[5] * WorldForwardVector->Data[1] + rotMat->Data[9] * WorldForwardVector->Data[2];
	newVec->Data[2] = rotMat->Data[2] * WorldForwardVector->Data[0] + rotMat->Data[6] * WorldForwardVector->Data[1] + rotMat->Data[10] * WorldForwardVector->Data[2];
	[DRMath CopyVectorSrc:newVec->Data Dest:WorldForwardVector->Data];
	
	// Update the up vector
	newVec->Data[0] = rotMat->Data[0] * WorldUpVector->Data[0] + rotMat->Data[4] * WorldUpVector->Data[1] + rotMat->Data[8] * WorldUpVector->Data[2];
	newVec->Data[1] = rotMat->Data[1] * WorldUpVector->Data[0] + rotMat->Data[5] * WorldUpVector->Data[1] + rotMat->Data[9] * WorldUpVector->Data[2];
	newVec->Data[2] = rotMat->Data[2] * WorldUpVector->Data[0] + rotMat->Data[6] * WorldUpVector->Data[1] + rotMat->Data[10] * WorldUpVector->Data[2];
	[DRMath CopyVectorSrc:newVec->Data Dest:WorldUpVector->Data];
	
	[newVec release];
	[cross	release];
	[rotMat release];
}*/
/*-(void) RotateWorldY:(float)y
{
	WorldRotation->Data[1] += y;
	
	DRMatrix* rotMat = [DRMatrix alloc];
	[rotMat initWithAllocation];
	DRVector* newVec = [[DRVector alloc] initWithAllocation];
	
	[DRMath RotationMatrix:rotMat->Data Angle:WorldRotation->Data[1] X:WorldUpVector->Data[0] Y:WorldUpVector->Data[1] Z:WorldUpVector->Data[2]];
	
	// Update the forward vector
	newVec->Data[0] = rotMat->Data[0] * WorldForwardVector->Data[0] + rotMat->Data[4] * WorldForwardVector->Data[1] + rotMat->Data[8] * WorldForwardVector->Data[2];
	newVec->Data[1] = rotMat->Data[1] * WorldForwardVector->Data[0] + rotMat->Data[5] * WorldForwardVector->Data[1] + rotMat->Data[9] * WorldForwardVector->Data[2];
	newVec->Data[2] = rotMat->Data[2] * WorldForwardVector->Data[0] + rotMat->Data[6] * WorldForwardVector->Data[1] + rotMat->Data[10] * WorldForwardVector->Data[2];
	[DRMath CopyVectorSrc:newVec->Data Dest:WorldForwardVector->Data];
	
	[newVec release];
	[rotMat release];
}*/
/*-(void) RotateWorldZ:(float)z
{
	WorldRotation->Data[2] += z;
	
	DRMatrix* rotMat = [DRMatrix alloc];
	[rotMat initWithAllocation];
	DRVector* newVec = [[DRVector alloc] initWithAllocation];
	
	[DRMath RotationMatrix:rotMat->Data Angle:WorldRotation->Data[2] X:WorldForwardVector->Data[0] Y:WorldForwardVector->Data[1] Z:WorldForwardVector->Data[2]];
	
	// Update the forward vector
	newVec->Data[0] = rotMat->Data[0] * WorldUpVector->Data[0] + rotMat->Data[4] * WorldUpVector->Data[1] + rotMat->Data[8] * WorldUpVector->Data[2];
	newVec->Data[1] = rotMat->Data[1] * WorldUpVector->Data[0] + rotMat->Data[5] * WorldUpVector->Data[1] + rotMat->Data[9] * WorldUpVector->Data[2];
	newVec->Data[2] = rotMat->Data[2] * WorldUpVector->Data[0] + rotMat->Data[6] * WorldUpVector->Data[1] + rotMat->Data[10] * WorldUpVector->Data[2];
	[DRMath CopyVectorSrc:newVec->Data Dest:WorldUpVector->Data];
	
	[newVec release];
	[rotMat release];
}*/
-(void) NormalizeLoc
{
	DRVector* cross = [DRVector alloc];
	[cross initWithAllocation];
	 
	[DRMath CrossProductRes:cross->Data U:LocUpVector->Data V:LocForwardVector->Data];
	
	[DRMath CrossProductRes:LocForwardVector->Data U:cross->Data V:LocUpVector->Data];
	
	[DRMath NormalizeVector:LocUpVector->Data];
	[DRMath NormalizeVector:LocForwardVector->Data];
}
-(void) NormalizeWorld
{
	DRVector* cross = [DRVector alloc];
	[cross initWithAllocation];
	
	[DRMath CrossProductRes:cross->Data U:WorldUpVector->Data V:WorldForwardVector->Data];
	
	[DRMath CrossProductRes:WorldForwardVector->Data U:cross->Data V:WorldUpVector->Data];
	
	[DRMath NormalizeVector:WorldUpVector->Data];
	[DRMath NormalizeVector:WorldForwardVector->Data];
}
//====================
// -- Tree management --
- (void) AddChild:(DRFrame*) child
{
	child.Parent = self;
	child.Sibling = self.Child;
	self.Child = child;
}
- (DRFrame*) GetFrameByName:(NSString*) name
{
	if ([Name isEqualToString:name])
	{
		return self;
	}
	
	// Update all the siblings
	DRFrame* temp = Sibling;
	while (temp != nil)
	{
		DRFrame* res = [temp GetFrameByName:name];
		if (res != nil)
			return res;
		temp = temp.Sibling;
	}
	
	if (Child != nil)
	{
		return [Child GetFrameByName:name];
	}
	
	return nil;
}

@end
