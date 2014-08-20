//
//  DRModel.h
//  DREngine
//
//  Created by yan zhang on 10/7/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRList.h"
#import "DRFrame.h"

@interface DRModel : NSObject {
@public
	DRList* Frames;
}

@property (nonatomic, assign) DRList* Frames;

- (DRModel*) init;
- (DRFrame*) GetFrameByName:(NSString*) frameName;

@end
