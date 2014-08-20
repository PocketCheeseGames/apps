//
//  Tile.m
//  DREngine
//
//  Created by Rob DelBianco on 4/23/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "Tile.h"
#import "DREngine.h"
#import "GameDefines.h"
#import "UtilFuncs.h"


@implementation Tile


@synthesize xPos;
@synthesize yPos;
//@synthesize hazardTrips;


- (id)InitTile
{
	self = [super init];
	itemOnTile = 0;
	return self;
}

- (void) SetBaseImage
{
	pBaseTileImage = [[DRResourceManager GetInstance] LoadTexture:@"FloorTile.png"];
	//pBaseTileImage = [[DRResourceManager GetInstance] LoadTexture:@"Carpet.png"];
	//pBaseTileImage = [[DRResourceManager GetInstance] LoadTexture:@"Carpet1.png"];
	//pBaseTileImage = [[DRResourceManager GetInstance] LoadTexture:@"Carpet2.png"];
}

// basic function to draw a tile
// these can be arrows, game board tiles, or hazard tiles
- (void)DrawTile
{
	if( pBaseTileImage )
		[pBaseTileImage BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:1.0f Green:1.0f Blue:1.0f Alpha:1.0f];
}

- (void) dealloc
{
	if( pBaseTileImage )
		[pBaseTileImage release];
	[super dealloc];
}

// if object is on tile, then no
// if arrow is on tile, then no
- (bool) OkToPlaceArrow
{
	uf = [Utils GetInstance];
	if( [uf IsBitSet:itemOnTile :ObjectOnTileBit] )
		return false;
	if( [uf IsBitSet:itemOnTile :ArrowOnTileBit] )
		return false;
	if( [uf IsBitSet:itemOnTile :PowerUpOnTileBit] )
		return false;
	return true;
}

// if object is on tile, then no
// if power up is on tile, then no
- (bool) OkToPlacePowerUp
{
	uf = [Utils GetInstance];
	if( [uf IsBitSet:itemOnTile :ObjectOnTileBit] )
		return false;
	if( [uf IsBitSet:itemOnTile :PowerUpOnTileBit] )
		return false;
	if( [uf IsBitSet:itemOnTile :ArrowOnTileBit] )
		return false;
	return true;
}

// nothing to do here...
- (void)PlayerChanges:(Player*)pPlayer
{
}


- (void) SetItemOnTile:(unsigned int)item
{
	uf = [Utils GetInstance];
	itemOnTile = [uf SetBit:itemOnTile :item];
}

- (void) RemoveItemOnTile:(unsigned int)item
{
	uf = [Utils GetInstance];
	itemOnTile = [uf ClearBit:itemOnTile :item];
}

