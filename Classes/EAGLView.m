//
//  EAGLView.m
//  Draco Engine
//
//  Created by yan zhang on 5/18/09.
//  Copyright Silver Ram Studio 2009. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "EAGLView.h"

#define USE_DEPTH_BUFFER 1
#define FRAMERATE 60.0

// A class extension to declare private methods
@interface EAGLView ()

@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) NSTimer *animationTimer;

- (BOOL) createFramebuffer;
- (void) destroyFramebuffer;

@end


@implementation EAGLView

@synthesize context;
@synthesize animationTimer;
@synthesize animationInterval;

// You must implement this method
+ (Class)layerClass {
    return [CAEAGLLayer class];
}


//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder {
	
    if ((self = [super initWithCoder:coder])) {
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = YES;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
        
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }
        
        animationInterval = 1.0 / FRAMERATE;
    }
    return self;
}


- (void)layoutSubviews {	
    [EAGLContext setCurrentContext:context];
    [self destroyFramebuffer];
    [self createFramebuffer];
	[self initView];
    [self drawView];
}


- (BOOL)createFramebuffer {
    
    glGenFramebuffersOES(1, &viewFramebuffer);
    glGenRenderbuffersOES(1, &viewRenderbuffer);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    if (USE_DEPTH_BUFFER) {
        glGenRenderbuffersOES(1, &depthRenderbuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    }
    
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
	
	[self setMultipleTouchEnabled:YES];
	
    return YES;
}


- (void)destroyFramebuffer {
    
    glDeleteFramebuffersOES(1, &viewFramebuffer);
    viewFramebuffer = 0;
    glDeleteRenderbuffersOES(1, &viewRenderbuffer);
    viewRenderbuffer = 0;
    
    if(depthRenderbuffer) {
        glDeleteRenderbuffersOES(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
}


- (void)startAnimation {
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0f/FRAMERATE) target:self selector:@selector(drawView) userInfo:nil repeats:YES];
}


- (void)stopAnimation {
    self.animationTimer = nil;
}


- (void)setAnimationTimer:(NSTimer *)newTimer {
    [animationTimer invalidate];
    animationTimer = newTimer;
}


- (void)setAnimationInterval:(NSTimeInterval)interval {
    
    animationInterval = interval;
    if (animationTimer) {
        [self stopAnimation];
        [self startAnimation];
    }
}


-(int) findTouchState:(UITouch*) t
{
	if ([t phase] == UITouchPhaseBegan)
	{
		return TOUCHSTATE_BEGIN;
	}
	else if ([t phase] == UITouchPhaseEnded)
	{
		return TOUCHSTATE_END;
	}
	else if ([t phase] == UITouchPhaseStationary)
	{
		return TOUCHSTATE_STATIONARY;
	}
	else if ([t phase] == UITouchPhaseMoved)
	{
		return TOUCHSTATE_MOVE;
	}
	return TOUCHSTATE_INACTIVE;
}


// Handling the touch events
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[[DRInputManager GetInstance] Reset];
	
	for (UITouch *t in [event allTouches])
	{
		if ([t phase] != UITouchPhaseEnded &&
			[t phase] != UITouchPhaseCancelled)
		{
			CGPoint pt;
			pt = [t locationInView:self];
			float fX = (pt.x - 160.0f);
			float fY = -1.0f * (pt.y - 240.0f);
			int nTouchState = [self findTouchState:t];
			int nNumberOfTaps = [t tapCount];
			[[DRInputManager GetInstance] AddLocationX:fX Y:fY ID:t NumberOfTaps:nNumberOfTaps TouchState:nTouchState];
		}
	}
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	[[DRInputManager GetInstance] Reset];
	
	for (UITouch *t in [event allTouches])
	{
		if ([t phase] != UITouchPhaseEnded &&
			[t phase] != UITouchPhaseCancelled)
		{
			CGPoint pt;
			pt = [t locationInView:self];
			float fX = (pt.x - 160.0f);
			float fY = -1.0f * (pt.y - 240.0f);
			int nTouchState = [self findTouchState:t];
			int nNumberOfTaps = [t tapCount];
			[[DRInputManager GetInstance] AddLocationX:fX Y:fY ID:t NumberOfTaps:nNumberOfTaps TouchState:nTouchState];
		}
	}
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[[DRInputManager GetInstance] Reset];
	
	for (UITouch *t in [event allTouches])
	{
		if ([t phase] != UITouchPhaseEnded &&
			[t phase] != UITouchPhaseCancelled)
		{
			CGPoint pt;
			pt = [t locationInView:self];
			float fX = (pt.x - 160.0f);
			float fY = -1.0f * (pt.y - 240.0f);
			int nTouchState = [self findTouchState:t];
			int nNumberOfTaps = [t tapCount];
			[[DRInputManager GetInstance] AddLocationX:fX Y:fY ID:t NumberOfTaps:nNumberOfTaps TouchState:nTouchState];
		}
	}
}


- (void)dealloc {
    
    [self stopAnimation];
    
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }
	
	[DRApplication DeleteInstance];
    
    [context release]; 
    [super dealloc];
}



- (void)initView{
	// Initialize the accelerometer
	UIAccelerometer *ac = [UIAccelerometer sharedAccelerometer];
	[ac setDelegate:self];
	ac.updateInterval = 0.01;
	
	[DRApplication CreateInstance];
	[DRApplication GetInstance]._view = self;
	
	// This needs to happen at the very end of the init view function
	DRRenderManager* pInstance = [DRRenderManager GetInstance];
	if (pInstance != nil)
	{
		[pInstance InitView2DWithViewFrameBuffer:viewFramebuffer andBackingWidth:backingWidth andBackingHeight:backingHeight perspectiveView:YES];
	}
}



- (void)drawView {
	
	[[DRApplication GetInstance] Update];
	
    [EAGLContext setCurrentContext:context];
	
	[[DRApplication GetInstance] Render];
    
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

// Accelerometer protocol
- (void) accelerometer:(UIAccelerometer *)accelerometer
		 didAccelerate:(UIAcceleration *)acceleration
{
	[DRInputManager GetInstance].AccX = (float)acceleration.x;
	[DRInputManager GetInstance].AccY = (float)acceleration.y;
	[DRInputManager GetInstance].AccZ = (float)acceleration.z;
}

@end
