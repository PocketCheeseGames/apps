//
//  DRObject.h
//  DREngine
//
//  Created by yan zhang on 10/8/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRModel.h"
#import "DRFrame.h"

@interface DRObject : NSObject {
@protected
	DRFrame*	RootFrame;
	DRModel*	Model;
}

- (void) Initialize;
- (void) Update;
- (void) Render;
- (bool) TestCollision:(DRObject*) obj;
- (void) ReactToCollision:(DRObject*) obj;

@property (nonatomic, assign) DRFrame* RootFrame;
@property (nonatomic, assign) DRModel* Model;

@end
