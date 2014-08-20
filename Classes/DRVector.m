//
//  Vector4D.m
//  Draco Engine
//
//  Created by yan zhang on 9/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DRVector.h"


@implementation DRVector

- (DRVector*) init
{
	DataAllocated = NO;
	Data = 0;
	return self;
}

- (DRVector*) initWithAllocation
{
	DataAllocated = YES;
	Data = (float*)malloc(sizeof(float)*VECTOR_DIMENSION);
	return self;
}

- (DRVector*) initWithValuesX:(float)x Y:(float)y Z:(float)z A:(float)a
{
	DataAllocated = YES;
	
	Data = (float*)malloc(sizeof(float)*VECTOR_DIMENSION);
	Data[0] = x;
	Data[1] = y;
	Data[2] = z;
	Data[3] = a;
	
	return self;
}

- (void) LoadVectorX:(float)x Y:(float)y Z:(float)z A:(float)a
{
	Data[0] = x;
	Data[1] = y;
	Data[2] = z;
	Data[3] = a;
}

- (void) dealloc
{
	if (DataAllocated)
	{
		free(Data);
	}
	[super dealloc];
}

@end
