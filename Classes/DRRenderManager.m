//
//  DRRenderManager.m
//  Draco Engine
//
//  Created by yan zhang on 5/24/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRRenderManager.h"
#import "DRDataHolder.h"
#import "DRListIterator.h"

static DRRenderManager* gpRMInstance = nil; // singleton instance

@implementation DRRenderManager

@synthesize CurBoundTexture;
@synthesize CurCamera;

// ----------------------------
+ (DRRenderManager*) CreateInstance
{
	if (gpRMInstance != nil)
	{
		[gpRMInstance release];
		gpRMInstance = nil;
	}
	gpRMInstance = [[DRRenderManager alloc] init];
	return gpRMInstance;
}
// ----------------------------
+ (DRRenderManager*) GetInstance
{
	if (gpRMInstance != nil)
	{
		return gpRMInstance;
	}
	gpRMInstance = [[DRRenderManager alloc] init];
	return gpRMInstance;
}
// ----------------------------
+ (void) DeleteInstance
{
	if (gpRMInstance != nil)
	{
		[gpRMInstance Destroy];
		[gpRMInstance release];
	}
}

// ----------------------------
- (DRRenderManager*) init
{
	CurBoundTexture = -1;
	StoryBoards = [[DRList alloc] init];
	ActiveStoryBoards = [[DRList alloc] init];
	ActiveFrameList = [[DRList alloc] init];
	ActiveAlphaFrameList = [[DRList alloc] init];
	DefaultCamera = [[DRFrame alloc] init];
	CurCamera = DefaultCamera;
	[CurCamera RotateLocZ:90.0f];
	return self;
}

// ----------------------------
- (void) Destroy
{
	[DefaultCamera release];
	[StoryBoards release];
	[ActiveStoryBoards release];
	[ActiveFrameList release];
	[ActiveAlphaFrameList release];
}

// ----------------------------
- (void) InitView2DWithViewFrameBuffer:(GLuint) viewFramebuffer andBackingWidth:(GLuint) backingWidth andBackingHeight:(GLuint) backingHeight perspectiveView:(bool) perspectiveView;
{
	// Initialize rendering environment
    glClearColor(0.0f, 0.0f, 0.3f, 1.0f);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glViewport(0, 0, backingWidth, backingHeight);	
	
	// Sets up matrices and transforms for OpenGL ES
	glViewport(0, 0, backingWidth, backingHeight);
	
	if (! perspectiveView)
	{
		[self SetOrthoView];
	}
	else
	{
		[self SetPerspectiveView:45.0f aspect:480.0f/320.0f zNear:0.01f zFar:1000.0f];
	}
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	// Set the texture parameters to use a minifying filter and a linear filer (weighted average)
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	
	// Enable use of the texture
	glEnable(GL_TEXTURE_2D);
	// Set a blending function to use
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	// Enable blending
	glEnable(GL_BLEND);

	glEnable(GL_COLOR_MATERIAL);
	
	glMatrixMode(GL_MODELVIEW);
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);	
	
	glDepthFunc( GL_LESS );
	glEnable( GL_CULL_FACE );
	glShadeModel( GL_SMOOTH );
	
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	
	// glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
}

// ----------------------------
- (void) BeginScene
{	
    glClear(GL_COLOR_BUFFER_BIT);
	glClear(GL_DEPTH_BUFFER_BIT);
	
	glPushMatrix();
}

// ----------------------------
- (void) EndScene
{
	glPopMatrix();
	
	[ActiveFrameList Clear];
	[ActiveAlphaFrameList Clear];
}

// ----------------------------
- (void) Render3DScene
{
	glPushMatrix();
	
	// Apply camera transformation
	if (CurCamera != nil)
	{
		glRotatef(-CurCamera.LocRotation->Data[2], 0.0f, 0.0f, 1.0f);
		glRotatef(-CurCamera.LocRotation->Data[1], 0.0f, 1.0f, 0.0f);
		glRotatef(-CurCamera.LocRotation->Data[0], 1.0f, 0.0f, 0.0f);
		glTranslatef(-CurCamera.LocOrigin->Data[0], -CurCamera.LocOrigin->Data[1], -CurCamera.LocOrigin->Data[2]);
	}
	
	DRListIterator* it = [[DRListIterator alloc] init:ActiveFrameList];
	DRFrame* curFrame = [it Next];
	while (curFrame != nil)
	{
		[self RenderFrame:curFrame];
		curFrame = [it Next];
	}
	[it release];
	
	// make it so that geometry doesn't write to the depth buffer
	it = [[DRListIterator alloc] init:ActiveAlphaFrameList];
	curFrame = [it Next];
	while (curFrame != nil)
	{
		[self RenderFrame:curFrame];
		curFrame = [it Next];
	}
	[it release];
	
	glPopMatrix();
}

