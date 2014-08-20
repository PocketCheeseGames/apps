//
//  Player.m
//  DREngine
//
//  Created by Rob DelBianco on 4/1/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "Player.h"
#import "DREngine.h"
#import "NormalArrow.h"
#import "ExplosiveArrow.h"
#import "ShockArrow.h"
#import "SlipperyArrow.h"
#import "StickyArrow.h"
#import "NormalAllArrow.h"
#import	"UtilFuncs.h"
#import "Tile.h"


#define ANIMATION_TIME	15
#define JUMP_TIME		45
#define HALF_JUMP_TIME	22
#define TILE_BUFFER		5


// these are the four setable values used for these attributes
// the lower the index, the worse it is for the player
// slower speed, longer stop duration, higher stress adjustment, lower power up adjustment
const float	PLAYER_SPEED[4]				= { 0.5f, 0.7f, 1.0f, 1.2f };
const int	PLAYER_STOP_DURATION[4]		= { 70, 55, 40, 25 };
const float PLAYER_STRESS_ADJUSTMENT[4] = { 0.8f, 0.6f, 0.4f, 0.2f };
const float PLAYER_PU_ADJUSTMENT[4]		= { 0.5f, 0.8f, 1.2f, 1.7f };

@implementation Player

//@synthesize stopXMovement;
//@synthesize stopYMovement;
@synthesize xPos;
@synthesize yPos;
@synthesize xVel;
@synthesize yVel;
@synthesize powerUpMeter;
@synthesize stressMeter;
@synthesize score;
@synthesize type;
@synthesize numLives;
@synthesize bBlowUp;
@synthesize arrowCollisionTimer;
@synthesize bJumpingActive;
@synthesize powerUpBits;
@synthesize bGetNewPosition;
@synthesize bDoppleGanger;


- (id)initPlayer:(float)newXPos
		  yPos:(float)newYPos
		 //value:(int)newValue
{
	self = [super init];
	
	xPos = newXPos;
	yPos = newYPos;
	stoppedTimer = 0;
	score = 0;
	
	return self;
}

- (void) InitializePlayer
{
	int nNewDir = 0;
	stoppedTimer = 0;
	score = 0;
	xVel = 1.0f;
	yVel = 1.0f;
	stressMeter = 0;
	powerUpMeter = 0;
	powerUpBits = 0;
	playerActions = 0;
	gameActions = 0;
	numLives = 5;
	respawnTimer = 0;
	numKills = 0;
	bJumpingActive = false;
	bRespawnPlayer = false;
	bGetNewPosition = false;
	bDoppleGanger = false;
	bHumanPlayer = false;
	jumpTimer = 0;
	jumpScale = 1.0f;
	playerArrows = 0;
	uf = [Utils GetInstance];
	
	nNewDir = [uf GetRandomNumber:1:4];
	
	[self ChangeDirection:nNewDir:xPos:yPos];
	
	playerArrows = [[NSMutableArray alloc] init];
	
	bBlowUp = false;
	
	for( int ii = 0; ii < MAX_ANIMATION_IMAGES; ++ii )
		directions[ii] = 0;
	for( int ii = 0; ii < PU_MAX_INDEX; ++ii )
		powerUpTimers[ii] = 0;
	
	stressAnimation = 0;
	playerShadow = 0;
	
	stressAnimation = [[DRResourceManager GetInstance] LoadTexture:@"playerStress.png"];
	playerShadow = [[DRResourceManager GetInstance] LoadTexture:@"PlayerCircle.png"];
}

- (void) SetAsHuman
{
	bHumanPlayer = true;
}

