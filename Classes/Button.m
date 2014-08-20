//
//  Button.m
//  DREngine
//
//  Created by Rob DelBianco on 3/24/10.
//  Copyright 2010 Pocket Cheese. All rights reserved.
//

#import "Button.h"
#import "DREngine.h"
#import "GameDefines.h"

@implementation Button

@synthesize bDrawButton;
@synthesize	xPos;
@synthesize	yPos;
@synthesize	nButtonType;
@synthesize btnTexture;


- (Button*)initButton:(float)newXPos
				 yPos:(float)newYPos
		  nButtonType:(int)newButtonType
{
	xPos = newXPos;
	yPos = newYPos;
	nButtonType = newButtonType;
	
	[self SetButtonType:nButtonType];
	
	return self;
}


- (BOOL) ButtonClickedX:(float)tapX
{
	if( tapX < (xPos-175) )
		return NO;
	if( tapX > (xPos-145) )     
		return NO;
	return YES;
}

- (BOOL) ButtonClickedY:(float)tapY
{
	if( tapY > ((yPos-255)*-1) )
		return NO;
	if( tapY < ((yPos-225)*-1) )
		return NO;
	
	return YES;
}


- (void) SetButtonType:(int)type
{
	xPos = 140.0f;
	
	switch (type) {
		case MAIN_MENU_SINGLE_PLAYER_GAME:
			
			yPos = 225.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@ SINGLE_PLAYER_BUTTON_TEXTURE_NAME];
			
			break;
		case MAIN_MENU_MULTI_PLAYER_GAME:
			
			yPos = 285.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@ MULTI_PLAYER_BUTTON_TEXTURE_NAME];
			
			break;
		case MAIN_MENU_NETWORK_PLAYER_GAME:
			
			yPos = 345.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@ NETWORKING_BUTTON_TEXTURE_NAME];
			
			break;
		case MAIN_MENU_SETTINGS:
			
			yPos = 405.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@ SETTINGS_BUTTON_TEXTURE_NAME];
			
			break;
		default:
			break;
	}
	
	// OLD STUFF
	/*
	switch (type) {
		case PLAY_AGAIN_BTN:
			yPos = 100.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@"PlayAgain_Btn.png"];
			break;
		case MAIN_MENU_BTN:
			yPos = 200.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@"MainMenu_Btn.png"];
			break;
		case TIME_GAME_BTN:
			yPos = 100.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@"Time_Btn.png"];
			break;
		case PUZZLE_GAME_BTN:
			yPos = 150.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@"Puzzle_Btn.png"];
			break;
		case SPLIT_BALL_BTN:
			yPos = 200.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@"SplitBall_Btn.png"];
			break;
		case ARCADE_GAME_BTN:
			yPos = 250.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@"Arcade_Btn.png"];
			break;
		case WINNER_BTN:
			yPos = 250.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@"Winner_Btn.png"];
			break;
		case LOSER_BTN:
			yPos = 250.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@"Loser_Btn.png"];
			break;
		default:
			yPos = 250.0f;
			btnTexture = [[DRResourceManager GetInstance] LoadTexture:@"Earth.png"];
			break;
	}
	 */
}


- (void) dealloc {
	
	[super dealloc];
}

@end
