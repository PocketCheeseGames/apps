//
//  DRAL.h
//  Draco Engine
//
//  Created by yan zhang on 7/4/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <AudioToolbox/AudioToolbox.h>
#include <AudioToolbox/AudioFile.h>
#include <AudioUnit/AudioUnit.h>
#include <AVFoundation/AVFoundation.h>

#import <OpenAL/al.h>
#import <OpenAL/alc.h>

#define NUM_BUFFERS 10
#define NUM_SOURCES 10

#define INCLUDE_SOUND 1

@interface DRAL : NSObject {
	@private
	ALCcontext *_pContext;
	ALCdevice *_pDevice;
	
	ALuint _pBuffers[NUM_BUFFERS];
	ALuint _pSources[NUM_SOURCES];
	
	int NumberOfFiles;
	
	AVAudioPlayer *newPlayer;
}

@property (nonatomic, assign) int NumberOfFiles;

+ (DRAL*) CreateInstance;
+ (DRAL*) GetInstance;
+ (void) DeleteInstance;

- (void) Initialize;
- (void) Destroy;

- (bool) loadSound:(NSString *)_file Ext:(NSString *) _ext Loop:(bool)loops;
- (void) PlaySoundIndex:(int) nIndex;
- (void) StopSoundIndex:(int) nIndex;

@end
