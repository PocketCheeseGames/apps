//
//  DRRenderEffect.h
//  DREngine
//
//  Created by yan zhang on 11/3/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRList.h"

@interface DRRenderEffect : NSObject {
@protected
	DRList* Textures;
}

@property(nonatomic, assign) DRList* Textures;

- (DRRenderEffect*) init;
- (void) Bind;

@end
