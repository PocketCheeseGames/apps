//
//  DRList.m
//  DREngine
//
//  Created by yan zhang on 9/21/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRList.h"

@implementation DRList

@synthesize FirstNode;
@synthesize LastNode;
@synthesize NumberOfNodes;

- (DRList*) init
{
	FirstNode = nil;
	LastNode = nil;
	NumberOfNodes = 0;
	
	return self;
}

- (void) AddValue:(id) value
{
	DRListNode* newNode = [[DRListNode alloc] init];
	newNode.Value = value;
	[self AddNode:newNode];
}
- (void) AddNode:(DRListNode*) node
{
	if (FirstNode == nil)
	{
		FirstNode = LastNode = node;
	}
	else
	{
		LastNode.NextNode = node;
		node.PrevNode = LastNode;
		LastNode = node;
	}
	NumberOfNodes++;
}
- (void) RemoveValue:(id) value
{
	if (value == nil)
		return;
	
	DRListNode* tempNode = FirstNode;
	while (tempNode)
	{
		if (tempNode.Value == value)
		{
			break;
		}
		tempNode = tempNode.NextNode;
	}
	if (tempNode != nil)
		[self RemoveNode:tempNode];
	
}
- (void) RemoveNode:(DRListNode*) node
{
	if (node == nil)
	{
		return;
	}
	DRListNode* pPrevNode = node.PrevNode;
	DRListNode* pNextNode = node.NextNode;
	if (pPrevNode != nil)
	{
		pPrevNode.NextNode = pNextNode;
	}
	if (pNextNode != nil)
	{
		pNextNode.PrevNode = pPrevNode;
	}
	if (node == FirstNode)
	{
		FirstNode = pPrevNode;
		if (pNextNode != nil)
		{
			FirstNode = pNextNode;
		}
	}
	if (node == LastNode)
	{
		LastNode = pNextNode;
		if (pPrevNode != nil)
		{
			LastNode = pPrevNode;
		}
	}
	node.PrevNode = nil;
	node.NextNode = nil;
	NumberOfNodes--;
}
- (void) Clear
{
	DRListNode* tempNode = FirstNode;
	DRListNode* delNode = nil;
	while (tempNode)
	{
		delNode = tempNode;
		tempNode = tempNode.NextNode;
		[delNode release];
		delNode = nil;
	}
	FirstNode = nil;
	LastNode = nil;
	NumberOfNodes = 0;
}
- (void) Clear:(bool) releaseValue
{
	DRListNode* tempNode = FirstNode;
	DRListNode* delNode = nil;
	while (tempNode)
	{
		delNode = tempNode;
		tempNode = tempNode.NextNode;
		if (releaseValue)
		{
			[delNode.Value release];
			delNode.Value = nil;
		}
		[delNode release];
		delNode = nil;
	}
	FirstNode = nil;
	LastNode = nil;
	NumberOfNodes = 0;
}
- (void) Reset
{
	DRListNode* tempNode = FirstNode;
	DRListNode* delNode = nil;
	while (tempNode)
	{
		delNode = tempNode;
		tempNode = tempNode.NextNode;
		[delNode release];
		delNode = nil;
	}
	FirstNode = nil;
	LastNode = nil;
	NumberOfNodes = 0;
}

- (void) dealloc
{
	[super dealloc];
	[self Clear];
}

@end
