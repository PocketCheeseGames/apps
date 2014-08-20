/*
 *  GameDefines.h
 *  DREngine
 *
 *  Created by Rob DelBianco on 5/5/12.
 *  Copyright 2012 Pocket Cheese. All rights reserved.
 *	Imaginary Games
 *
 */


// This value should increment every time a new series is released
#define GIMME_A_BREAK_GAME_SERIES		1

// this value should increment every time a new game mode is released
#define ROCK_PAPER_SCISSORS_GAME_MODE	1

// menu states and options
#define MAIN_MENU_SINGLE_PLAYER_GAME	0
#define MAIN_MENU_MULTI_PLAYER_GAME		1
#define MAIN_MENU_NETWORK_PLAYER_GAME	2
#define MAIN_MENU_SETTINGS				3
#define MAIN_MENU_HELP_INFO				4


// to determine if a player gives or receives stress
#define RPSLS_PLAYER_TYPE_ROCK		1
#define RPSLS_PLAYER_TYPE_PAPER		2
#define	RPSLS_PLAYER_TYPE_SCISSORS	3
#define RPSLS_PLAYER_TYPE_LIZARD	4
#define RPSLS_PLAYER_TYPE_SPOCK		5

//// for our current direction array
//#define ARROW_NONE_INDEX		-1
//#define ARROW_DIR_UP_INDEX		0
//#define ARROW_DIR_RIGHT_INDEX	1
//#define ARROW_DIR_DOWN_INDEX	2
//#define ARROW_DIR_LEFT_INDEX	3
//#define ARROW_MAX_DIRECTIONS	4

// NAMES OF IMAGES

#define FILE_EXT							".png"

//// arrows
//#define SINGLE_ARROW_UP_TEXTURE_NAME		"ArrowUp" FILE_EXT
//#define SINGLE_ARROW_DOWN_TEXTURE_NAME		"ArrowDown" FILE_EXT
//#define SINGLE_ARROW_LEFT_TEXTURE_NAME		"ArrowLeft" FILE_EXT
//#define SINGLE_ARROW_RIGHT_TEXTURE_NAME		"ArrowRight" FILE_EXT
//#define MULTI_ARROW_UP_TEXTURE_NAME			"ArrowMultiUp" FILE_EXT
//#define MULTI_ARROW_DOWN_TEXTURE_NAME		"ArrowMultiDown" FILE_EXT
//#define MULTI_ARROW_LEFT_TEXTURE_NAME		"ArrowMultiLeft" FILE_EXT
//#define MULTI_ARROW_RIGHT_TEXTURE_NAME		"ArrowMultiRight" FILE_EXT
//#define BLOCKED_ARROW_QUEUE_TEXTURE_NAME	"ArrowQueueBlocker" FILE_EXT

// menu
#define MAIN_MENU_SCREEN_TEXTURE_NAME		"MainPage" FILE_EXT
#define BACK_TO_MAIN_MENU_TEXTURE_NAME		"backToMainMenuButton" FILE_EXT
#define HELP_INFO_BUTTON_TEXTURE_NAME		"HelpAndInfoButton" FILE_EXT
#define MULTI_PLAYER_BUTTON_TEXTURE_NAME	"MultiPlayerButton" FILE_EXT
#define NETWORKING_BUTTON_TEXTURE_NAME		"NetworkButton" FILE_EXT
#define SETTINGS_BUTTON_TEXTURE_NAME		"SettingsButton" FILE_EXT
#define SINGLE_PLAYER_BUTTON_TEXTURE_NAME	"SinglePlayerButton" FILE_EXT

// Power Ups and Hazards

// objects

//// player animations
//#define KIA_DOWN_0_TEXTURE_NAME				"KnowItAll_Down0" FILE_EXT
//#define KIA_DOWN_1_TEXTURE_NAME				"KnowItAll_Down1" FILE_EXT
//#define KIA_UP_0_TEXTURE_NAME				"KnowItAll_Up0" FILE_EXT
//#define KIA_UP_1_TEXTURE_NAME				"KnowItAll_Up1" FILE_EXT
//#define KIA_LEFT_0_TEXTURE_NAME				"KnowItAll_Left0" FILE_EXT
//#define KIA_LEFT_1_TEXTURE_NAME				"KnowItAll_Left1" FILE_EXT
//#define KIA_RIGHT_0_TEXTURE_NAME			"KnowItAll_Right0" FILE_EXT
//#define KIA_RIGHT_1_TEXTURE_NAME			"KnowItAll_Right1" FILE_EXT

