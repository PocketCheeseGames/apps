//
//  DREngineAppDelegate.h
//  Draco Engine
//
//  Created by yan zhang on 9/13/09.
//  Copyright Silver Ram Studio 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface DREngineAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EAGLView *glView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EAGLView *glView;

@end