// send in the type of power up to apply to our player
- (void)AddPowerUp:(unsigned int) _type
{
	uf = [Utils GetInstance];
	// we only care about a few of these really...
	switch( _type )
	{
		case PU_ITEM_SPEED_BOOST:
			// clear the reduce bit
			powerUpBits = [uf ClearBit:powerUpBits :PU_SPEED_REDUCE_BIT];
			// set the boost bit
			powerUpBits = [uf SetBit:powerUpBits :PU_SPEED_BOOST_BIT];
			//set our timer
			powerUpTimers[PU_SPEED_BOOST_INDEX] = PU_SPEED_DURATION;
			break;
		case PU_ITEM_SPEED_REDUCE:
			// clear the boost bit
			powerUpBits = [uf ClearBit:powerUpBits :PU_SPEED_BOOST_BIT];
			// set the reduce bit
			powerUpBits = [uf SetBit:powerUpBits :PU_SPEED_REDUCE_BIT];
			//set our timer
			powerUpTimers[PU_SPEED_REDUCE_INDEX] = PU_SPEED_DURATION;
			break;
		case PU_ITEM_TELEPORT:
			bGetNewPosition = true;
			break;
		case PU_ITEM_INVINCIBLE:
			powerUpBits = [uf SetBit:powerUpBits :PU_INVINCIBLE_BIT];
			powerUpTimers[PU_INVINCIBLE_INDEX] = PU_SPEED_DURATION;
			break;
		case PU_ITEM_INVISIBLE:
			powerUpBits = [uf SetBit:powerUpBits :PU_INVISIBLE_BIT];
			powerUpTimers[PU_INVISIBLE_INDEX] = PU_SPEED_DURATION;
			break;
		case PU_ITEM_SHIELD:
			powerUpBits = [uf SetBit:powerUpBits :PU_SHIELD_BIT];
			powerUpTimers[PU_SHIELD_INDEX] = PU_SPEED_DURATION;
			break;
		case PU_ITEM_TORNADO:
			powerUpBits = [uf SetBit:powerUpBits :PU_TORNADO_BIT];
			powerUpTimers[PU_TORNADO_INDEX] = PU_SPEED_DURATION;
			break;
		case PU_ITEM_SWAP_POSITION:
			powerUpBits = [uf SetBit:powerUpBits :PU_SWAP_POSITION_BIT];
			break;
		case PU_ITEM_SWAP_POINTS:
			powerUpBits = [uf SetBit:powerUpBits :PU_SWAP_POINTS_BIT];
			break;
		case PU_ITEM_SWAP_PU_METER:
			powerUpBits = [uf SetBit:powerUpBits :PU_SWAP_POWER_UP_BIT];
			break;
		case PU_ITEM_SWAP_HP_METER:
			powerUpBits = [uf SetBit:powerUpBits :PU_SWAP_STRESS_BIT];
			break;
		case PU_ITEM_SWAP_LIVES:
			powerUpBits = [uf SetBit:powerUpBits :PU_SWAP_LIVES_BIT];
			break;
		case PU_ITEM_DOPPLEGANGER:
			powerUpBits = [uf SetBit:powerUpBits :PU_DOPPLEGANGER_BIT];
		case STICKY_ARROW:
			powerUpBits = [uf SetBit:powerUpBits :STICKY_ARROW_BIT];
			powerUpTimers[STICKY_ARROW_INDEX] = STICKY_ARROW_DURATION;
			break;
		case SLIPPERY_ARROW:
			powerUpBits = [uf SetBit:powerUpBits :SLIPPERY_ARROW_BIT];
			powerUpTimers[SLIPPERY_ARROW_INDEX] = SLIPPERY_ARROW_DURATION;
			break;
		default:
			break;
	}
}