//#define OA_DOWN_0_TEXTURE_NAME				"OverAchiever_Down0" FILE_EXT
//#define OA_DOWN_1_TEXTURE_NAME				"OverAchiever_Down1" FILE_EXT
//#define OA_UP_0_TEXTURE_NAME				"OverAchiever_Up0" FILE_EXT
//#define OA_UP_1_TEXTURE_NAME				"OverAchiever_Up1" FILE_EXT
//#define OA_LEFT_0_TEXTURE_NAME				"OverAchiever_Left0" FILE_EXT
//#define OA_LEFT_1_TEXTURE_NAME				"OverAchiever_Left1" FILE_EXT
//#define OA_RIGHT_0_TEXTURE_NAME				"OverAchiever_Right0" FILE_EXT
//#define OA_RIGHT_1_TEXTURE_NAME				"OverAchiever_Right1" FILE_EXT

//#define SLACKER_DOWN_0_TEXTURE_NAME			"Slacker_Down0" FILE_EXT
//#define SLACKER_DOWN_1_TEXTURE_NAME			"Slacker_Down1" FILE_EXT
//#define SLACKER_UP_0_TEXTURE_NAME			"Slacker_Up0" FILE_EXT
//#define SLACKER_UP_1_TEXTURE_NAME			"Slacker_Up1" FILE_EXT
//#define SLACKER_LEFT_0_TEXTURE_NAME			"Slacker_Left0" FILE_EXT
//#define SLACKER_LEFT_1_TEXTURE_NAME			"Slacker_Left1" FILE_EXT
//#define SLACKER_RIGHT_0_TEXTURE_NAME		"Slacker_Right0" FILE_EXT
//#define SLACKER_RIGHT_1_TEXTURE_NAME		"Slacker_Right1" FILE_EXT


// EVERY DIRECTION DEFINED
#define DIR_NONE			0;

// Single Direction
#define DIR_UP				1
#define DIR_RIGHT			2
#define DIR_DOWN			3
#define DIR_LEFT			4

//// Two Directions
//#define DIR_UP_DOWN			5
//#define DIR_UP_LEFT			6
//#define DIR_UP_RIGHT		7
//#define DIR_DOWN_LEFT		8
//#define DIR_DOWN_RIGHT		9
//#define DIR_LEFT_RIGHT		10
//
//// Three Directions
//#define DIR_UP_LEFT_RIGHT	11
//#define DIR_DOWN_LEFT_RIGHT	12
//#define DIR_RIGHT_UP_DOWN	13
//#define DIR_LEFT_DOWN_UP	14
//
//// Four Directions
//#define DIR_ALL_DIRECTIONS	15


// Player direction defined
#define PLAYER_DIRECTION_UNKNOWN	-1
#define PLAYER_DIRECTION_NONE		DIR_NONE
#define PLAYER_DIRECTION_UP			DIR_UP
#define PLAYER_DIRECTION_RIGHT		DIR_RIGHT
#define PLAYER_DIRECTION_DOWN		DIR_DOWN
#define PLAYER_DIRECTION_LEFT		DIR_LEFT

// Types of Arrows
#define ARROW_TYPE_UNKNOWN		-1
#define ARROW_TYPE_NORMAL		1
#define ARROW_TYPE_NORMAL_ALL	2
#define ARROW_TYPE_EXPLOSIVE	3
#define ARROW_TYPE_SHOCK		4
#define ARROW_TYPE_SLIPPERY		5
#define ARROW_TYPE_STICKY		6

// item bits that can be on tiles
#define ObjectOnTileBit		0x00000001
#define ArrowOnTileBit		0x00000002
#define PowerUpOnTileBit	0x00000004


// types of tiles we can have

//#define TILE_TYPE_RANDOM			-1	// to let the computer create the tile
//#define	TILE_TYPE_GROUND			0	// regular ground on the game board

//// arrow tiles
//#define TILE_TYPE_REG_ARROW			1	// single directional arrow
//#define TILE_TYPE_RANDOM_ARROW		2	// multi-directional arrow with randomly changing directions
//#define TILE_TYPE_ORDER_ARROW		3	// multi-directional arrow with sequentially changing directions
//
//// hazard arrow tiles
//#define TILE_TYPE_STEEL_ARROW		7	// single directional arrow that cannot be removed or changed on the game board
//#define TILE_TYPE_STONE_ARROW		8	// same as steel, but the arrow breaks after being walked on (causing stress)
//#define TILE_TYPE_SHOCK_ARROW		9	// same as steel, but the arrow shocks the player if it changes their direciton (causing stress)
//#define TILE_TYPE_WIND_ARROW		10	// same as steel arrow with randomly changing directions but player moves quickly over tile
//

