//
//  DRKeyFrame.m
//  DREngine
//
//  Created by yan zhang on 10/28/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRKeyFrame.h"


@implementation DRKeyFrame

@synthesize Time;
@synthesize Translation;
@synthesize Rotation;

- (DRKeyFrame*) initWithTranslationX:(float) tX TranslationY:(float) tY TranslationZ:(float) tZ
								RotationX:(float) rX RotationY:(float) rY RotationZ:(float) rZ Time:(float) time
{
	Time = time;
	Translation = [[DRVector alloc] initWithValuesX:tX Y:tY Z:tZ A:0.0f];
	Rotation = [[DRVector alloc] initWithValuesX:rX Y:rY Z:rZ A:0.0f];
	return self;
}

- (void) dealloc
{
	[Translation release];
	[Rotation release];
	[super dealloc];
}

@end
