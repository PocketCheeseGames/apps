//
//  DRKeyFrame.h
//  DREngine
//
//  Created by yan zhang on 10/28/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRVector.h"

@interface DRKeyFrame : NSObject {
@protected
	float Time;
	DRVector* Translation;
	DRVector* Rotation;
}

@property (nonatomic, assign) float Time;
@property (nonatomic, assign) DRVector* Translation;
@property (nonatomic, assign) DRVector* Rotation;

- (DRKeyFrame*) initWithTranslationX:(float) tX TranslationY:(float) tY TranslationZ:(float) tZ
						   RotationX:(float) rX RotationY:(float) rY RotationZ:(float) rZ Time:(float) time;

@end
