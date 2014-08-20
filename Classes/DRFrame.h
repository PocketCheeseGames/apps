//
//  DRFrame.h
//  Draco Engine
//
//  Created by yan zhang on 9/15/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#ifndef _DRFRAME_H_
#define	_DRFRAME_H_

#import <Foundation/Foundation.h>
#import "DRMath.h"
#import "DRMesh.h"

@interface DRFrame : NSObject {
@protected
	
	// Local matrix
	DRVector* LocOrigin;
	DRVector* LocForwardVector;
	DRVector* LocUpVector;
	DRVector* LocRotation;
	DRMatrix* LocMatrix;
	
	// World matrix
	DRVector* WorldOrigin;
	DRVector* WorldForwardVector;
	DRVector* WorldUpVector;
	// DRVector* WorldRotation;
	DRMatrix* WorldMatrix;
	
	DRFrame* Parent;
	DRFrame* Sibling;
	DRFrame* Child;
	
	DRMesh* Mesh;
	
	bool IsDirty;
	
	NSString* Name;
}

@property (nonatomic, assign) DRVector* LocOrigin;
@property (nonatomic, assign) DRVector* LocForwardVector;
@property (nonatomic, assign) DRVector* LocUpVector;
@property (nonatomic, assign) DRVector* LocRotation;
@property (nonatomic, assign) DRMatrix* LocMatrix;

@property (nonatomic, assign) DRVector* WorldOrigin;
@property (nonatomic, assign) DRVector* WorldForwardVector;
@property (nonatomic, assign) DRVector* WorldUpVector;
// @property (nonatomic, assign) DRVector* WorldRotation;
@property (nonatomic, assign) DRMatrix* WorldMatrix;

@property (nonatomic, assign) DRFrame* Parent;
@property (nonatomic, assign) DRFrame* Sibling;
@property (nonatomic, assign) DRFrame* Child;

@property (nonatomic, assign) DRMesh* Mesh;
@property (nonatomic, assign) NSString* Name;

//=======================================
// -- Constructor and Destructor --
-(DRFrame*) init;
-(void) dealloc;

//=======================================
// -- Accessors --
-(void) SetLocOriginX:(float)x Y:(float)y Z:(float)z;
-(void) SetWorldOriginX:(float)x Y:(float)y Z:(float)z;
-(void) SetLocForwardVectorX:(float)x Y:(float)y Z:(float)z;
-(void) SetWorldForwardVectorX:(float)x Y:(float)y Z:(float)z;
-(void) SetLocUpVectorX:(float)x Y:(float)y Z:(float)z;
-(void) SetWorldUpVectorX:(float)x Y:(float)y Z:(float)z;
-(void) SetLocRotationX:(float)x Y:(float)y Z:(float)z;
// -(void) SetWorldRotationX:(float)x Y:(float)y Z:(float)z;
-(void) GetLocRightVector:(float*)result;
-(void) GetWorldRightVector:(float*)result;
-(void) SetLocOriginX:(float)tX OriginY:(float)tY OriginZ:(float)tZ RotationX:(float)rX RotationY:(float)rY RotationZ:(float)rZ;

//=======================================
// -- Methods --
//====================
// -- Translate --
-(void) TranslateLocX:(float)x Y:(float)y Z:(float)z;
-(void) TranslateWorldX:(float)x Y:(float)y Z:(float)z;
-(void) MoveForewardLoc:(float)delta;
-(void) MoveForewardWorld:(float)delta;
-(void) MoveRightLoc:(float)delta;
-(void) MoveRightWorld:(float)delta;
-(void) MoveUpLoc:(float)delta;
-(void) MoveUpWorld:(float)delta;
//====================
// -- Rotate --
-(void) RotateLocX:(float)x;
-(void) RotateLocY:(float)y;
-(void) RotateLocZ:(float)z;
//-(void) RotateWorldX:(float)x;
//-(void) RotateWorldY:(float)y;
//-(void) RotateWorldZ:(float)z;
-(void) NormalizeLoc;
-(void) NormalizeWorld;
// -(void) UpdateVectorsLoc;
// -(void) UpdateVectorsWorld;
//====================
// -- Matrix --
-(void) GetLocMatrix:(float*)matrix RotationOnly:(bool)rotationOnly;
-(void) GetWorldMatrix:(float*)matrix RotationOnly:(bool)rotationOnly;

- (void) Update;
- (void) UpdateWithParent:(DRFrame*) parent;
//- (void) LookAtX:(float) fX Y:(float) fY;
//- (void) LookToX:(float) fX Y:(float) fY Velocity:(float) fVel;
//====================
// -- Tree management --
- (void) AddChild:(DRFrame*) child;
- (DRFrame*) GetFrameByName:(NSString*) name;

@end

#endif
