//
//  DRMath.h
//  Draco Engine
//
//  Created by yan zhang on 5/25/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#ifndef _DRMATH_H_
#define _DRMATH_H_

#import <Foundation/Foundation.h>
#import <math.h>
#import "DRVector.h"
#import "DRMatrix.h"

#define MATH_PRECISION_STEPS 3600

//===================================
// -- Useful constants --
#define DR_PI (3.14159265358979323846)
#define DR_PI_DIV_180 (0.017453292519943296)
#define DR_INV_PI_DIV_180 (57.2957795130823229)

//===================================
// -- Useful macros --
#define DRDegToRad(x)	((x)*DR_PI_DIV_180)
#define DRRadToDeg(x)	((x)*DR_INV_PI_DIV_180)

//===================================
// -- Class definition --
@interface DRMath : NSObject {
@private
	float _pSinPreComputes[MATH_PRECISION_STEPS];
	float _pCosinPreComputes[MATH_PRECISION_STEPS];
}

//===================================
// -- Singleton --
+ (DRMath*) CreateInstance;
+ (DRMath*) GetInstance;
+ (void) DeleteInstance;

//===================================
// memory buffer optimization 
// for Sin and Cosin
- (DRMath*) Init;
- (float) Sin:(float) fAngle;
- (float) Cosin:(float) fAngle;

//===================================
// -- 2D Math --
+ (float) AngleBetweenTwoLinesX1:(float)fX1 Y1:(float)fY1 X2:(float)fX2 Y2:(float)fY2;
+ (float) DistanceBetweenTwoPointsSquaredX1:(float)fX1 Y1:(float)fY1 X2:(float)fX2 Y2:(float)fY2;
+ (BOOL) CircleCollidsX1:(float)fX1 Y1:(float)fY1 Radius1:(float)fRadius1 X2:(float)fX2 Y2:(float)fY2 Radius2:(float)fRadius2;
+ (BOOL) RectCircleCollidsRectCenterX:(float)fRectX RectCenterY:(float)fRectY RectWidth:(float)fRectWidth RectHeight:(float)fRectHeight CircleCenterX:(float)fCX CircleCenterY:(float)fCY CircleRadius:(float)fRadius;
+ (BOOL) RCCollideRCX:(float)fRectX RCY:(float)fRectY RWidth:(float)fRectWidth RHeight:(float)fRectHeight CCenterX:(float*)fCX CCenterY:(float*)fCY CRadius:(float)fCRadius;
+ (void) NormalizeX:(float*)fX Y:(float*)fY;

//===================================
// -- 3D Math --
//===================================
// -- Vector functions --
// -----------------
// Copy vectors
+ (void) CopyVectorSrc:(float*) SrcVec Dest:(float*) DestVec;
// -----------------
// Add vectors
+ (void) AddVectorsRes:(float*) ResVec Src:(float*) SrcVec Dest:(float*) DestVec;
// -----------------
// Subtract vectors
+ (void) SubtractVectorsRes:(float*) ResVec Src:(float*) SrcVec Dest:(float*) DestVec;
// -----------------
// Scale vectors
+ (void) ScaleVector:(float*) Vec Scale:(float) scale;
// -----------------
// Cross product, Only the x,y,z components of a vector are effected
+ (void) CrossProductRes:(float*) ResVec U:(float*) u V:(float*) v;
// -----------------
// Dot product, Only the x,y,z components of a vector are used
+ (float) DotProductU:(float*) u V:(float*) v;
// -----------------
// Get angle between vectors, only for three component vectors
+ (float) GetAngleBetweenVectorsU:(float*) u V:(float*) v;
// -----------------
// Get square of a vector's length, only relevant to 3 component vector
+ (float) GetVectorLengthSquared:(float*) u;
// -----------------
// Get length of a vector
+ (float) GetVectorLength:(float*) u;
// -----------------
// Normalize a vector, only relevant to 3 component vector
+ (void) NormalizeVector:(float*) u;
// -----------------
// Get the distance between two points squared, only relevant to 3 component vector
+ (float) DistanceSqrU:(float*)u V:(float*)v;
// -----------------
// Get the distance between two points, only relevant to 3 component vector
+ (float) DistanceU:(float*)u V:(float*)v;

//===================================
// -- Matrix functions --
// -----------------
// Copy matrix
+ (void) CopyMatrixSrc:(float*) SrcMatrix Dest:(float*) DestMatrix;
// -----------------
// Load Identity matrix
+ (void) LoadIdentity:(float*) m;
// -----------------
// Get the matrix column, column starts at 0, only 3 components are relevant
+ (void) GetMatrixColumnIntoVector:(float*)v Matrix:(float*)m Column:(int) column;
// -----------------
// Set the column, column starts at 0, only 3 components are relevant
+ (void) SetMatrixColumnFromVector:(float*)v Matrix:(float*)m Column:(int) column;
// -----------------
// Get an element
+ (float) GetMatrixElement:(float*)m Column:(int)column Row:(int)row;
// -----------------
// Set an element
+ (void) SetMatrixElement:(float*)m Column:(int)column Row:(int)row Data:(float)data;
// -----------------
// Multiply matrix
+ (void) MatrixMultiplyA:(float*)a B:(float*)b product:(float*) product;
// -----------------
// Transform vector
+ (void) TransformVector:(float*)vOut Matrix:(float*)m Vector:(float*)v;
// -----------------
// Rotate vector
+ (void) RotateVector:(float*)vOut Matrix:(float*)m Vector:(float*)v;
// -----------------
// Scale matrix
+ (void) ScaleMatrix:(float*)m Scale:(float)scale;
// -----------------
// Create a rotation matrix
+ (void) RotationMatrix:(float*)m Angle:(float)angle X:(float)x Y:(float)y Z:(float)z;
// -----------------
// Create a translation matrix
+ (void) TranslationMatrix:(float*)m X:(float)x Y:(float)y Z:(float)z;

//===================================
// -- misc. functions --
// -----------------
// Find the normal given three points
+ (void) FindNormal:(float*) result Point1:(float*)p1 Point2:(float*)p2 Point3:(float*)p3;
// -----------------
// Get the plane equation
+ (void) GetPlaneEquation:(float*) planeEq Point1:(float*)p1 Point2:(float*)p2 Point3:(float*)p3;
// -----------------
// Get the distance to plane
+ (float) GetDistanceToPlane:(float*) point PlaneEq:(float*)plane;

@end

#endif