/*
// these are tiles that are created at the beginning from the tile engine
- (void) CreateGameBoardTile:(float)newXPos
							 :(float)newYPos
							 :(int)newType
{
	[self SetBasicInfo:newXPos :newYPos : newType];
	
	// call function to setup the images
	[self SetupTextures];
}

// these are the arrow tiles created for the arrow queue to be used in the game
- (void) CreateArrowQueueTile:(float)newXPos
							  :(float)newYPos
							  :(int)newOwner
{
	int newType = [self CreateArrowType];
	
	[self SetBasicInfo:newXPos :newYPos : newType];
	
	owner = newOwner;
	
	// find out direction(s) of arrow
	[self SetupAllDirections];
	[self SetupAvailableDirections];
	
	// set the background for an arrow tile
	baseTile = [[DRResourceManager GetInstance] LoadTexture:@"ArrowOwner.png"];
	
	// call function to setup the images
	[self SetupTextures];
}


// this is similar for all tile creation
- (void)SetBasicInfo:(float)newXPos
					:(float)newYPos
					:(int)newType
{
	[self ResetArrowDirections];
	
	xPos = newXPos;
	yPos = newYPos;
	type = newType;
	
	waterCoolerVacant = true;
	hazardTrips = 0;
	
	curDirectionIndex = ARROW_NONE_INDEX;
	allDirections = DIR_NONE;
	
	// set all images to be null
	[self ZeroOutTextures];
}

// this is for when we have to change an image in the arrow queue or game board
- (void)ClearCurrentTextures
{
	if( baseTile )
		[baseTile release];
	if( specialTile )
		[specialTile release];
	
	if( upArrow )
		[upArrow release];
	if( leftArrow )
		[leftArrow release];
	if( rightArrow )
		[rightArrow release];
	if( downArrow )
		[downArrow release];
	
	[self ZeroOutTextures];
}

- (void)ZeroOutTextures
{
	baseTile		= 0;
	specialTile		= 0;
	upArrow			= 0;
	leftArrow		= 0;
	rightArrow		= 0;
	downArrow		= 0;
}

// so we can setup all of the information to be an arrow tile
- (void)ChangeGameBoardTile:(Tile*)Arrow
{
	// get the arrow information setup
	type = [Arrow GetTileType];
	curDirectionIndex = [Arrow GetCurrentDirectionIndex];
	allDirections = [Arrow GetAllDirections];
	[self SetupAvailableDirections];
	
	// now reset the current images and get the new ones
	[self ClearCurrentTextures];
	[self SetupTextures];
	
}


- (int)GetAllDirections
{
	return allDirections;
}

- (int)GetCurrentDirectionIndex
{
	return curDirectionIndex;
}

- (void)RemoveHazardTile
{
	hazardTrips = 0;
	type = TILE_TYPE_GROUND;
	[self ResetArrowDirections];
	[self ClearCurrentTextures];
	[self SetupTextures];
}

// change this tile to some sort of a hazard tile
- (void)HazardGameBoardTile:(int)newType
{
	type = newType;
	[self ResetArrowDirections];
	[self SetupAllDirections];
	[self SetupAvailableDirections];
	
	// reset the current images and get the new ones
	[self ClearCurrentTextures];
	[self SetupTextures];
}

// update the arrow queue with a different type of arrow
- (void)ChangeArrowQueueTile:(int)newType
{
	if( newType != TILE_TYPE_STEEL_PLATE )
		[self CreateArrowQueueTile:xPos:yPos:owner];
	else
	{
		type = newType;
		[self ResetArrowDirections];
		
		// reset the current images and get the new ones
		[self ClearCurrentTextures];
		[self SetupTextures];
	}
}

// this function will take care of all the images needed for the tile
- (void)SetupTextures
{
	switch (type) {
		
		case TILE_TYPE_GROUND:
			
			// set the image for a basic ground tile
			baseTile = [[DRResourceManager GetInstance] LoadTexture:@"FloorTile.png"];
			
			owner = TILE_OWNER_NONE;
			
			break;
		
		case TILE_TYPE_REG_ARROW:
			
			// if it's a regular or single direction stop arrow, need to load the big arrow image
			if( allDirections == DIR_UP )
				upArrow = [[DRResourceManager GetInstance] LoadTexture:@SINGLE_ARROW_UP_TEXTURE_NAME];
			else if( allDirections == DIR_RIGHT )
				rightArrow = [[DRResourceManager GetInstance] LoadTexture:@SINGLE_ARROW_RIGHT_TEXTURE_NAME];
			else if( allDirections == DIR_DOWN )
				downArrow = [[DRResourceManager GetInstance] LoadTexture:@SINGLE_ARROW_DOWN_TEXTURE_NAME];
			else if( allDirections == DIR_LEFT )
				leftArrow = [[DRResourceManager GetInstance] LoadTexture:@SINGLE_ARROW_LEFT_TEXTURE_NAME];
			
			break;
			
		case TILE_TYPE_STEEL_ARROW:
			
			// if it's a regular or single direction stop arrow, need to load the big arrow image
			if( allDirections == DIR_UP )
				upArrow = [[DRResourceManager GetInstance] LoadTexture:@"SteelArrowUp.png"];
			else if( allDirections == DIR_RIGHT )
				rightArrow = [[DRResourceManager GetInstance] LoadTexture:@"SteelArrowRight.png"];
			else if( allDirections == DIR_DOWN )
				downArrow = [[DRResourceManager GetInstance] LoadTexture:@"SteelArrowDown.png"];
			else if( allDirections == DIR_LEFT )
				leftArrow = [[DRResourceManager GetInstance] LoadTexture:@"SteelArrowLeft.png"];
			
			break;
			
		case TILE_TYPE_STONE_ARROW:
			
			// if it's a regular or single direction stop arrow, need to load the big arrow image
			if( allDirections == DIR_UP )
				upArrow = [[DRResourceManager GetInstance] LoadTexture:@"StoneArrowUp.png"];
			else if( allDirections == DIR_RIGHT )
				rightArrow = [[DRResourceManager GetInstance] LoadTexture:@"StoneArrowRight.png"];
			else if( allDirections == DIR_DOWN )
				downArrow = [[DRResourceManager GetInstance] LoadTexture:@"StoneArrowDown.png"];
			else if( allDirections == DIR_LEFT )
				leftArrow = [[DRResourceManager GetInstance] LoadTexture:@"StoneArrowLeft.png"];
			
			break;
			
		case TILE_TYPE_SHOCK_ARROW:
			
			// if it's a regular or single direction stop arrow, need to load the big arrow image
			if( allDirections == DIR_UP )
				upArrow = [[DRResourceManager GetInstance] LoadTexture:@"ShockArrowUp.png"];
			else if( allDirections == DIR_RIGHT )
				rightArrow = [[DRResourceManager GetInstance] LoadTexture:@"ShockArrowRight.png"];
			else if( allDirections == DIR_DOWN )
				downArrow = [[DRResourceManager GetInstance] LoadTexture:@"ShockArrowDown.png"];
			else if( allDirections == DIR_LEFT )
				leftArrow = [[DRResourceManager GetInstance] LoadTexture:@"ShockArrowLeft.png"];
			
			break;
			
		case TILE_TYPE_WIND_ARROW:
			
			// if it's a regular or single direction stop arrow, need to load the big arrow image
			if( allDirections == DIR_UP )
				upArrow = [[DRResourceManager GetInstance] LoadTexture:@"WindArrowUp.png"];
			else if( allDirections == DIR_RIGHT )
				rightArrow = [[DRResourceManager GetInstance] LoadTexture:@"WindArrowRight.png"];
			else if( allDirections == DIR_DOWN )
				downArrow = [[DRResourceManager GetInstance] LoadTexture:@"WindArrowDown.png"];
			else if( allDirections == DIR_LEFT )
				leftArrow = [[DRResourceManager GetInstance] LoadTexture:@"WindArrowLeft.png"];
			
			break;
			
		case TILE_TYPE_RANDOM_ARROW:
		case TILE_TYPE_ORDER_ARROW:
			
			// if it's a multi-directional arrow, need to load the small arrow images
			if( availableDirections[ARROW_DIR_UP_INDEX] )
				upArrow = [[DRResourceManager GetInstance] LoadTexture:@MULTI_ARROW_UP_TEXTURE_NAME];
			if( availableDirections[ARROW_DIR_RIGHT_INDEX] )
				rightArrow = [[DRResourceManager GetInstance] LoadTexture:@MULTI_ARROW_RIGHT_TEXTURE_NAME];
			if( availableDirections[ARROW_DIR_DOWN_INDEX] )
				downArrow = [[DRResourceManager GetInstance] LoadTexture:@MULTI_ARROW_DOWN_TEXTURE_NAME];
			if( availableDirections[ARROW_DIR_LEFT_INDEX] )
				leftArrow = [[DRResourceManager GetInstance] LoadTexture:@MULTI_ARROW_LEFT_TEXTURE_NAME];
			
			break;
			
		case TILE_TYPE_UNKNOWN_ARROW:
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"QuestionMark.png"];
			owner = TILE_OWNER_TILE_ENGINE;
			break;
			
		case TILE_TYPE_STOP:
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"StopSign.png"];
			owner = TILE_OWNER_TILE_ENGINE;
			break;
			
		case TILE_TYPE_WATER_COOLER:
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"WaterCooler.png"];
			owner = TILE_OWNER_TILE_ENGINE;
			break;
			
		case TILE_TYPE_BUMPER:
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"Trampoline.png"];
			owner = TILE_OWNER_TILE_ENGINE;
			break;
		
		case TILE_TYPE_STEEL_PLATE:
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"BadArrowPlaced.png"];
		
		default:
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"Carpet.png"];
			break;
	}
}

// basic function to draw a tile
// these can be arrows, game board tiles, or hazard tiles
- (void)DrawTile
{
	//int		nColor = 0;
	float	red		= 1.0f,
			green	= 1.0f,
			blue	= 1.0f,
			alpha	= 1.0f;
	
	//// base tile is the color of the owner
	//if( owner != TILE_OWNER_TILE_ENGINE )
	//{
	//	// we need a different color
	//	// we will do purple for now
	//	green = 0.0f;
	//}
	
	if( baseTile )
		[baseTile BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:red Green:green Blue:blue Alpha:alpha];
		
	if( specialTile )
	{
		// if it's an arrow tile, show the color it belongs to
		if( [self IsRegularArrow] )
		{
			red = 1.0f;
			blue = 1.0f;
			green = 0.0f;
		}
		
		[specialTile BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:red Green:green Blue:blue Alpha:alpha];
	}
	
	// change color for the arrows as well
	
	if( upArrow )
	{
		//if( type == TILE_TYPE_REG_ARROW ||
		//    (curDirectionIndex == ARROW_DIR_UP_INDEX )
		if( type == TILE_TYPE_REG_ARROW )
		{
			red = 0.0f;
			green = 1.0f;
			blue = 0.0f;
		}
		else if( type == TILE_TYPE_RANDOM_ARROW )
		{
			red = 1.0f;
			green = 1.0f;
			blue = 0.0f;
		}
		else if( type == TILE_TYPE_ORDER_ARROW )
		{
			red = 0.0f;
			green = 0.0f;
			blue = 1.0f;
		}
		else
		{
			red = 1.0f;
			green = 1.0f;
			blue = 1.0f;
		}
		
		[upArrow BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:red Green:green Blue:blue Alpha:alpha];
	}
	
	if ( leftArrow )
	{
		//if( type == TILE_TYPE_REG_ARROW  ||
		//   curDirectionIndex == ARROW_DIR_LEFT_INDEX )
		if( type == TILE_TYPE_REG_ARROW )
		{
			red = 0.0f;
			green = 1.0f;
			blue = 0.0f;
		}
		else if( type == TILE_TYPE_RANDOM_ARROW )
		{
			red = 1.0f;
			green = 1.0f;
			blue = 0.0f;
		}
		else if( type == TILE_TYPE_ORDER_ARROW )
		{
			red = 0.0f;
			green = 0.0f;
			blue = 1.0f;
		}
		else
		{
			red = 1.0f;
			green = 1.0f;
			blue = 1.0f;
		}
		
		[leftArrow BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:red Green:green Blue:blue Alpha:alpha];
	}
	
	if( rightArrow )
	{
		//if( type == TILE_TYPE_REG_ARROW  ||
		//   curDirectionIndex == ARROW_DIR_RIGHT_INDEX )
		if( type == TILE_TYPE_REG_ARROW )
		{
			red = 0.0f;
			green = 1.0f;
			blue = 0.0f;
		}
		else if( type == TILE_TYPE_RANDOM_ARROW )
		{
			red = 1.0f;
			green = 1.0f;
			blue = 0.0f;
		}
		else if( type == TILE_TYPE_ORDER_ARROW )
		{
			red = 0.0f;
			green = 0.0f;
			blue = 1.0f;
		}
		else
		{
			red = 1.0f;
			green = 1.0f;
			blue = 1.0f;
		}
		[rightArrow BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:red Green:green Blue:blue Alpha:alpha];
	}
	
	if( downArrow )
	{
		//if( type == TILE_TYPE_REG_ARROW  ||
		//   curDirectionIndex == ARROW_DIR_DOWN_INDEX )
		if( type == TILE_TYPE_REG_ARROW )
		{
			red = 0.0f;
			green = 1.0f;
			blue = 0.0f;
		}
		else if( type == TILE_TYPE_RANDOM_ARROW )
		{
			red = 1.0f;
			green = 1.0f;
			blue = 0.0f;
		}
		else if( type == TILE_TYPE_ORDER_ARROW )
		{
			red = 0.0f;
			green = 0.0f;
			blue = 1.0f;
		}
		else
		{
			red = 1.0f;
			green = 1.0f;
			blue = 1.0f;
		}
		[downArrow BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:red Green:green Blue:blue Alpha:alpha];
	}
}

// get rid of the image if it exists
- (void)SelectArrowQueueImage
{
	if( !specialTile )
		specialTile = [[DRResourceManager GetInstance] LoadTexture:@"ArrowOwner.png"];
}

// load the image
- (void)DeselectArrowQueueImage
{
	if( specialTile )
		[specialTile release];
	specialTile = 0;
}

// reset the arrow directions
- (void)ResetArrowDirections
{
	for( int i = 0; i < ARROW_MAX_DIRECTIONS; ++i )
		availableDirections[i] = false;
}

// cycle to the next availabe direction
- (void)UpdateChangingArrow
{
	// if it's not a changing tile, then nothing to do
	if( ![self IsChangingArrowTile] )
		return;
	
	// if it's random, then get a random value
	if( type == TILE_TYPE_RANDOM_ARROW )
		curDirectionIndex = [self GetRandomNumber:ARROW_DIR_UP_INDEX : ARROW_DIR_LEFT_INDEX];
	else
		curDirectionIndex++; // otherwise we increment to the next direction
	
	while(true)
	{
		// make sure we don't step out of bounds of avaiable directions
		if( curDirectionIndex >= ARROW_MAX_DIRECTIONS )
			curDirectionIndex = 0;
		
		// check to see if we have found our next available direction
		if( availableDirections[curDirectionIndex] )
			break;
		
		// we haven't, so move on to the next one
		curDirectionIndex++;
	}
}

// this will return a color value for the arrow
//ARROW_COLOR_GREEN
//ARROW_COLOR_YELLOW
//ARROW_COLOR_BLUE
//ARROW_COLOR_RED
- (int)GetArrowColor:(int)dir
{
	//// based on the direction passed in
	//// we can determine which color to pass back
	//switch (dir)
	//{
	//	case DIR_UP:
	//		if( curDirectionIndex == ARROW_DIR_UP_INDEX )
	//		{
	//				return ARROW_COLOR_GREEN;
	//		}
	//		else
	//		{
	//			// either blue or yellow
	//			if( type == TILE_TYPE_RANDOM_ARROW )
	//				return ARROW_COLOR_YELLOW;
	//			else
	//				return ARROW_COLOR_BLUE;
	//		}
	//		break;
	//	
	//	case DIR_DOWN:
	//		if( curDirectionIndex == ARROW_DIR_DOWN_INDEX )
	//		{
	//			// either red or green
	//			if( type == TILE_TYPE_STOP_ARROW )
	//				return ARROW_COLOR_RED;
	//			else
	//				return ARROW_COLOR_GREEN;
	//		}
	//		else
	//		{
	//			// either blue or yellow
	//			if( type == TILE_TYPE_RANDOM_ARROW )
	//				return ARROW_COLOR_YELLOW;
	//			else
	//				return ARROW_COLOR_BLUE;
	//		}
	//		
	//		break;
	//	
	//	case DIR_LEFT:
	//		if( curDirectionIndex == ARROW_DIR_LEFT_INDEX )
	//		{
	//			// either red or green
	//			if( type == TILE_TYPE_STOP_ARROW )
	//				return ARROW_COLOR_RED;
	//			else
	//				return ARROW_COLOR_GREEN;
	//		}
	//		else
	//		{
	//			// either blue or yellow
	//			if( type == TILE_TYPE_RANDOM_ARROW )
	//				return ARROW_COLOR_YELLOW;
	//			else
	//				return ARROW_COLOR_BLUE;
	//		}
	//		break;
	//	
	//	case DIR_RIGHT:
	//		if( curDirectionIndex == ARROW_DIR_RIGHT_INDEX )
	//		{
	//			// either red or green
	//			if( type == TILE_TYPE_STOP_ARROW )
	//				return ARROW_COLOR_RED;
	//			else
	//				return ARROW_COLOR_GREEN;
	//		}
	//		else
	//		{
	//			// either blue or yellow
	//			if( type == TILE_TYPE_RANDOM_ARROW )
	//				return ARROW_COLOR_YELLOW;
	//			else
	//				return ARROW_COLOR_BLUE;
	//		}
	//		break;
	//	default:
	//		break;
	//}
	return 0;
}

- (int)GetTileType
{
	return type;
}

// if a player is at the water cooler
// then the water cooler is not vacant
- (void)SetPlayerAtWaterCooler:(bool) atWaterCooler
{
	if( atWaterCooler )
		waterCoolerVacant = false;
	else
		waterCoolerVacant = true;
}

- (BOOL)IsWaterCoolerVacant
{
	return waterCoolerVacant;
}

- (int)GetOwner
{
	return owner;
}


- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue
{
	return (arc4random() % (nHighValue-nLowRange+1)+nLowRange);
}

// randomly determine if an object should be added to the game board
- (BOOL)ShouldAddObjectToGameBoard
{
	// a 10% chance???
	int nRand = [self GetRandomNumber:1 :100];
	
	if( nRand <= 10 )
		return TRUE;
	return FALSE;
}

// randomly determine which object tile gets created
- (void)SetRandomObjectTile
{
	type = [self GetRandomNumber:TILE_TYPE_UNKNOWN_ARROW :TILE_TYPE_BUMPER];
}

// is it a multi-directional arrow?
- (BOOL)IsChangingArrowTile
{
	if(	type == TILE_TYPE_RANDOM_ARROW		||
		type == TILE_TYPE_ORDER_ARROW )
		return TRUE;
	return FALSE;
}


// find out if the tile can change
- (BOOL)CanTileChange:(int)nOwner
{
	if(type == TILE_TYPE_STEEL_ARROW	||
	   type == TILE_TYPE_STONE_ARROW	||
	   type == TILE_TYPE_SHOCK_ARROW	||
	   type == TILE_TYPE_WIND_ARROW		||
	   type == TILE_TYPE_WATER_COOLER	||
	   type == TILE_TYPE_UNKNOWN_ARROW	||
	   type == TILE_TYPE_STOP			||
	   type == TILE_TYPE_GOAL			||
	   type == TILE_TYPE_BUMPER			||
	   type == TILE_TYPE_PRINTER )
		return FALSE;
	return TRUE;
}


//// I don't even know how to use these functions...
//- (id)initArrow:(float)newXPos
//		   yPos:(float)newYPos
//		 radius:(float)newRad
//		   type:(int)newType
//{
//	self = [super init];
//	
//	xPos = newXPos;
//	yPos = newYPos;
//	type = newType;
//	radius = HALF_TILE;
//	curDirectionIndex = NO_TILE_SELECTED;
//	baseTile = 0;
//	specialTile = 0;
//	return self;
//}

//// whatever new directions are coming in, set them to the existing tile
//- (void)SetAvailableDirections:(Tile*)pNewTile
//{	
//	for( int ii = 0; ii < ARROW_MAX_DIRECTIONS; ++ii )
//		availableDirections[ii] = pNewTile.availableDirections[ii];
//}


- (void)SetupAllDirections
{
	if( [self IsChangingArrowTile] )
		allDirections = [self GetRandomNumber:5 : 15];
	else
		allDirections = [self GetRandomNumber:1 :4];
}

- (void)SetupAvailableDirections
{
	// check the value for all the directions that need to be available
	switch( allDirections )
	{
		case DIR_UP:
			availableDirections[ARROW_DIR_UP_INDEX] = true;
			curDirectionIndex = ARROW_DIR_UP_INDEX;
			break;
		case DIR_RIGHT:
			availableDirections[ARROW_DIR_RIGHT_INDEX] = true;
			curDirectionIndex = ARROW_DIR_RIGHT_INDEX;
			break;
		case DIR_DOWN:
			availableDirections[ARROW_DIR_DOWN_INDEX] = true;
			curDirectionIndex = ARROW_DIR_DOWN_INDEX;
			break;
		case DIR_LEFT:
			availableDirections[ARROW_DIR_LEFT_INDEX] = true;
			curDirectionIndex = ARROW_DIR_LEFT_INDEX;
			break;
		case DIR_UP_DOWN:
			availableDirections[ARROW_DIR_UP_INDEX] = true;
			availableDirections[ARROW_DIR_DOWN_INDEX] = true;
			break;
		case DIR_UP_LEFT:
			availableDirections[ARROW_DIR_UP_INDEX] = true;
			availableDirections[ARROW_DIR_LEFT_INDEX] = true;
			break;
		case DIR_UP_RIGHT:
			availableDirections[ARROW_DIR_UP_INDEX] = true;
			availableDirections[ARROW_DIR_RIGHT_INDEX] = true;
			break;
		case DIR_DOWN_LEFT:
			availableDirections[ARROW_DIR_DOWN_INDEX] = true;
			availableDirections[ARROW_DIR_LEFT_INDEX] = true;
			break;
		case DIR_DOWN_RIGHT:
			availableDirections[ARROW_DIR_DOWN_INDEX] = true;
			availableDirections[ARROW_DIR_RIGHT_INDEX] = true;
			break;
		case DIR_LEFT_RIGHT:
			availableDirections[ARROW_DIR_LEFT_INDEX] = true;
			availableDirections[ARROW_DIR_RIGHT_INDEX] = true;
			break;
		case DIR_UP_LEFT_RIGHT:
			availableDirections[ARROW_DIR_UP_INDEX] = true;
			availableDirections[ARROW_DIR_LEFT_INDEX] = true;
			availableDirections[ARROW_DIR_RIGHT_INDEX] = true;
			break;
		case DIR_DOWN_LEFT_RIGHT:
			availableDirections[ARROW_DIR_DOWN_INDEX] = true;
			availableDirections[ARROW_DIR_LEFT_INDEX] = true;
			availableDirections[ARROW_DIR_RIGHT_INDEX] = true;
			break;
		case DIR_RIGHT_UP_DOWN:
			availableDirections[ARROW_DIR_RIGHT_INDEX] = true;
			availableDirections[ARROW_DIR_UP_INDEX] = true;
			availableDirections[ARROW_DIR_DOWN_INDEX] = true;
			break;
		case DIR_LEFT_DOWN_UP:
			availableDirections[ARROW_DIR_LEFT_INDEX] = true;
			availableDirections[ARROW_DIR_DOWN_INDEX] = true;
			availableDirections[ARROW_DIR_UP_INDEX] = true;
			break;
		case DIR_ALL_DIRECTIONS:
			availableDirections[ARROW_DIR_UP_INDEX] = true;
			availableDirections[ARROW_DIR_RIGHT_INDEX] = true;
			availableDirections[ARROW_DIR_DOWN_INDEX] = true;
			availableDirections[ARROW_DIR_LEFT_INDEX] = true;
			break;
		
		//default:
			
			//	// don't know what to do here...
	};
	
	// set the current direction if it hasn't been set
	if( curDirectionIndex == ARROW_NONE_INDEX )
		[self UpdateChangingArrow];
}


- (BOOL)IsArrowTile
{
	// need to add other arrow tiles
	if( [self IsRegularArrow] )
		return TRUE;
	if( [self IsHazardArrow])
		return TRUE;
	return FALSE;
}


// these change a players direction
- (BOOL)IsRegularArrow
{
	if( type == TILE_TYPE_REG_ARROW		||
	    type == TILE_TYPE_RANDOM_ARROW	||
	    type == TILE_TYPE_ORDER_ARROW )
		return TRUE;
	return FALSE;
}

// these tiles can not be removed
// and they are bad...
- (BOOL)IsHazardArrow
{
	if( type == TILE_TYPE_STEEL_ARROW	||
	    type == TILE_TYPE_STONE_ARROW	||
	    type == TILE_TYPE_SHOCK_ARROW	||
	    type == TILE_TYPE_WIND_ARROW )
		return TRUE;
	return FALSE;
}



- (BOOL)IsQueueTileBlocked
{
	if( type == TILE_TYPE_STEEL_PLATE )
		return TRUE;
	return FALSE;
}

- (BOOL)IsWaterCooler
{
	if( type == TILE_TYPE_WATER_COOLER )
		return TRUE;
	return FALSE;
}

- (BOOL)IsStopSign
{
	if( type == TILE_TYPE_STOP )
		return TRUE;
	return FALSE;
}

- (BOOL)IsGoal
{
	if( type == TILE_TYPE_GOAL )
		return TRUE;
	return FALSE;
}

- (BOOL)IsBumper
{
	if( type == TILE_TYPE_BUMPER )
		return TRUE;
	return FALSE;
}

- (BOOL)IsPrinter
{
	if( type == TILE_TYPE_PRINTER )
		return TRUE;
	return FALSE;
}

- (int)CreateArrowType
{
	return [self GetRandomNumber:TILE_TYPE_REG_ARROW :TILE_TYPE_ORDER_ARROW];
}

// this is based on the current direction of the tile
- (int)GetPlayerDirection
{
	if( curDirectionIndex != ARROW_NONE_INDEX )
		return (curDirectionIndex+1);
	
	// if we get down here, either it's not an arrow queue
	// or we have no idea what the direction is...
	return PLAYER_DIRECTION_UNKNOWN;
}



- (void) dealloc
{
	[self ClearCurrentTextures];
	[super dealloc];
}


/*

// this is based on the available directions
// and the current direction
// and the type of arrow tile
- (void)ChangeArrowImage
{
	// for now I am just going to use the current direction
	if( specialTile )
		[specialTile release];
	
	switch( curDirectionIndex )
	{
		case ARROW_DIR_UP_INDEX:
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"ArrowUp.png"];
			break;
		case ARROW_DIR_RIGHT_INDEX:
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"ArrowRight.png"];
			break;
		case ARROW_DIR_DOWN_INDEX:
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"ArrowDown.png"];
			break;
		case ARROW_DIR_LEFT_INDEX:
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"ArrowLeft.png"];
			break;
		default:
			// dont' know what to do
			specialTile = [[DRResourceManager GetInstance] LoadTexture:@"AnnaBall1.png"];
			break;
	}
}



- (void)SetGameBoardBackground
{
	// for now...
	baseTile = [[DRResourceManager GetInstance] LoadTexture:@"FloorTile.png"];
	specialTile = 0;
}

- (void)SetArrowQueueBackground
{
	// for now...
	baseTile = [[DRResourceManager GetInstance] LoadTexture:@"Carpet1.png"];
	specialTile = 0;
}


//TILE_TYPE_REG_ARROW
//TILE_TYPE_RANDOM_ARROW
//TILE_TYPE_ORDER_ARROW




- (void)CreateSolidArrow
{
	type = TILE_TYPE_STEEL_ARROW;
}


- (void)CreateQueueBlocker
{
	//NO_TILE_SELECTED
	type = TILE_TYPE_STEEL_PLATE;
}


- (void)CreateUnknownArrow
{
	type = TILE_TYPE_UNKNOWN_ARROW;
}


- (void)CreateWaterCooler
{
	//NO_TILE_SELECTED
	type = TILE_TYPE_WATER_COOLER;
}

- (void)CreateStopSign
{
	//NO_TILE_SELECTED
	type = TILE_TYPE_STOP;
}

- (void)CreateComputer
{
	//NO_TILE_SELECTED
	type = TILE_TYPE_COMPUTER;
}

- (void)CreateGoal
{
	//NO_TILE_SELECTED
	type = TILE_TYPE_GOAL;
}

- (void)CreateBumper
{
	//NO_TILE_SELECTED
	type = TILE_TYPE_BUMPER;
}

- (void)CreateFaultyPrinter
{
	//NO_TILE_SELECTED
	type = TILE_TYPE_PRINTER;
}




//- (void)ChangeTileType:(int)ntype
//{
//	directions = 0;
//	type = [self GetRandomNumber:TILE_TYPE_REG_ARROW :TILE_TYPE_UNKNOWN_ARROW]; 
//	
//	// basic now to get arrows going
//	if( directions & TILE_DIR_UP )
//		directions |= TILE_CUR_UP;
//	else if( directions & TILE_DIR_DOWN )
//		directions |= TILE_CUR_DOWN;
//	else if( directions & TILE_CUR_LEFT )
//		directions |= TILE_CUR_LEFT;
//	else if( directions & TILE_CUR_RIGHT )
//		directions |= TILE_CUR_RIGHT;
//	
//	// call function to change the image
//	[self ChangeImage];
//}
//
//- (void)ChangeTileType
//{
//	int nNum = 0;
//	directions = 0;
//	type = TILE_TYPE_REG_ARROW; //[self GetRandomNumber:TILE_TYPE_REG_ARROW :TILE_TYPE_BUMPER]; 
//	
//	nNum = [self GetRandomNumber:1:4];
//	
//	// basic now to get arrows going
//	if( nNum == 1 )
//		directions |= TILE_CUR_UP;
//	if( nNum == 2 )
//		directions |= TILE_CUR_DOWN;
//	if( nNum == 3 )
//		directions |= TILE_CUR_LEFT;
//	if( nNum == 4 )
//		directions |= TILE_CUR_RIGHT;
//	
//	//// set all possible directions randomly
//	//directions = [self GetRandomNumber:1 :15];
//	//
//	//if( directions & TILE_DIR_UP )
//	//	directions |= TILE_CUR_UP;
//	//else if( directions & TILE_DIR_DOWN )
//	//	directions |= TILE_CUR_DOWN;
//	//else if( directions & TILE_DIR_LEFT )
//	//	directions |= TILE_CUR_LEFT;
//	//else if( directions & TILE_DIR_RIGHT )
//	//	directions |= TILE_CUR_RIGHT;
//	
//	// call function to change the image
//	[self ChangeImage];
//}
//







//- (void)ChangeImage
//{
//	// for now
//	if( specialTile )
//		[specialTile release];
//	
//	if( directions & TILE_CUR_UP )
//		specialTile = [[DRResourceManager GetInstance] LoadTexture:@"up.png"];
//	else if( directions & TILE_CUR_LEFT )
//		specialTile = [[DRResourceManager GetInstance] LoadTexture:@"left.png"];
//	else if( directions & TILE_CUR_RIGHT )
//		specialTile = [[DRResourceManager GetInstance] LoadTexture:@"right.png"];
//	else if( directions & TILE_CUR_DOWN )
//		specialTile = [[DRResourceManager GetInstance] LoadTexture:@"down.png"];
//	
//	//switch (type) {
//	//	case TILE_TYPE_GOAL:
//	//	{
//	//	}
//	//		break;
//	//	case TILE_TYPE_REG_ARROW:
//	//	{
//	//	}
//	//		break;
//	//	default:
//	//		break;
//	//}
//	//specialTile = [[DRResourceManager GetInstance] LoadTexture:@"left.png"];
//}
//*/

@end
