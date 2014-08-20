//
//  DRMath.m
//  Draco Engine
//
//  Created by yan zhang on 5/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <string.h>
#import "DRMath.h"

static DRMath* gpDRMathInstance = nil;

static float IdentityMatrix[MATRIX_DIMENSION] = {	1.0f, 0.0f, 0.0f, 0.0f,
0.0f, 1.0f, 0.0f, 0.0f,
0.0f, 0.0f, 1.0f, 0.0f,
0.0f, 0.0f, 0.0f, 1.0f };

@implementation DRMath

- (DRMath *) Init
{
	for (float i=0; i<MATH_PRECISION_STEPS; i++)
	{
		int nIndex = (int)i;
		float fAngle = (i/(MATH_PRECISION_STEPS/360.0f))/(180/M_PI);
		float fSin = sin(fAngle);
		float fCos = cos(fAngle);
		_pSinPreComputes[nIndex] = fSin;
		_pCosinPreComputes[nIndex] = fCos;
	}
	return self;
}

- (float) Sin:(float) fAngle
{
	int nIndex = ((int)(fAngle * (MATH_PRECISION_STEPS/360.0f))) % MATH_PRECISION_STEPS;
	return _pSinPreComputes[nIndex];
}

- (float) Cosin:(float) fAngle
{
	int nIndex = ((int)(fAngle * (MATH_PRECISION_STEPS/360.0f))) % MATH_PRECISION_STEPS;
	return _pCosinPreComputes[nIndex];
}


+ (DRMath*) CreateInstance
{
	if (gpDRMathInstance != nil)
	{
		[gpDRMathInstance release];
		gpDRMathInstance = nil;
	}
	gpDRMathInstance = [[DRMath alloc] Init];
	return gpDRMathInstance;
}
+ (DRMath*) GetInstance
{
	return gpDRMathInstance;
}
+ (void) DeleteInstance
{
	[gpDRMathInstance release];
}

+ (float) AngleBetweenTwoLinesX1:(float)fX1 Y1:(float)fY1 X2:(float)fX2 Y2:(float)fY2
{
	float fY = fY2 - fY1;
	float fX = fX2 - fX1;
	float fAngle = atan(fY/fX)*(180/M_PI);
	
	if (fX > 0.0f)
	{
		fAngle += 180.0f;
	}
	
	while (fAngle < 0.0f)
	{
		fAngle += 360.0f;
	}
	while (fAngle > 360.0f)
	{
		fAngle -= 360.0f;
	}
	/**/
	
	return fAngle;
}

+ (float) DistanceBetweenTwoPointsSquaredX1:(float)fX1 Y1:(float)fY1 X2:(float)fX2 Y2:(float)fY2
{
	float fD = ((fX2 - fX1) * (fX2 - fX1) + (fY2 - fY1) * (fY2 - fY1));
	return fD;
}

+ (BOOL) CircleCollidsX1:(float)fX1 Y1:(float)fY1 Radius1:(float)fRadius1 X2:(float)fX2 Y2:(float)fY2 Radius2:(float)fRadius2
{
	float fD = [DRMath DistanceBetweenTwoPointsSquaredX1:fX1 Y1:fY1 X2:fX2 Y2:fY2];
	fD = fabs(fD);
	BOOL bResult = fD <= (fRadius1 + fRadius2) * (fRadius1 + fRadius2);
	return bResult;
}

+ (BOOL) RectCircleCollidsRectCenterX:(float)fRectX RectCenterY:(float)fRectY RectWidth:(float)fRectWidth RectHeight:(float)fRectHeight CircleCenterX:(float)fCX CircleCenterY:(float)fCY CircleRadius:(float)fRadius
{
	// Test each side, if outside, then not colliding
	if (fCX + fRadius < fRectX - fRectWidth * 0.5f)
		return NO;
	if (fCX - fRadius > fRectX + fRectWidth * 0.5f)
		return NO;
	if (fCY + fRadius < fRectY - fRectHeight * 0.5f)
		return NO;
	if (fCY - fRadius > fRectY + fRectHeight * 0.5f)
		return NO;
	
	return YES;
}

