//
//  DRMatrix.h
//  Draco Engine
//
//  Created by yan zhang on 9/15/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//
// The matrix is column major.  It is a 4X4 matrix

#ifndef _DRMATRIX_H_
#define _DRMATRIX_H_

#import <Foundation/Foundation.h>

#define MATRIX_DIMENSION 16

@interface DRMatrix : NSObject {
@public
	float* Data;
@protected
	bool DataAllocated;
}

-(DRMatrix*) init;
-(DRMatrix*) initWithAllocation;
-(void) dealloc;

@end

#endif
