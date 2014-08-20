//
//  GOAhCool.h
//  DREngine
//
//  Created by yan zhang on 11/2/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjAhCool.h"
#import "StoryBoardAhCoolWalk.h"

@interface GOAhCool : ObjAhCool {
@protected
	StoryBoardAhCoolWalk* WalkAnimation;
}

- (void) Initialize;
- (void) Update;

@end
