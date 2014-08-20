//
//  DRAL.m
//  Draco Engine
//
//  Created by yan zhang on 7/4/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRAL.h"
#import "MyOpenALSupport.h"

static DRAL* gpALInstance = nil; // singleton instance

@implementation DRAL

@synthesize NumberOfFiles;

// ----------------------------
+ (DRAL*) CreateInstance
{
	if (gpALInstance != nil)
	{
		[gpALInstance release];
		gpALInstance = nil;
	}
	gpALInstance = [[DRAL alloc] init];
	return gpALInstance;
}
// ----------------------------
+ (DRAL*) GetInstance
{
	if (gpALInstance != nil)
	{
		return gpALInstance;
	}
	gpALInstance = [[DRAL alloc] init];
	return gpALInstance;
}
// ----------------------------
+ (void) DeleteInstance
{
	if (gpALInstance != nil)
	{
		[gpALInstance Destroy];
		[gpALInstance release];
		gpALInstance = nil;
	}
}

// ----------------------------
- (void) Initialize
{
	if (! INCLUDE_SOUND)
	{
		return;
	}
	
	// Get the device
	_pDevice = alcOpenDevice(NULL);
	
	// Create the context
	if (_pDevice)
	{
		_pContext = alcCreateContext(_pDevice, NULL);
		if (_pContext)
		{
			alcMakeContextCurrent(_pContext);
			
			// initialize the buffers
			alGenBuffers(NUM_BUFFERS, _pBuffers);
			// initialize the sources
			alGenSources(NUM_SOURCES, _pSources);
			
			// Load the data
			NumberOfFiles = 0;
		}
	}
}

// ----------------------------
- (DRAL*) init
{
	return self;
}

- (void) PlaySoundIndex:(int) nIndex
{
	if (! INCLUDE_SOUND)
	{
		return;
	}
	[self StopSoundIndex:nIndex];
	NSUInteger sourceID = _pSources[nIndex];
	if (nIndex == 3)
	{
		alSourcef(sourceID, AL_GAIN, 0.3f);
	}
	alSourcePlay(sourceID);
}
- (void) StopSoundIndex:(int) nIndex
{
	if (! INCLUDE_SOUND)
	{
		return;
	}
	NSUInteger sourceID = _pSources[nIndex];
	alSourceStop(sourceID);
}

// ----------------------------
- (void) Destroy
{
	if (! INCLUDE_SOUND)
	{
		return;
	}
	
	ALuint	returnedBufferNames[NUM_BUFFERS];
	ALuint	returnedSourceNames[NUM_SOURCES];
	
	// Delete the Sources
    alDeleteSources(NUM_SOURCES, returnedSourceNames);
	// Delete the Buffers
    alDeleteBuffers(NUM_BUFFERS, returnedBufferNames);
	
	alcDestroyContext(_pContext);
	alcCloseDevice(_pDevice);
	
	[newPlayer release];
}

// -----------
- (bool) loadSound:(NSString *)_file Ext:(NSString *) _ext Loop:(bool)loops
{	
	ALvoid * outData;
	ALenum  error = AL_NO_ERROR;
	ALenum  format;
	ALsizei size;
	ALsizei freq;
	
	NSBundle * bundle = [NSBundle mainBundle];
	
	// get some audio data from a wave file
	CFURLRef fileURL = (CFURLRef)[[NSURL fileURLWithPath:[bundle pathForResource:_file ofType:_ext]] retain];
	
	if (!fileURL)
	{
		return false;
	}
	
	outData = MyGetOpenALAudioData(fileURL, &size, &format, &freq);
	
	CFRelease(fileURL);
	
	if((error = alGetError()) != AL_NO_ERROR) {
		printf("error loading sound: %x\n", error);
		exit(1);
	}
	
	NSUInteger bufferID;
	// grab a buffer ID from openAL
	alGenBuffers(1, &bufferID);
	
	// load the awaiting data blob into the openAL buffer.
	alBufferData(bufferID,format,outData,size,freq); 
	
	// save the buffer so we can release it later
	_pBuffers[NumberOfFiles] = bufferID;	
	//  [bufferStorageArray addObject:[NSNumber numberWithUnsignedInteger:bufferID]];
	
	NSUInteger sourceID;
	// grab a source ID from openAL
	alGenSources(1, &sourceID); 
	
	// attach the buffer to the source
	alSourcei(sourceID, AL_BUFFER, bufferID);
	// set some basic source prefs
	alSourcef(sourceID, AL_PITCH, 1.0f);
	alSourcef(sourceID, AL_GAIN, 1.0f);
	if (loops) alSourcei(sourceID, AL_LOOPING, AL_TRUE);
	
	// store this for future use
	// [soundDictionary setObject:[NSNumber numberWithUnsignedInt:sourceID] forKey:_soundKey];	
	_pSources[NumberOfFiles] = sourceID;	
	NumberOfFiles++;
	
	// clean up the buffer
	if (outData)
	{
		free(outData);
		outData = NULL;
	}
	
	return true;
	
}
@end

