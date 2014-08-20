//
//  DREngineAppDelegate.m
//  Draco Engine
//
//  Created by yan zhang on 9/13/09.
//  Copyright Silver Ram Studio 2009. All rights reserved.
//

#import "DREngineAppDelegate.h"
#import "EAGLView.h"

@implementation DREngineAppDelegate

@synthesize window;
@synthesize glView;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	glView.animationInterval = 1.0 / 60.0;
	[glView startAnimation];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	glView.animationInterval = 1.0 / 5.0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	glView.animationInterval = 1.0 / 60.0;
}


- (void)dealloc {
	[window release];
	[glView release];
	[super dealloc];
}

@end
