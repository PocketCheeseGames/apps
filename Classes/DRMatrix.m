//
//  DRMatrix.m
//  Draco Engine
//
//  Created by yan zhang on 9/15/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRMatrix.h"


@implementation DRMatrix

-(DRMatrix*) init
{
	Data = 0;
	DataAllocated = NO;
	return self;
}
-(DRMatrix*) initWithAllocation
{
	Data = (float*)malloc(sizeof(float)*MATRIX_DIMENSION);
	DataAllocated = YES;
	return self;
}
-(void) dealloc
{
	if (DataAllocated)
	{
		free(Data);
	}
	
	[super dealloc];
}

@end
