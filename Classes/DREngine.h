//
//  DREngine.h
//  Draco Engine
//
//  Created by yan zhang on 5/30/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#ifndef _DRENGINE_H_
#define _DRENGINE_H_

#import <Foundation/Foundation.h>
#import "DRMath.h"
#import "DRFrame.h"
#import "DRTexture.h"
#import "DRRenderManager.h"
#import "DRInputManager.h"
#import "DRAL.h"
#import "DRTimerManager.h"
#import "DRResourceManager.h"

@interface DREngine : NSObject {

}

+ (DREngine*) CreateInstance;
+ (DREngine*) GetInstance;
+ (void) DeleteInstance;

- (DREngine*) Init;
- (void) Destroy;

@end

#endif
