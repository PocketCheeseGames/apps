//
//  DRModel.m
//  DREngine
//
//  Created by yan zhang on 10/7/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRModel.h"
#import "DRListIterator.h"

@implementation DRModel

@synthesize Frames;

- (DRModel*) init
{
	Frames = [[DRList alloc] init];
	return self;
}

- (DRFrame*) GetFrameByName:(NSString*) frameName
{
	DRFrame* resultFrame = nil;
	DRListIterator* it = [[DRListIterator alloc] init:Frames];
	DRFrame* frame = [it Next];
	while (frame != nil)
	{
		resultFrame = [frame GetFrameByName:frameName];
		if (resultFrame != nil)
			break;
		frame = [it Next];
	}
	[it release];
	return resultFrame;
}

- (void) dealloc
{
	[super dealloc];
	[Frames release];
}

@end
