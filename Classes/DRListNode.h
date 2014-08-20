//
//  DRListNode.h
//  DREngine
//
//  Created by yan zhang on 9/21/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DRListNode : NSObject {
@public
	DRListNode* PrevNode;
	DRListNode* NextNode;
	id Value;
}

@property (nonatomic, assign) DRListNode* PrevNode;
@property (nonatomic, assign) DRListNode* NextNode;
@property (nonatomic, assign) id Value;

- (DRListNode*) init;

@end