// ----------------------------
- (void) Update
{
	// Update all the active story boards
	DRListIterator* it = [[DRListIterator alloc] init:ActiveStoryBoards];
	DRStoryBoard* curSB = [it Next];
	while (curSB != nil)
	{
		[curSB Update];
		curSB = [it Next];
	}
	[it release];
}

// ----------------------------
- (void) SetOrthoView
{          
		glMatrixMode(GL_PROJECTION);		   
		glLoadIdentity();					   
		glOrthof( 0, 320, 480, 0, 1, 0 );
		glMatrixMode(GL_MODELVIEW);				
		glLoadIdentity();
		glDisable(GL_DEPTH_TEST);
}

// ----------------------------
- (void) SetPerspectiveView:(double) fovy aspect:(double) aspect zNear:(double)zNear zFar:(double) zFar
{
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	double xmin, xmax, ymin, ymax;
	
	ymax = zNear * tan(fovy * M_PI / 360.0);
	ymin = -ymax;
	xmin = ymin * aspect;
	xmax = ymax * aspect;
	
	glFrustumf(xmin, xmax, ymin, ymax, zNear, zFar);
	glEnable( GL_CULL_FACE );
	glEnable( GL_DEPTH_TEST );
	
	glMatrixMode(GL_MODELVIEW);				
	glLoadIdentity();
}
// ----------------------------
- (void) GoTo2DMode
{
	glDisableClientState(GL_NORMAL_ARRAY);
	glDisable( GL_CULL_FACE );
	[self SetOrthoView];
}
// ----------------------------
- (void) GoTo3DMode
{
	glEnableClientState(GL_NORMAL_ARRAY);
	[self SetPerspectiveView:85.0f aspect:320.0f/480.0f zNear:0.01f zFar:1000.0f];
}
// ----------------------------
- (void) AddToRenderQueue:(DRFrame*) frame
{
	if (frame.Mesh != nil)
	{
		if (! frame.Mesh.IsAlpha)
		{
			[ActiveFrameList AddValue:frame];
		}
		else
		{
			// TODO: insertion sort furtherest to closest
			[ActiveAlphaFrameList AddValue:frame];
		}
	}
	
	if (frame.Child != nil)
	{
		[self AddToRenderQueue:frame.Child];
	}
	
	DRFrame* sibling = frame.Sibling;
	while(sibling != nil)
	{
		[self AddToRenderQueue:sibling];
		
		sibling = sibling.Sibling;
	}
}
// ----------------------------
- (void) RenderFrame:(DRFrame*) frame
{
	DRMesh* mesh = frame.Mesh;
	if (mesh != nil)
	{
		glPushMatrix();
		
		[frame.Mesh.Effect Bind];
		
		glMultMatrixf(frame.WorldMatrix->Data);
		
		glVertexPointer(3, GL_FLOAT, 0, mesh->VertexData);
		glNormalPointer(GL_FLOAT, 0, mesh->NormalData);
		DRDataHolder* dh = (DRDataHolder*)mesh->UVSets->FirstNode->Value;
		glTexCoordPointer(2, GL_FLOAT, 0, dh->Data);
		
		glDrawArrays(GL_TRIANGLES, 0, mesh.NumberOfVertices);
		
		glPopMatrix();
	}
}
// ----------------------------
- (void) AddStoryBoard:(DRStoryBoard*) storyBoard
{
	[StoryBoards AddValue:storyBoard];
}
// ----------------------------
- (void) AddActiveStoryBoard:(DRStoryBoard*) storyBoard
{
	[ActiveStoryBoards AddValue:storyBoard];
}
// ----------------------------
- (void) RemoveActiveStorBoard:(DRStoryBoard*) storyBoard
{
	[ActiveStoryBoards RemoveValue:storyBoard];
}

@end