- (void)PlayerSwapPowerUp:(Player*)plr
{
	float newX = 0.0f;
	float newY = 0.0f;
	float newxVel = 0.0f;
	float newyVel = 0.0f;
	float newStress = 0.0f;
	float newPU = 0.0f;
	int newScore = 0;
	int newLives = 0;
	
	// don't waist our time...
	if( powerUpBits == 0 )
		return;
	
	uf = [Utils GetInstance];
	
	if( [uf IsBitSet:powerUpBits :PU_SWAP_POSITION_BIT] &&
	    !plr.bJumpingActive )
	{
		newX = plr.xPos;
		newY = plr.yPos;
		newxVel = plr.xVel;
		newyVel = plr.yVel;
		
		plr.xPos = xPos;
		plr.yPos = yPos;
		plr.xVel = xVel;
		plr.yVel = yVel;
		
		xPos = newX;
		yPos = newY;
		xVel = newxVel;
		yVel = newyVel;
		
		// now that both players have their new position and speed, change their animations
		[self ChangeAnimation];
		[plr ChangeAnimation];
		powerUpBits = [uf ClearBit:powerUpBits :PU_SWAP_POSITION_BIT];
	}
	if( [uf IsBitSet:powerUpBits :PU_SWAP_POINTS_BIT] )
	{
		newScore = plr.score;
		plr.score = score;
		score = newScore;
		powerUpBits = [uf ClearBit:powerUpBits :PU_SWAP_POINTS_BIT];
	}
	if( [uf IsBitSet:powerUpBits :PU_SWAP_POWER_UP_BIT] )
	{
		newPU = plr.powerUpMeter;
		plr.powerUpMeter = powerUpMeter;
		powerUpMeter = newPU;
		powerUpBits = [uf ClearBit:powerUpBits :PU_SWAP_POWER_UP_BIT];
	}
	if( [uf IsBitSet:powerUpBits :PU_SWAP_STRESS_BIT] )
	{
		newStress = plr.stressMeter;
		plr.stressMeter = stressMeter;
		stressMeter = newStress;
		powerUpBits = [uf ClearBit:powerUpBits :PU_SWAP_STRESS_BIT];
	}
	if( [uf IsBitSet:powerUpBits :PU_SWAP_LIVES_BIT] )
	{
		newLives = plr.numLives;
		plr.numLives = numLives;
		numLives = newLives;
		powerUpBits = [uf ClearBit:powerUpBits :PU_SWAP_LIVES_BIT];
	}
}

- (void)ClearPowerUpBits
{
	uf = [Utils GetInstance];
	for( int ii = 0; ii < PU_MAX_INDEX; ++ii )
	{
		if( powerUpTimers[ii] > 0 )
			powerUpTimers[ii]--;
	}
	
	// ugly but I can't think of a better way
	if( powerUpTimers[PU_SPEED_BOOST_INDEX] <= 0 )
		powerUpBits = [uf ClearBit:powerUpBits :PU_SPEED_BOOST_BIT];
	if( powerUpTimers[PU_SPEED_REDUCE_INDEX] <= 0 )
		powerUpBits = [uf ClearBit:powerUpBits :PU_SPEED_REDUCE_BIT];
	if( powerUpTimers[PU_INVINCIBLE_INDEX] <= 0 )
		powerUpBits = [uf ClearBit:powerUpBits :PU_INVINCIBLE_BIT];
	if( powerUpTimers[PU_INVISIBLE_INDEX] <= 0 )
		powerUpBits = [uf ClearBit:powerUpBits :PU_INVISIBLE_BIT];
	if( powerUpTimers[PU_SHIELD_INDEX] <= 0 )
		powerUpBits = [uf ClearBit:powerUpBits :PU_SHIELD_BIT];
	if( powerUpTimers[PU_TORNADO_INDEX] <= 0 )
		powerUpBits = [uf ClearBit:powerUpBits :PU_TORNADO_BIT];
	if( powerUpTimers[STICKY_ARROW_INDEX] <= 0 )
		powerUpBits = [uf ClearBit:powerUpBits :STICKY_ARROW_BIT];
	if( powerUpTimers[SLIPPERY_ARROW_INDEX] <= 0 )
		powerUpBits = [uf ClearBit:powerUpBits :SLIPPERY_ARROW_BIT];
}