+ (BOOL) RCCollideRCX:(float)fRectX RCY:(float)fRectY RWidth:(float)fRectWidth RHeight:(float)fRectHeight CCenterX:(float*)fCX CCenterY:(float*)fCY CRadius:(float)fCRadius
{
	// Test each side, if outside, then not colliding
	if (*fCX + fCRadius < fRectX - fRectWidth * 0.5f)
		return NO;
	if (*fCX - fCRadius > fRectX + fRectWidth * 0.5f)
		return NO;
	if (*fCY + fCRadius < fRectY - fRectHeight * 0.5f)
		return NO;
	if (*fCY - fCRadius > fRectY + fRectHeight * 0.5f)
		return NO;
	
	// Find the side that it is colliding with and react accordingly
	if ((*fCX > fRectX - fRectWidth * 0.5f) &&
		(*fCX < fRectX + fRectWidth * 0.5f) &&
		fabs(*fCY - fRectY + fRectHeight * 0.5f) < fCRadius)
	{
		*fCY = fRectY - fRectHeight * 0.5f - fCRadius;
		return YES;
	}
	
	// Find the side that it is colliding with and react accordingly
	if ((*fCX > fRectX - fRectWidth * 0.5f) &&
		(*fCX < fRectX + fRectWidth * 0.5f) &&
		fabs(*fCY - fRectY - fRectHeight * 0.5f) < fCRadius)
	{
		*fCY = fRectY + fRectHeight * 0.5f + fCRadius;
		return YES;
	}
	
	// Find the side that it is colliding with and react accordingly
	if ((*fCY > fRectY - fRectHeight * 0.5f) &&
		(*fCY < fRectY + fRectHeight * 0.5f) &&
		fabs(*fCX - fRectX + fRectWidth * 0.5f) < fCRadius)
	{
		*fCX = fRectX - fRectWidth * 0.5f - fCRadius;
		return YES;
	}
	
	// Find the side that it is colliding with and react accordingly
	if ((*fCY > fRectY - fRectHeight * 0.5f) &&
		(*fCY < fRectY + fRectHeight * 0.5f) &&
		fabs(*fCX - fRectX - fRectWidth * 0.5f) < fCRadius)
	{
		*fCX = fRectX + fRectWidth * 0.5f + fCRadius;
		return YES;
	}
	
	return YES;
}

+ (void) NormalizeX:(float*)fX Y:(float*)fY
{
	float fDenom = (fabs(*fX) + fabs(*fY)) / 2.0f;
	*fX = *fX / fDenom;
	*fY = *fY / fDenom;
}

