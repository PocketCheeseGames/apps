//
//  DRListNode.m
//  DREngine
//
//  Created by yan zhang on 9/21/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRListNode.h"


@implementation DRListNode

@synthesize PrevNode;
@synthesize NextNode;
@synthesize Value;

- (DRListNode*) init
{
	PrevNode = nil;
	NextNode = nil;
	Value = nil;
	return self;
}

@end
