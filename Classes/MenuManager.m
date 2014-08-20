//
//  MenuManager.m
//  DREngine
//
//  Created by Rob DelBianco on 3/21/10.
//  Copyright 2010 Pocket Cheese. All rights reserved.
//

#import "MenuManager.h"
#import "DREngine.h"
#import "GameDefines.h"


@implementation MenuManager

@synthesize nButtonClicked;
@synthesize nMenuState;
@synthesize TapXPos;
@synthesize TapYPos;

- (MenuManager*) InitMenu
{
	nButtonClicked = NO_BUTTON;
	nMenuState = MAIN_MENU_STATE;
	
	buttonArray = [[NSMutableArray alloc] init];
	
	//create our array of buttons
	for( int i = 0; i < TOTAL_BUTTONS; i++ )
	{
		Button *pNewButton = [[Button alloc] initButton:0.0f yPos:0.0f nButtonType:i];
		[buttonArray addObject:pNewButton];
		[pNewButton release];
	}
	
	//MainPage.png
	menuBackGround = [[DRResourceManager GetInstance] LoadTexture: @ MAIN_MENU_SCREEN_TEXTURE_NAME];
	
	return self;
}

- (BOOL) Update
{
	bool bXClicked = false;
	bool bYClicked = false;
	Button *pButton;
	
	[[DRInputManager GetInstance] Update];
	
	TapXPos = [[DRInputManager GetInstance] GetLocationX: 0 ];
	TapYPos = [[DRInputManager GetInstance] GetLocationY: 0 ];
		
	//if( nButtonClicked != NO_BUTTON )
	//	return FALSE;
	if( TapXPos != 0 && TapYPos != 0 )
	{
		//TapXPos += 160.0f;
		//TapYPos += 240.0f;
		
		for( int i = 0; i < TOTAL_BUTTONS; i++ )
		{
			pButton = [buttonArray objectAtIndex:i];
			if( !pButton.bDrawButton )
				continue;
			//bClicked = [DRMath RectCircleCollidsRectCenterX:pButton.xPos RectCenterY:pButton.yPos RectWidth:40 RectHeight:20 CircleCenterX:TapXPos CircleCenterY:TapYPos CircleRadius:FINGER_RADIUS];
			
			bXClicked = [pButton ButtonClickedX:TapXPos];
			bYClicked = [pButton ButtonClickedY:TapYPos];
			
			if( bXClicked && bYClicked )
			{
				nButtonClicked = pButton.nButtonType;
				break;
			}
		}
	}
	
	return TRUE;
}


// set all buttons draw flag to false
// this will prevent the button from drawing
// and will prevent collisions with the button
- (void) ClearAllButtons
{
	Button *curBtn;
	for( int i = 0; i < TOTAL_BUTTONS; i++ )
	{
		curBtn = [buttonArray objectAtIndex:i];
		curBtn.bDrawButton = false;
	}
	nButtonClicked = NO_BUTTON;
}

// only draw the buttons that are set to draw
- (BOOL) Render
{
	BOOL bRetVal = TRUE;
	
	Button *curBtn;
	
	//if( bShowMainMenu )
	[menuBackGround BlitTranslateX:160.0f TranslateY:320.0f Rotate:0.0f ScaleX:320 ScaleY:-640 Red:1.0f Green:1.0f Blue:1.0f Alpha:1.0f];
	
	for( int i = 0; i < TOTAL_BUTTONS; i++ )
	{
		curBtn = [buttonArray objectAtIndex:i];
		if( curBtn.bDrawButton )
		{
			//[curBtn.btnTexture BlitTranslateX:curBtn.xPos TranslateY:curBtn.yPos Rotate:0.0f];
			[curBtn.btnTexture BlitTranslateX:curBtn.xPos TranslateY:curBtn.yPos Rotate:0.0f ScaleX:BUTTON_SIZE_X ScaleY:(BUTTON_SIZE_Y*-1) Red:1.0f Green:1.0f Blue:1.0f Alpha:1.0f];
		}
	}
	
	return bRetVal;
}

// setup our main menu buttons
- (void) SetUpMainMenu
{
	Button *curBtn;
	
	curBtn = [buttonArray objectAtIndex:MAIN_MENU_SINGLE_PLAYER_GAME];
	curBtn.bDrawButton = true;
	curBtn = [buttonArray objectAtIndex:MAIN_MENU_MULTI_PLAYER_GAME];
	curBtn.bDrawButton = true;
	curBtn = [buttonArray objectAtIndex:MAIN_MENU_NETWORK_PLAYER_GAME];
	curBtn.bDrawButton = true;
	curBtn = [buttonArray objectAtIndex:MAIN_MENU_SETTINGS];
	curBtn.bDrawButton = true;
	
	//curBtn = [buttonArray objectAtIndex:TIME_GAME_BTN];
	//curBtn.bDrawButton = true;
	//curBtn = [buttonArray objectAtIndex:PUZZLE_GAME_BTN];
	//curBtn.bDrawButton = true;
	//curBtn = [buttonArray objectAtIndex:SPLIT_BALL_BTN];
	//curBtn.bDrawButton = true;
	//curBtn = [buttonArray objectAtIndex:ARCADE_GAME_BTN];
	//curBtn.bDrawButton = true;
}

- (void) SetupGameOverOptions
{
	Button *curBtn;
	
	curBtn = [buttonArray objectAtIndex:PLAY_AGAIN_BTN];
	curBtn.bDrawButton = true;
	curBtn = [buttonArray objectAtIndex:MAIN_MENU_BTN];
	curBtn.bDrawButton = true;
}

- (void) SetupWinner
{
	Button *curBtn;
	
	curBtn = [buttonArray objectAtIndex:WINNER_BTN];
	curBtn.bDrawButton = true;
}

- (void) SetupLoser
{
	Button *curBtn;
	
	curBtn = [buttonArray objectAtIndex:LOSER_BTN];
	curBtn.bDrawButton = true;
}


-(void) SetMousePosition:(float)nX:(float)nY
{
	TapXPos = nX;
	TapYPos = nY;
}

- (void) dealloc {
	
	[buttonArray release];
	[menuBackGround release];
	[super dealloc];
}

@end
