//
//  DRRenderManager.h
//  Draco Engine
//
//  Created by yan zhang on 5/24/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#ifndef _DRRENDERMANAGER_H_
#define _DRRENDERMANAGER_H_

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <Foundation/Foundation.h>
#import "DRFrame.h"
#import "DRStoryBoard.h"

@interface DRRenderManager : NSObject 
{
@private
	// List of story boards
	DRList* StoryBoards;
	DRList* ActiveStoryBoards;
	
	// Lists of meshes that need to be rendered
	DRList* ActiveFrameList;
	DRList* ActiveAlphaFrameList;
	
	// State management
	int CurBoundTexture;
	
	// Camera
	DRFrame* CurCamera;
	DRFrame* DefaultCamera;
}

@property (nonatomic, assign) int CurBoundTexture;
@property (nonatomic, assign) DRFrame* CurCamera;

+ (DRRenderManager*) CreateInstance;
+ (DRRenderManager*) GetInstance;
+ (void) DeleteInstance;

- (DRRenderManager*) init;
- (void) Destroy;

- (void) InitView2DWithViewFrameBuffer:(GLuint) viewFramebuffer andBackingWidth:(GLuint) backingWidth andBackingHeight:(GLuint) backingHeight perspectiveView:(bool) perspectiveView;
- (void) BeginScene;
- (void) Render3DScene;
- (void) EndScene;
- (void) Update;

- (void) SetOrthoView;
- (void) SetPerspectiveView:(double) fovy aspect:(double) aspect zNear:(double)zNear zFar:(double) zFar;

- (void) GoTo2DMode;
- (void) GoTo3DMode;

- (void) AddToRenderQueue:(DRFrame*) frame;
- (void) RenderFrame:(DRFrame*) frame;

- (void) AddStoryBoard:(DRStoryBoard*) storyBoard;
- (void) AddActiveStoryBoard:(DRStoryBoard*) storyBoard;
- (void) RemoveActiveStorBoard:(DRStoryBoard*) storyBoard;

@end

#endif