// this is for when a player adds an arrow to the gameboard
- (void)PlayerAddedArrow:(Tile*)_tile
						:(int)_Dir
						:(int)_type
						:(int)maxAllowed
{
	Arrow *pNewArrow = 0;
	Arrow *pCurArrow = 0;
	Tile  *pCurTile = 0;
	int nArrowCount = [playerArrows count];
	
	if( nArrowCount == maxAllowed )
	{
		pCurArrow = [playerArrows objectAtIndex:0];
		pCurTile = [pCurArrow GetTileLocation];
		[pCurTile RemoveItemOnTile:ArrowOnTileBit];
		[playerArrows removeObjectAtIndex:0];
	}
	
	// create the new arrow being passed in
	switch( _type )
	{
		case ARROW_TYPE_NORMAL:
			pNewArrow = [[NormalArrow alloc] InitArrow:_Dir:type];
			break;
		case ARROW_TYPE_EXPLOSIVE:
			pNewArrow = [[ExplosiveArrow alloc] InitArrow:_Dir:type];
			break;
		case ARROW_TYPE_SHOCK:
			pNewArrow = [[ShockArrow alloc] InitArrow:_Dir:type];
			break;
		case ARROW_TYPE_SLIPPERY:
			pNewArrow = [[SlipperyArrow alloc] InitArrow:_Dir:type];
			break;
		case ARROW_TYPE_STICKY:
			pNewArrow = [[StickyArrow alloc] InitArrow:_Dir:type];
			break;
		case ARROW_TYPE_NORMAL_ALL:
			pNewArrow = [[NormalAllArrow alloc] InitNormalAllArrow:_Dir :type];
			break;
		default:
			pNewArrow = [[NormalArrow alloc] InitArrow:_Dir:type];
			break;
	}
	[pNewArrow SetTileLocation:_tile];
	
	// add the new arrow to the player array
	[playerArrows addObject:pNewArrow];
	
	[pNewArrow release];
}

- (void)DrawArrows
{
	Arrow *pNewArrow = 0;
	int nArrowCount = [playerArrows count];
	
	for( int ii = 0; ii < nArrowCount; ++ii )
	{
		pNewArrow = [playerArrows objectAtIndex:ii];
		
		[pNewArrow DrawArrow:1.0f];
	}
}

- (void) SetPlayerAttributes:(int)speedSetting :(int)stopDur :(int)stressAdj :(int)puAdj
{
	// set the players attributes
	
	// SPEED
	if( speedSetting < 0 )
		speedSetting = 0;
	else if( speedSetting > 3 )
		speedSetting = 3;
	nSpeedSetting = speedSetting; // 0-3
	
	// STOP DURATION
	if( stopDur < 0 )
		stopDur = 0;
	else if( stopDur > 3 )
		stopDur = 3;
	nStopSetting = stopDur; // 0-3
	
	// STRESS ADJUSTMENT
	if( stressAdj < 0 )
		stressAdj = 0;
	else if( stressAdj > 3 )
		stressAdj = 3;
	nStressSetting = stressAdj; // 0-3
	
	// PU ADJUSTMENT
	if( puAdj < 0 )
		puAdj = 0;
	else if( puAdj > 3 )
		puAdj = 3;
	nPowerUpSetting = puAdj; // 0-3
}


//- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue
//{
//	return (arc4random() % (nHighValue-nLowRange+1)+nLowRange);
//}


- (void)StopPlayerMovement
{
	stoppedTimer = PLAYER_STOP_DURATION[nStopSetting];
}


- (void)IncreaseStress
{
	uf = [Utils GetInstance];
	
	if( [uf IsBitSet:powerUpBits:PU_INVINCIBLE_BIT] )
		return;
	
	stressMeter += PLAYER_STRESS_ADJUSTMENT[nStressSetting];
	
	// if this is a Doppleganger, then give it extra stress
	if( bDoppleGanger )
	{
		// triple it?
		stressMeter += PLAYER_STRESS_ADJUSTMENT[nStressSetting];
		stressMeter += PLAYER_STRESS_ADJUSTMENT[nStressSetting];
	}
	
	if( stressMeter > MAX_PLAYER_STRESS_LEVEL )
		stressMeter = MAX_PLAYER_STRESS_LEVEL;
}

- (void)DecreaseStress
{
	stressMeter -= PLAYER_STRESS_ADJUSTMENT[nStressSetting];
	
	if( stressMeter < 0.0f )
		stressMeter = 0.0f;
}

- (void)IncreasePowerUp
{
	powerUpMeter += PLAYER_PU_ADJUSTMENT[nPowerUpSetting];
	
	if( powerUpMeter > MAX_PLAYER_STRESS_LEVEL )
		powerUpMeter = MAX_PLAYER_STRESS_LEVEL;
}

- (void)UseSpecialPowerUp
{
	powerUpMeter = 0;
}

// either the player is stressing out or he is not
- (void)SetStressActivity:(bool)newStressActive
{
	bStressActive = newStressActive;
}

