//
//  Tile.h
//  DREngine
//
//  Created by Rob DelBianco on 4/23/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTexture.h"
#import "Player.h"

@class Utils;

@interface Tile : NSObject
{
	float xPos;
	float yPos;
	DRTexture *pBaseTileImage;
	Utils	*uf;
	unsigned int itemOnTile;
}


@property(nonatomic, assign) float xPos;
@property(nonatomic, assign) float yPos;

- (id)InitTile;
- (void)DrawTile;
- (void)SetBaseImage;
- (void)PlayerChanges:(Player*)pPlayer;
- (bool) OkToPlaceArrow;
- (bool) OkToPlacePowerUp;
- (void) SetItemOnTile:(unsigned int)item;
- (void) RemoveItemOnTile:(unsigned int)item;

@end

/*
@interface Tile : NSObject {

	float	xPos;	// the center x position of the tile
	float	yPos;	// the center y position of the tile
	//float	radius;
	int		type;	// the type of tile we are working with
	int		owner;	// the owner of the tile (either tile engine, player or AI)
	int		curDirectionIndex;	// the current index
	int		allDirections;
	int		hazardTrips;
	bool	waterCoolerVacant;
	bool	availableDirections[4];
	
	// background image of the tile (or the floor)
	DRTexture *baseTile;
	
	// a special object tile
	DRTexture *specialTile;
	
	// could be a small arrow, big arrow or hazard arrow
	DRTexture *upArrow;
	DRTexture *leftArrow;
	DRTexture *rightArrow;
	DRTexture *downArrow;
}

- (Tile*)InitTile;

// these are tiles that are created at the beginning from the tile engine
- (void) CreateGameBoardTile:(float)newXPos
							 :(float)newYPos
							 :(int)newType;

// these are the arrow tiles created for the arrow queue to be used in the game
- (void) CreateArrowQueueTile:(float)newXPos
							  :(float)newYPos
							  :(int)newOwner;

// basic functions
- (void)SetBasicInfo:(float)newXPos
					:(float)newYPos
					:(int)newType;

- (int)GetArrowColor:(int)dir;

- (void)ClearCurrentTextures;
- (void)ZeroOutTextures;
- (void)SetupTextures;
- (void)DrawTile;
- (void)SelectArrowQueueImage;
- (void)DeselectArrowQueueImage;
- (void)ResetArrowDirections;
- (void)UpdateChangingArrow;
- (int)GetTileType;
- (int)GetOwner;
- (int)GetAllDirections;
- (int)GetCurrentDirectionIndex;
- (void)SetPlayerAtWaterCooler:(bool) atWaterCooler;
- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue;
- (void)SetupAllDirections;
- (void)SetupAvailableDirections;
- (BOOL)IsChangingArrowTile;
- (int)CreateArrowType;
- (BOOL)IsWaterCoolerVacant;

// functions to determine a type of arrow
- (BOOL)IsArrowTile;
- (BOOL)IsHazardArrow;
- (BOOL)IsRegularArrow;

// this will use the random number generator to determine if something should be added to the game board
- (BOOL)ShouldAddObjectToGameBoard;
- (void)SetRandomObjectTile;

//- (void)SetGameBoardBackground;
//- (void)SetArrowQueueBackground;

- (BOOL)CanTileChange:(int)nOwner;
- (void)ChangeGameBoardTile:(Tile*)Arrow;
- (void)ChangeArrowQueueTile:(int)newType;
- (void)HazardGameBoardTile:(int)newType;
- (void)RemoveHazardTile;

- (int)GetPlayerDirection;
//- (void)ChangeArrowImage;


//// these are for creating random arrowtiles for the arrow queue
//- (void)CreateArrowTile;

//// these are for creating specific tiles
//- (void)CreateSolidArrow;
//- (void)CreateQueueBlocker;
//- (void)CreateUnknownArrow;
//- (void)CreateWaterCooler;
//- (void)CreateStopSign;
//- (void)CreateComputer;
//- (void)CreateGoal;
//- (void)CreateBumper;
//- (void)CreateFaultyPrinter;
//
//
- (BOOL)IsQueueTileBlocked;
- (BOOL)IsWaterCooler;
- (BOOL)IsStopSign;
- (BOOL)IsGoal;
- (BOOL)IsBumper;
- (BOOL)IsPrinter;


@property(nonatomic, assign) float xPos;
@property(nonatomic, assign) float yPos;
@property(nonatomic, assign) int hazardTrips;
//@property(nonatomic, assign) float radius;
//@property(nonatomic, assign) int type;
//@property(nonatomic, assign) int curDirectionIndex;
//@property(nonatomic, assign) int allDirections;
//@property(nonatomic, assign) char directions;
//@property(nonatomic, assign) DRTexture *baseTile;
//@property(nonatomic, assign) DRTexture *specialTile;

 
 

@end
*/ 
