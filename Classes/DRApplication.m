//
//  EDApplication.m
//  Draco Engine
//
//  Created by yan zhang on 5/31/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRApplication.h"
#import "GameManager.h"
#import "MenuManager.h"
#import "UtilFuncs.h"
#import "GameSettings.h"


const GLfloat light0Ambient[] = {0.0, 0.0, 0.0, 1.0};
const GLfloat light0Diffuse[] = {1.0, 1.0, 1.0, 1.0};
const GLfloat light0Position[] = {50.0, 100.0, 100.0, 0.0};

const int DELAY_BETWEEN_STATES	= 8;

static DRApplication* gpAppInstance = nil; // singleton instance

@implementation DRApplication

@synthesize _view;

// ----------------------------
+ (DRApplication*) CreateInstance
{
	if (gpAppInstance != nil)
	{
		[gpAppInstance release];
		gpAppInstance = nil;
	}
	gpAppInstance = [DRApplication alloc];
	[gpAppInstance Init];
	
	return gpAppInstance;
}
// ----------------------------
+ (DRApplication*) GetInstance
{
	if (gpAppInstance != nil)
	{
		return gpAppInstance;
	}
	gpAppInstance = [DRApplication alloc];
	[gpAppInstance Init];
	return gpAppInstance;
}
// ----------------------------
+ (void) DeleteInstance
{
	if (gpAppInstance != nil)
	{
		[gpAppInstance Destroy];
		[gpAppInstance release];
	}
}

// ----------------------------
- (DRApplication*) Init
{
	srand(time(NULL));
	
	[DREngine CreateInstance];
	
	_testFrame = [[DRFrame alloc] init];
	
	_GameMgr = [[GameManager alloc] InitGame];
	_MenuMgr = [[MenuManager alloc] InitMenu];
	_utils = [Utils CreateInstance];
	_Settings = [GameSettings CreateInstance];
	
    glLightfv(GL_LIGHT0, GL_AMBIENT, light0Ambient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, light0Diffuse);
    glLightfv(GL_LIGHT0, GL_POSITION, light0Position);
	
	_nCurState = MENU_APP_STATE;
	
	[_MenuMgr ClearAllButtons];
	[_MenuMgr SetUpMainMenu];
	
	_nTimerTick = 0;
	
	return self;
}