// did the player hit a trampoline
- (void)SetJumpActive
{
	bJumpingActive = true;
	
	// this will need to adjust based on the player speed
	// we only want to jump over one tile...
	jumpTimer = JUMP_TIME;
	jumpScale = 1.0f;
}


// adjust the player stress level
- (void)AdjustStressMeter:(int)adjType
{
	// make sure we don't go negative
	if( stressMeter < 0 )
		stressMeter = 0;
}

// this is for the player only
- (void) GetCurrentPlayerVelocity
{
	// find out if we need to adjust our velocity
	uf = [Utils GetInstance];
	float speed = PLAYER_SPEED[nSpeedSetting];
	
	if( [uf IsBitSet:powerUpBits:PU_SPEED_BOOST_BIT] )
		speed *= 1.5;
	else if( [uf IsBitSet:powerUpBits:PU_SPEED_REDUCE_BIT] )
		speed *= .5f;
	
	// go even slower than current speed...
	if( [uf IsBitSet:powerUpBits:STICKY_ARROW_BIT] )
		speed *= .5f;
	else if( [uf IsBitSet:powerUpBits :SLIPPERY_ARROW_BIT] )
		speed *= 1.5f;
	
	if( xVel != 0 )
	{
		if( xVel < 0 )
			speed *= -1;
		xVel = speed;
	}
	else if( yVel != 0 )
	{
		if( yVel < 0 )
			speed *= -1;
		yVel = speed;
	}
}

// find out if the player should change directions
// based on the arrow it is colliding with
- (void)ChangeDirection:(int)newDir:(float)x:(float)y;
{
	// don't change if we jumping
	if( bJumpingActive )
		return;
	float speed = 0.0f;
	[self GetCurrentPlayerVelocity];
	
	if( xVel != 0.0f )
		speed = xVel;
	else
		speed = yVel;
	
	if( speed < 0 )
		speed *= -1;
	
	// clear our current velocities
	xVel = 0.0f;
	yVel = 0.0f;
	
	switch (newDir) {
		case PLAYER_DIRECTION_UP:
			yVel = (speed*-1);
			animationIndex = ANIMATION_UP_1;
			break;
		case PLAYER_DIRECTION_DOWN:
			yVel = speed;
			animationIndex = ANIMATION_DOWN_1;
			break;
		case PLAYER_DIRECTION_LEFT:
			xVel = (speed*=-1);
			animationIndex = ANIMATION_LEFT_1;
			break;
		case PLAYER_DIRECTION_RIGHT:
			xVel = speed;
			animationIndex = ANIMATION_RIGHT_1;
			break;
		default:
			break;
	}
	
	arrowCollisionTimer = ARROW_COLLISION_TIME;
	xPos = x;
	yPos = y;
}

// this is for the swap player position pouwer up...
- (void)ChangeAnimation
{
	if( yVel < 0 )
		animationIndex = ANIMATION_UP_1;
	else if( yVel > 0 )
		animationIndex = ANIMATION_DOWN_1;
	else if( xVel < 0 )
		animationIndex = ANIMATION_LEFT_1;
	else if( xVel > 0 )
		animationIndex = ANIMATION_RIGHT_1;
}

// pass in a player to check for collisions with arrows
- (bool)PlayerChanges:(Player*)pPlayer
{
	int nArrow = [playerArrows count];
	Arrow *pCurArrow = 0;
	Tile *pCurTile = 0;
	uf = [Utils GetInstance];
	
	// if the player being passed in is jumping, then don't do anything
	if( pPlayer.bJumpingActive )
		return false;
	
	// check for own arrow direction changes
	if( pPlayer.arrowCollisionTimer <= 0 )
	{
		for( int ii = 0; ii < nArrow; ++ii )
		{
			pCurArrow = [playerArrows objectAtIndex:ii];
			
			if( [pCurArrow GetArrowType] != ARROW_TYPE_NORMAL ||
			    ( pPlayer.bDoppleGanger && pPlayer.type == type) )
			{
				if( [pCurArrow PlayerChanges:pPlayer] )
				{
					pPlayer.arrowCollisionTimer = ARROW_COLLISION_TIME;
					pPlayer.xPos = pCurArrow.xPos;
					pPlayer.yPos = pCurArrow.yPos;
					
					// remove if it's an explosive arrow
					if( [pCurArrow GetArrowType] == ARROW_TYPE_EXPLOSIVE )
					{
						// player detonates the bomb
						pCurTile = [pCurArrow GetTileLocation];
						[pCurTile RemoveItemOnTile:ArrowOnTileBit];
						[playerArrows removeObjectAtIndex:ii];
					}
					break;
				}
			}
		}
	}
	
	// for dopplegangers...
	if( pPlayer.type == type )
		return false;
	
	return [uf isCollision:pPlayer.xPos :pPlayer.yPos :xPos :yPos :HALF_TILE];
}


