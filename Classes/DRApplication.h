//
//  EDApplication.h
//  Draco Engine
//
//  Created by yan zhang on 5/31/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#ifndef _DRAPPLICATION_H_
#define _DRAPPLICATION_H_

#import <Foundation/Foundation.h>
#import "DREngine.h"

@class EAGLView;
@class GameManager;
@class MenuManager;
@class Utils;
@class GameSettings;

#define MENU_APP_STATE			1
#define GET_SETTINGS_STATE		2
#define GAME_APP_STATE			3
#define GAME_INIT_STATE			4
#define GAME_OVER_STATE			5

@interface DRApplication : NSObject {
@private
	
	EAGLView* _view;
	GameManager* _GameMgr;
	MenuManager* _MenuMgr;
	Utils		*_utils;
	DRFrame* _testFrame;
	GameSettings	*_Settings;
	int _nCurState;
	int _nTimerTick;

}
@property (nonatomic, assign) EAGLView *_view;

+ (DRApplication*) CreateInstance;
+ (DRApplication*) GetInstance;
+ (void) DeleteInstance;

- (DRApplication*) Init;
- (BOOL) Update;
- (BOOL) Render;
- (BOOL) Destroy;

@end

#endif