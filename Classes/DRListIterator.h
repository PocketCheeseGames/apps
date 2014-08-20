//
//  DRListIterator.h
//  DREngine
//
//  Created by yan zhang on 10/7/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRList.h"

@interface DRListIterator : NSObject {
@private
	DRListNode* CurrentNode;
	DRList* CurrentList;
}

- (DRListIterator*) init:(DRList*) List;
- (id) Next;

@end