- (void)SetupDoppleganger:(Player*)plr
{
	xPos = plr.xPos;
	yPos = plr.yPos;
	xVel = plr.xVel*-1;
	yVel = plr.yVel*-1;
	numLives = 1;
	bDoppleGanger = true;
	[self ChangeAnimation];
}

- (void)CheckStressFromPlayer:(int) plrType
{
	// this does nothing....
}


// find out if a player is colliding with another
- (BOOL)IsCollidingWithPlayer:(float)p2xPos
							 :(float)p2yPos
{
	// add a buffer
	if( xPos+HALF_TILE-TILE_BUFFER <= p2xPos-HALF_TILE )
		return FALSE;
	if( xPos-HALF_TILE >= p2xPos+HALF_TILE-TILE_BUFFER )
		return FALSE;
	if( yPos-HALF_TILE >= p2yPos+HALF_TILE-TILE_BUFFER )
		return FALSE;
	if( yPos+HALF_TILE-TILE_BUFFER <= p2yPos-HALF_TILE )
		return FALSE;
	return TRUE;
}


// something to cycle through our player animations
- (void)DrawPlayerAnimation
{
	bool invisible = false;
	uf = [Utils GetInstance];
	
	// nothing to draw
	if( numLives <= 0 )
		return;
	
	if( [uf IsBitSet:powerUpBits :PU_INVISIBLE_BIT] )
		invisible = true;
	
	// if we are a cpu player and we are invisible and we are not stressing from another player,
	// then don't draw anything
	if( invisible && !bHumanPlayer && !bStressActive )
		return;
	
	if( bRespawnActive || invisible )
		fAlpha = .5f;
	else if( bDoppleGanger )
	{
		fAlpha +=.05f;
		
		if( fAlpha > 1.0f )
			fAlpha = .5f;
	}
	else
		fAlpha = 1.0f;

	
	if( bJumpingActive )
	{
		if( jumpTimer >= HALF_JUMP_TIME )
			jumpScale += .03;
		else
			jumpScale -= .03;
		[directions[animationIndex]  BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE*jumpScale ScaleY:(TILE_SIZE*-jumpScale) Red:1.0f Green:1.0f Blue:1.0f Alpha:fAlpha];
	}
	else if( bStressActive )
		[stressAnimation BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:1.0f Green:1.0f Blue:1.0f Alpha:1.0f];
	else
	{
		float plrRed = [uf GetPlayerRedValue:type];
		float plrBlue = [uf GetPlayerBlueValue:type];
		float plrGreen = [uf GetPlayerGreenValue:type];
		
		[playerShadow BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:plrRed Green:plrGreen Blue:plrBlue Alpha:fAlpha];
		
		[directions[animationIndex]  BlitTranslateX:xPos TranslateY:yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:1.0f Green:1.0f Blue:1.0f Alpha:fAlpha];
		
	}
}

- (bool)ShouldRespawnPlayer
{
	return bRespawnPlayer;
}


- (void) SetNewPlayerPosition:(float)newXPos
							 :(float)newYPos
{
	xPos = newXPos;
	yPos = newYPos;
	bGetNewPosition = false;
}

- (void)RespawnPlayer:(float)newXPos
					 :(float)newYPos
{
	int ncount = [playerArrows count];
	Tile *pCurTile = 0;
	Arrow *pCurArrow = 0;
	
	if( numLives > 0 )
	{
		xPos = newXPos;
		yPos = newYPos;
		bRespawnPlayer = false;
		bRespawnActive = false;
		stressMeter = 0;
		powerUpMeter = 0;
		numLives--;
		respawnTimer = 0;
		
		// need to clear the arrow on tile bit
		for( int ii = 0; ii < ncount; ++ii )
		{
			pCurArrow = [playerArrows objectAtIndex:ii];
			pCurTile = [pCurArrow GetTileLocation];
			[pCurTile RemoveItemOnTile:ArrowOnTileBit];
		}
		
		// need to remove all arrows in the queue
		for( int ii = 0; ii < ncount; ++ii )
		{
			[playerArrows removeLastObject];
		}
	}
}