// ----------------------------
- (BOOL) Update
{	
	[[DRTimerManager GetInstance] Update];
	
	[[DRRenderManager GetInstance] Update];
	[[DRInputManager GetInstance] Update];
	
	_testFrame.LocRotation->Data[2] = 0.0f;
	
	switch (_nCurState)
	{
		case GAME_INIT_STATE:
		{
			[_MenuMgr ClearAllButtons];
			[_GameMgr SetupGame];
			_nCurState = GAME_APP_STATE;
		}
			break;
		
		case GAME_APP_STATE:
		{	
			[_GameMgr Update];
			
			if( _GameMgr.bGameOver )
			{
				_nCurState = GAME_OVER_STATE;
				_nTimerTick = DELAY_BETWEEN_STATES;
			}
		}	
			break;
		case GET_SETTINGS_STATE:
		{
		}
			break;
		
		case GAME_OVER_STATE:
		{
			if( _nTimerTick-- <= 0 )
			{
				[_MenuMgr SetupGameOverOptions];
				if( _GameMgr.bWinner )
				{
					[_MenuMgr SetupWinner];
				}
				else
				{
					[_MenuMgr SetupLoser];
				}
			
				_nCurState = MENU_APP_STATE;
				_nTimerTick = DELAY_BETWEEN_STATES;
			}
		}
			break;
		
		case MENU_APP_STATE:
		{
			if( _nTimerTick-- <= 0 )
			{
				[_MenuMgr Update];
				
				// check to see if anythings changed...
				if( _MenuMgr.nButtonClicked == TIME_GAME_BTN )
				{
					_GameMgr.m_nGameType = TIME_GAME_MODE;
					//_GameMgr.m_nNumBalls = 100;
					_GameMgr.texHUD = [[DRResourceManager GetInstance] LoadTexture:@"Time_HUD.png"];
					_nCurState = GAME_INIT_STATE;
				}
				else if( _MenuMgr.nButtonClicked == PUZZLE_GAME_BTN )
				{
					_GameMgr.m_nGameType = PUZZLE_GAME_MODE;
					//_GameMgr.m_nNumBalls = 40;
					_GameMgr.texHUD = [[DRResourceManager GetInstance] LoadTexture:@"Puzzle_HUD.png"];
					_nCurState = GAME_INIT_STATE;
				}
				else if( _MenuMgr.nButtonClicked == SPLIT_BALL_BTN )
				{
					_GameMgr.m_nGameType = SPLIT_BALL_GAME_MODE;
					//_GameMgr.m_nNumBalls = 30;
					_GameMgr.texHUD = [[DRResourceManager GetInstance] LoadTexture:@"Puzzle_HUD.png"];
					_nCurState = GAME_INIT_STATE;
				}
				else if( _MenuMgr.nButtonClicked == ARCADE_GAME_BTN )
				{
					_GameMgr.m_nGameType = ARCADE_GAME_MODE;
					//_GameMgr.m_nNumBalls = 70;
					_GameMgr.texHUD = [[DRResourceManager GetInstance] LoadTexture:@"Arcade_HUD.png"];
					_nCurState = GAME_INIT_STATE;
				}
				else if( _MenuMgr.nButtonClicked == PLAY_AGAIN_BTN )
				{
					// reset the current game and play again
					[_GameMgr ResetCurrentGame];
					[_MenuMgr ClearAllButtons];
					_nCurState = GAME_APP_STATE;
				}
				else if( _MenuMgr.nButtonClicked == MAIN_MENU_BTN )
				{
					// just shutdown the game and move to main menu
					//[_GameMgr Shutdown];
					[_MenuMgr ClearAllButtons];
					[_MenuMgr SetUpMainMenu];
					_nTimerTick = DELAY_BETWEEN_STATES;
					_nCurState = MENU_APP_STATE;
				}
			}
			
			//// change our state to initialize the game
			//if( _MenuMgr.nButtonClicked != NO_BUTTON )
			//	_nCurState = GAME_INIT_STATE;
		}
			break;
		default:
			break;
	}
	
	return YES;
}

// ----------------------------
- (BOOL) Render
{	
	[[DRRenderManager GetInstance] BeginScene];
	
	[[DRRenderManager GetInstance] GoTo3DMode];
	
	
	glPushMatrix();	
	
	// Render 3D stuff here
	
	[[DRRenderManager GetInstance] Render3DScene];
	
	glPopMatrix();
	
	[[DRRenderManager GetInstance] GoTo2DMode];
	
	glPushMatrix();	
	
	if( _nCurState == GAME_APP_STATE )
		[_GameMgr Render];
	if( _nCurState == MENU_APP_STATE )
		[_MenuMgr Render];
	
	// Render 2D stuff here
	//glRotatef(_testFrame.LocRotation->Data[2], 0.0f, 0.0f, 1.0f);
	
	// Do rendering here
	//[_testTexture BlitTranslateX:BallXPos TranslateY:BallYPos Rotate:_testFrame.LocRotation->Data[2] ScaleX:100 ScaleY:-100 Red:1.0f Green:0.0f Blue:1.0f Alpha:1.0f];
	
	//Ball *curBall;
	//for( int i = 0; i < MAX_BALLS; ++i )
	//{
	//	curBall = [ballArray objectAtIndex:i];
	//	if( curBall.drawBall )
	//		[curBall.texture BlitTranslateX:curBall.xPos TranslateY:curBall.yPos Rotate:_testFrame.LocRotation->Data[2] ScaleX:curBall.scaleVal ScaleY:(curBall.scaleVal*-1) Red:curBall.Rcolor Green:curBall.Gcolor Blue:curBall.Bcolor Alpha:1.0f];
	//}
	
	glPopMatrix();
	
	[[DRRenderManager GetInstance] EndScene];
	
	return YES;
}
// ----------------------------
- (BOOL) Destroy
{
	[_GameMgr Shutdown];
	[_GameMgr release];
	[_MenuMgr release];
	[_utils DeleteInstance];
	[_Settings DeleteInstance];
	//[_goAhCool release];
	//[_objHorns release];
	
	[_testFrame release];
	
	[DREngine DeleteInstance];
	
	return YES;
}

@end