// object tiles
#define TILE_TYPE_UNKNOWN_ARROW		11	// question mark tile where the direction is unknown until a player crosses it
#define TILE_TYPE_STOP				12	// special tile forcing a player to stop their movement regardless of direction
#define TILE_TYPE_WATER_COOLER		13	// special area to reduce stress or bring in an NPC to create stress
#define TILE_TYPE_BUMPER			14	// special tile bouncing a player over a single tile
//#define TILE_TYPE_PRINTER			15	// special tile inducing stress
//#define TILE_TYPE_GOAL				16	// goal area for future game modes

//// these are bad things that can be added to the game board
//#define TILE_TYPE_COMPUTER			17	// special tile used for blowing up a players placed arrows
//
//// power ups and hazards
//#define PU_INVINCIBILITY			19	// invincibility
//#define PU_INVISIBILITY				20	// invincibility
//#define PU_SHIELD					21	// shield
//#define PU_SPEED_BOOST				22	// increase speed
//#define PU_SPEED_REDUCE				23	// decrease speed
//#define PU_BAD_STRESS_BALL			24	// increase stress
//#define PU_GOOD_STRESS_BALL			25	// decrease stress
//#define PU_INCREASE_POINTS			26	// increase points
//#define PU_DECREASE_POINTS			27	// decrease points
//#define PU_SWAP_PLAYER_POS			28	// swap player positions
//#define PU_SWAP_PLAYER_POINTS		29	// swap player points
//#define PU_SWAP_PLAYER_STRESS		30	// swap player stress meter
//#define PU_SWAP_PLAYER_PU			31	// swap player power up meter
//#define PU_TELEPORT					32	// teleport
//#define PU_DOPPLEGANGER				33	// create a decoy player
//#define PU_GAIN_LIFE				34	// gain a life
//#define PU_LOSE_LIFE				35	// lose a life
//#define PU_TORNADO					36	// player gets randomly moved around the board with disregard to arrows
//
//#define TILE_TYPE_STEEL_PLATE		100	// block a space in the arrow queue

#define TILE_SIZE	35.0f
#define HALF_TILE	TILE_SIZE*.5f


#define MAX_ROWS		9
#define MAX_COLS		12
#define MAX_GAME_TILES	108//9*12

//#define PLAYER_OWNER			0 // player is always green arrows
#define TYPE_KNOW_IT_ALL		0
#define TYPE_OVER_ACHIEVER		1
#define TYPE_SLACKER			2
#define TYPE_RUMOR_STARTER		3
#define TYPE_GOOF_BALL			4

/*
 Over-Achiever	- speed (2), stress (1), power up (0), and stop (3)
 Know-It-All	- speed (1), stress (1), power up (2), and stop (2)
 Slacker		- speed (0), stress (3), power up (2), and stop (1)
 Goof-Ball		- speed (1), stress (2), power up (3), and stop (0)
 Rumor-Starter	- speed (3), stress (1), power up (2), and stop (0)
 
 Overachiever: 	beats “Know it All” and “Rumor Starter”
 Know It All: 	beats “Slacker” and “Goof Ball”
 Slacker:		beats “Overachiever” and “Goof Ball”
 Goof Ball:		beats “Overachiever” and “Rumor Starter”
 Rumor Starter:	beats “Know It All” and “Slacker” 
 */

#define	MAX_ARROW_QUEUE		7
#define MAX_TIME_FULL_QUEUE	10 // seconds
#define MAX_HAZARD_ARROWS	10

#define CPU_TIME_TO_ADD_ARROW	30

#define ARROW_COLLISION_TIME	15

#define MAX_X_POS			290//MAX_ROWS*TILE_SIZE//290
#define MAX_Y_POS			MAX_COLS*TILE_SIZE //450

#define NO_TILE_SELECTED	-1

#define INSERT_BAD_TILE		100


#define MAX_POWER_UP_ITEMS 4
#define TIME_TO_ADD_POWER_UP_ITEM 500
#define POWER_UP_AND_HAZARD_DURATION 2500

