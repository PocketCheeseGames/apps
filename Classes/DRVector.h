//
//  Vector4D.h
//  Draco Engine
//
//  Created by yan zhang on 9/15/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//
//  A 4D vector

#ifndef _DRVECTOR_H_
#define _DRVECTOR_H_

#import <Foundation/Foundation.h>

#define VECTOR_DIMENSION 4

@interface DRVector : NSObject {
@public
	float* Data;
@protected
	bool DataAllocated;
}

- (DRVector*) init;
- (DRVector*) initWithAllocation;
- (DRVector*) initWithValuesX:(float)x Y:(float)y Z:(float)z A:(float)a;
- (void) LoadVectorX:(float)x Y:(float)y Z:(float)z A:(float)a;

- (void) dealloc;

@end

#endif