// countdown timer for respawning our player
- (void)RespawnCountDown
{
	respawnTimer--;
	bRespawnPlayer = false;
}

// if a player is out of lives, then he is done
- (BOOL) IsPlayerDone
{
	if( numLives > 0 )
		return FALSE;
	return TRUE;
}


// keep the ball in play
- (void)KeepInPlay
{
	// this is ghost walls
	if( yPos > (MAX_Y_POS+TILE_SIZE) )
	{
		yPos = 0;
	}
	else if( yPos < 0 )
	{
		yPos = MAX_Y_POS+TILE_SIZE;
	}
	
	if( xPos < 0 )
	{
		xPos = MAX_X_POS+TILE_SIZE;
	}
	else if( xPos > (MAX_X_POS+TILE_SIZE) )
	{
		xPos = 0;
	}
}


- (void)Update
{
	int nArrow = [playerArrows count];
	Arrow *pCurArrow = 0;
	Tile *pCurTile = 0;
	
	if( [self IsPlayerDone] )
		return;
	
	timer++;
	
	if( jumpTimer > 0 )
		jumpTimer--;
	else
		bJumpingActive = false;
	
	// nothing to do until we are back in the game
	if( bRespawnActive )
	{
		[self RespawnCountDown];
		
		if( respawnTimer <= 0 )
		{
			bRespawnPlayer = true;
		}
		return;
	}
	
	// we always check for player "stressed out"
	if( stressMeter >= MAX_METER_VALUE )
	{
		// lose a life and respawn
		bRespawnActive = true;
		respawnTimer = PLAYER_STOP_DURATION[nStopSetting];
	}
	
	[self ClearPowerUpBits];
	
	if( stoppedTimer > 0 )
	{
		stoppedTimer--;
		return;
	}
	
	// we can update these timers if we are not jumping
	if( !bJumpingActive )
	{
		arrowCollisionTimer--;
		animationTimer--;
		
		// update the animation index
		if( animationTimer <= 0 )
		{
			animationTimer = ANIMATION_TIME;
			[self UpdateAnimationIndex];
		}
	}
	
	[self GetCurrentPlayerVelocity];
	
	// move the player around the screen
	xPos += xVel;
	yPos += yVel;
	
	// check for own arrow direction changes
	if( arrowCollisionTimer <= 0 )
	{
		for( int ii = 0; ii < nArrow; ++ii )
		{
			pCurArrow = [playerArrows objectAtIndex:ii];
			
			if( pCurArrow )
			{
				if( [pCurArrow PlayerChanges:self] )
				{
					arrowCollisionTimer = ARROW_COLLISION_TIME;
					xPos = pCurArrow.xPos;
					yPos = pCurArrow.yPos;
					
					// remove if it's an explosive arrow
					if( [pCurArrow GetArrowType] == ARROW_TYPE_EXPLOSIVE )
					{
						// player detonates the bomb
						pCurTile = [pCurArrow GetTileLocation];
						[pCurTile RemoveItemOnTile:ArrowOnTileBit];
						[playerArrows removeObjectAtIndex:ii];
					}
					
					break;
				}
			}
		}
	}
	
	// part of the update is to keep the player in the confines of the screen
	[self KeepInPlay];
}


// this function increments or reverts to the proper index for animation
- (void)UpdateAnimationIndex
{
	if( animationIndex%2 == 0 )
		animationIndex++;
	else
		animationIndex--;
}


- (void) dealloc {
	
	//[texture release];
	for( int ii = 0; ii < MAX_ANIMATION_IMAGES; ++ii )
	{
		if( directions[ii] )
			[directions[ii] release];
	}
	
	if( stressAnimation )
		[stressAnimation release];
	
	[super dealloc];
}


@end