#define PU_ITEM_SPEED_BOOST		1
#define PU_ITEM_SPEED_REDUCE	2
#define PU_ITEM_TELEPORT		3
#define PU_ITEM_STRESS_REDUCE	4
#define PU_ITEM_STRESS_INDUCE	5
#define PU_ITEM_LOSE_A_LIFE		6
#define PU_ITEM_GAIN_A_LIFE		7
#define PU_ITEM_INVINCIBLE		8
#define PU_ITEM_INVISIBLE		9
#define PU_ITEM_SHIELD			10
#define PU_ITEM_SWAP_POSITION	11
#define PU_ITEM_SWAP_POINTS		12
#define PU_ITEM_SWAP_PU_METER	13
#define PU_ITEM_SWAP_HP_METER	14
#define PU_ITEM_SWAP_LIVES		15
#define PU_ITEM_TORNADO			16
#define PU_ITEM_DOPPLEGANGER	17
#define PU_ITEM_MAX				17

// extra one for the sticky arrow attribute
#define STICKY_ARROW			20
#define SLIPPERY_ARROW			21

#define PU_SPEED_BOOST_BIT		0x00000001
#define PU_SPEED_REDUCE_BIT		0x00000002
#define PU_INVINCIBLE_BIT		0x00000004
#define PU_INVISIBLE_BIT		0x00000008
#define PU_SHIELD_BIT			0x00000010
#define PU_SWAP_POSITION_BIT	0x00000020
#define PU_SWAP_POINTS_BIT		0x00000040
#define PU_SWAP_POWER_UP_BIT	0x00000080
#define PU_SWAP_STRESS_BIT		0x00000100
#define PU_SWAP_LIVES_BIT		0x00000200
#define PU_TORNADO_BIT			0x00000400
#define PU_DOPPLEGANGER_BIT		0x00000800
#define STICKY_ARROW_BIT		0x00001000
#define SLIPPERY_ARROW_BIT		0x00002000

#define PU_SPEED_BOOST_INDEX	0
#define PU_SPEED_REDUCE_INDEX	1
#define PU_INVINCIBLE_INDEX		2
#define PU_INVISIBLE_INDEX		3
#define PU_SHIELD_INDEX			4
#define PU_TORNADO_INDEX		5
#define STICKY_ARROW_INDEX		6
#define SLIPPERY_ARROW_INDEX	7
#define PU_MAX_INDEX			8

#define PU_SPEED_DURATION		300
#define STICKY_ARROW_DURATION	100
#define SLIPPERY_ARROW_DURATION	50


// player actions: need timers for all animations or effect lengths
// Stressing (fight cloud)
// Jumping
// Slipping on arrow
// Being Electrocuted
// Stressing Out (stress meter full)
// Detonating an Explosive Arrow
// Teleporting
// Swapping Position
// Respawning

// game actions
// Swapping Stress Meter
// Swapping Power Up Meter
// Swapping Lives
// Swapping Points/Kills
// Power Up Full
// Close to Stressing Out (slow blink to stress meter?)


//// tile owner
//#define TILE_OWNER_NONE			0	// the tile is open for anyone to place a tile
//#define	TILE_OWNER_TILE_ENGINE	1	// this tile was created by the tile engine (cannot be overwrittent)
//#define TILE_OWNER_ORANGE		2	// can only change your own arrows
//#define TILE_OWNER_PURPLE		3	//
//#define TILE_OWNER_PINK			4	//
//#define TILE_OWNER_BROWN		5	//
//#define TILE_OWNER_CYAN			6	//

//// arrow color values
//#define ARROW_COLOR_GREEN		1
//#define ARROW_COLOR_YELLOW		2
//#define ARROW_COLOR_BLUE		3
//#define ARROW_COLOR_RED			4

// animation values
#define MAX_ANIMATION_IMAGES	8
#define ANIMATION_UP_1			0
#define ANIMATION_UP_2			1
#define ANIMATION_RIGHT_1		2
#define ANIMATION_RIGHT_2		3
#define ANIMATION_DOWN_1		4
#define ANIMATION_DOWN_2		5
#define ANIMATION_LEFT_1		6
#define ANIMATION_LEFT_2		7

// stress and power up meter defined
#define MAX_METER_VALUE			100


//#define GIVE_STRESS_WATER_COOLER	1
//#define REDUCE_STRESS_WATER_COOLER	2
//#define GIVE_STRESS_STRESS_BALL		3
//#define REDUCE_STRESS_STRESS_BALL	4

