//
//  DRList.h
//  DREngine
//
//  Created by yan zhang on 9/21/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRListNode.h"


@interface DRList : NSObject {
@public
	DRListNode* FirstNode;
	DRListNode* LastNode;
	int NumberOfNodes;
}

@property (nonatomic, assign) DRListNode* FirstNode;
@property (nonatomic, assign) DRListNode* LastNode;
@property (nonatomic) int NumberOfNodes;

- (DRList*) init;

- (void) AddValue:(id) value;
- (void) AddNode:(DRListNode*) node;
- (void) RemoveNode:(DRListNode*) node;
- (void) RemoveValue:(id) value;
- (void) Clear;
- (void) Clear:(bool) releaseValue;
- (void) Reset;

@end
