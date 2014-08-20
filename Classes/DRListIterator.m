//
//  DRListIterator.m
//  DREngine
//
//  Created by yan zhang on 10/7/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRListIterator.h"


@implementation DRListIterator

- (DRListIterator*) init:(DRList*) List;
{
	CurrentList = List;
	return self;
}
- (id) Next
{
	if (CurrentNode != nil)
	{
		CurrentNode = CurrentNode.NextNode;
	}
	else
	{
		CurrentNode = CurrentList.FirstNode;
	}
	if (CurrentNode != nil)
	{
		return CurrentNode.Value;
	}
	return nil;
}

@end