//===================================
// -- 3D Math --
// -----------------
// Copy vectors
+ (void) CopyVectorSrc:(float*) SrcVec Dest:(float*) DestVec
{
	memcpy(DestVec, SrcVec, sizeof(float)*VECTOR_DIMENSION);
}
// -----------------
// Add vectors
+ (void) AddVectorsRes:(float*) ResVec Src:(float*) SrcVec Dest:(float*) DestVec
{
	ResVec[0] = SrcVec[0] + DestVec[0];
	ResVec[1] = SrcVec[1] + DestVec[1];
	ResVec[2] = SrcVec[2] + DestVec[2];
	ResVec[3] = SrcVec[3] + DestVec[3];
}
// -----------------
// Subtract vectors
+ (void) SubtractVectorsRes:(float*) ResVec Src:(float*) SrcVec Dest:(float*) DestVec
{
	ResVec[0] = SrcVec[0] - DestVec[0];
	ResVec[1] = SrcVec[1] - DestVec[1];
	ResVec[2] = SrcVec[2] - DestVec[2];
	ResVec[3] = SrcVec[3] - DestVec[3];
}
// -----------------
// Scale vectors
+ (void) ScaleVector:(float*) Vec Scale:(float) scale
{
	Vec[0] *= scale;
	Vec[1] *= scale;
	Vec[2] *= scale;
	Vec[3] *= scale;
}
// -----------------
// Cross product
+ (void) CrossProductRes:(float*) ResVec U:(float*) u V:(float*) v
{
	ResVec[0] = u[1]*v[2] - v[1]*u[2];
	ResVec[1] = -1.0f*u[0]*v[2] + v[0]*u[2];
	ResVec[2] = u[0]*v[1] - v[0]*u[1];
}
// -----------------
// Dot product, Only the x,y,z components of a vector are used
+ (float) DotProductU:(float*) u V:(float*) v
{
	return u[0]*v[0]+u[1]*v[1]+u[2]*v[2];
}
// -----------------
// Get angle between vectors, only for three component vectors
+ (float) GetAngleBetweenVectorsU:(float*) u V:(float*) v
{
	float temp = [DRMath DotProductU:u V:v];
	return (float)acos((double)temp);
}
// -----------------
// Get square of a vector's length
+ (float) GetVectorLengthSquared:(float*) u
{
	return (u[0]*u[0]) + (u[1]*u[1]) + (u[2]*u[2]);
}
// -----------------
// Get length of a vector
+ (float) GetVectorLength:(float*) u
{
	return (float)sqrt([DRMath GetVectorLengthSquared:u]);
}
// -----------------
// Normalize a vector, only relevant to 3 component vector
+ (void) NormalizeVector:(float*) u
{
	[DRMath ScaleVector:u Scale:[DRMath GetVectorLength:u]];
}
// -----------------
// Get the distance between two points, only relevant to 3 component vector
+ (float) DistanceSqrU:(float*)u V:(float*)v
{
	float x = u[0] - v[0];
	x = x*x;
	float y = u[1] - v[1];
	y = y*y;
	float z = u[2] - v[2];
	z = z*z;
	return (x+y+z);
}
// -----------------
// Get the distance between two points, only relevant to 3 component vector
+ (float) DistanceU:(float*)u V:(float*)v
{
	return (float)sqrt((double)[DRMath DistanceSqrU:u V:v]);
}
//===================================
// -- Matrix functions --
// -----------------
// Copy matrix
+ (void) CopyMatrixSrc:(float*) SrcMatrix Dest:(float*) DestMatrix
{
	memcpy(DestMatrix, SrcMatrix, sizeof(float)*MATRIX_DIMENSION);
}
// -----------------
// Load Identity matrix
+ (void) LoadIdentity:(float*) m
{
	memcpy(m, IdentityMatrix, sizeof(float)*MATRIX_DIMENSION);
}
// -----------------
// Get the matrix column
+ (void) GetMatrixColumnIntoVector:(float*)v Matrix:(float*)m Column:(int) column
{
	memcpy(v, m + (4 * column), sizeof(float)*3);
}
// -----------------
// Set the column, column starts at 0
+ (void) SetMatrixColumnFromVector:(float*)v Matrix:(float*)m Column:(int) column
{
	memcpy(m + (4 * column), v, sizeof(float)*3);
}
// -----------------
// Get an element
+ (float) GetMatrixElement:(float*)m Column:(int)column Row:(int)row
{
	return m[(column * 4) + row];
}
// -----------------
// Set an element
+ (void) SetMatrixElement:(float*)m Column:(int)column Row:(int)row Data:(float)data
{
	m[(column * 4) + row] = data;
}
// -----------------
// Multiply matrix
+ (void) MatrixMultiplyA:(float*)a B:(float*)b product:(float*) product
{
#define A(row,col) a[(col<<2)+row]
#define B(row,col) b[(col<<2)+row]
#define P(row,col) product[(col<<2)+row]
	
	for (int i=0; i<4; i++)
	{
		float ai0 = A(i,0), ai1 = A(i,1), ai2 = A(i,2), ai3 = A(i,3);
		P(i,0) = ai0 * B(0,0) + ai1 * B(1,0) + ai2 * B(2,0) + ai3 * B(3,0);
		P(i,1) = ai0 * B(0,1) + ai1 * B(1,1) + ai2 * B(2,1) + ai3 * B(3,1);
		P(i,2) = ai0 * B(0,2) + ai1 * B(1,2) + ai2 * B(2,2) + ai3 * B(3,2);
		P(i,3) = ai0 * B(0,3) + ai1 * B(1,3) + ai2 * B(2,3) + ai3 * B(3,3);
	}
	
#undef A
#undef B
#undef C
}
// -----------------
// Transform vector
+ (void) TransformVector:(float*)vOut Matrix:(float*)m Vector:(float*)v
{
	vOut[0] = m[0] * v[0] + m[4] * v[1] + m[8] * v[2] + m[12] * v[3];
	vOut[1] = m[1] * v[0] + m[5] * v[1] + m[9] * v[2] + m[13] * v[3];
	vOut[2] = m[2] * v[0] + m[6] * v[1] + m[10] * v[2] + m[14] * v[3];
	vOut[3] = m[3] * v[0] + m[7] * v[1] + m[11] * v[2] + m[15] * v[3];
}
// -----------------
// Rotate vector
+ (void) RotateVector:(float*)vOut Matrix:(float*)m Vector:(float*)v
{
	vOut[0] = m[0]*v[0] + m[3]*v[1] + m[6]*v[2];
	vOut[1] = m[1]*v[0] + m[4]*v[1] + m[7]*v[2];
	vOut[2] = m[2]*v[0] + m[5]*v[1] + m[8]*v[2];
}
// -----------------
// Scale matrix
+ (void) ScaleMatrix:(float*)m Scale:(float)scale
{
	for (int i=15; i>=0; i--)
	{
		m[i] *= scale;
	}
}
// -----------------
// Create a rotation matrix
+ (void) RotationMatrix:(float*)m Angle:(float)angle X:(float)x Y:(float)y Z:(float)z
{
	float mag, s, c;
	float xx, yy, zz, xy, yz, zx, xs, ys, zs, one_c;
	
	s=(float)(sin(angle));
	c=(float)(cos(angle));
	mag=(float)(sqrt((double)(x*x+y*y+z*z)));
	
	if (mag == 0.0f)
	{
		[DRMath LoadIdentity:m];
		return;
	}
	
	x /= mag;
	y /= mag;
	z /= mag;
	
#define M(row,col) m[col*4+row]
	
	xx = x*x;
	yy = y*y;
	zz = z*z;
	xy = x*y;
	yz = y*z;
	zx = z*x;
	xs = x*s;
	ys = y*s;
	zs = z*s;
	one_c = 1.0f - c;
	
	M(0,0) = (one_c * xx) + c;
	M(0,1) = (one_c * xy) - zs;
	M(0,2) = (one_c * zx) + ys;
	M(0,3) = 0.0f;
	
	M(1,0) = (one_c * xy) + zs;
	M(1,1) = (one_c * yy) + c;
	M(1,2) = (one_c * yz) - xs;
	M(1,3) = 0.0f;
	
	M(2,0) = (one_c * zx) - ys;
	M(2,1) = (one_c * yz) + xs;
	M(2,2) = (one_c * zz) + c;
	M(2,3) = 0.0f;
	
	M(3,0) = 0.0f;
	M(3,1) = 0.0f;
	M(3,2) = 0.0f;
	M(3,3) = 0.0f;
	
#undef M
}
// -----------------
// Create a translation matrix
+ (void) TranslationMatrix:(float*)m X:(float)x Y:(float)y Z:(float)z
{
	[DRMath LoadIdentity:m];
	m[12] = x;
	m[13] = y;
	m[14] = z;
}
//===================================
// -- misc. functions --
// -----------------
// Find the normal given three points
+ (void) FindNormal:(float*) result Point1:(float*)p1 Point2:(float*)p2 Point3:(float*)p3
{
	// The the two vectors to do a cross product
	DRVector* v1 = [[DRVector alloc] init];
	DRVector* v2 = [[DRVector alloc] init];
	
	[DRMath SubtractVectorsRes:v1->Data Src:p3 Dest:p1];
	[DRMath SubtractVectorsRes:v2->Data Src:p2 Dest:p1];
	[DRMath CrossProductRes:result U:v1->Data V:v2->Data];
	
	[v1 release];
	[v2 release];
}
// -----------------
// Get the plane equation
+ (void) GetPlaneEquation:(float*) planeEq Point1:(float*)p1 Point2:(float*)p2 Point3:(float*)p3
{
	// The the two vectors to do a cross product
	DRVector* v1 = [[DRVector alloc] init];
	DRVector* v2 = [[DRVector alloc] init];
	
	[DRMath SubtractVectorsRes:v1->Data Src:p3 Dest:p1];
	[DRMath SubtractVectorsRes:v2->Data Src:p2 Dest:p1];
	[DRMath CrossProductRes:planeEq U:v1->Data V:v2->Data];
	[DRMath NormalizeVector:planeEq];
	// Get D
	planeEq[3] = -(planeEq[0] * p3[0] + planeEq[1] * p3[1] + planeEq[2] * p3[2]);
	
	[v1 release];
	[v2 release];
}
// -----------------
// Get the distance to plane
+ (float) GetDistanceToPlane:(float*) point PlaneEq:(float*)plane
{
	return point[0]*plane[0] + point[1]*plane[1] + point[2]*plane[2] + plane[3];
}

@end
