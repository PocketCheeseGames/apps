//
//  Arrow.m
//  DREngine
//
//  Created by Rob DelBianco on 4/1/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import "ArrowQueue.h"
#import "DREngine.h"
#import "Arrow.h"
#import "NormalArrow.h"
#import "NormalAllArrow.h"
#import "ExplosiveArrow.h"
#import "ShockArrow.h"
#import "SlipperyArrow.h"
#import "StickyArrow.h"
#import "GameDefines.h"
#import "UtilFuncs.h"

#define ARROW_QUE_BOTTOM 460


@implementation ArrowQueue

@synthesize bTimerRanOut;

#define ARROW_DELAY 50
#define DEFAULT_MAX_QUEUE_TIME	300	// normall 3 seconds


- (ArrowQueue*)initArrowQueue:(int)plr
{
	self = [super init];
	int nDirection = 0;
	nPlayerType = plr;
	pArrowQueue = [[NSMutableArray alloc] init ];
	Arrow	*pNewArrow = 0;
	nMaxQueueTime = DEFAULT_MAX_QUEUE_TIME;
	nCurrentArrowIndex = NO_TILE_SELECTED;
	bTimerRanOut = false;
	nQueueTimer = nMaxQueueTime;
	pSelectedArrow = 0;
	bPlayersTurn = true;
	uf = [Utils GetInstance];
	
	// 0 is the arrow queue timer
	
	// create a queue of arrow tiles for the user to click on
	for( int ii = 1; ii < MAX_ROWS; ++ii )
	{
		nDirection = [uf GetRandomNumber:1 :4];
		pNewArrow = [[NormalArrow alloc] InitArrow:nDirection:nPlayerType];
		pNewArrow.xPos = ii*TILE_SIZE+HALF_TILE;
		pNewArrow.yPos = ARROW_QUE_BOTTOM;
		[pArrowQueue addObject:pNewArrow];
		[pNewArrow release];
	}
	
	pSelectedArrow = [[DRResourceManager GetInstance] LoadTexture:@"ArrowOwner.png"];
	
	return self;
}


- (void)AddNewArrowToQueue:(float)_xPos
{
	uf = [Utils GetInstance];
	int nDirection = [uf GetRandomNumber:1 :4];
	int nType = [uf GetRandomNumber:1:10];
	Arrow	*pNewArrow = 0;
	
	switch( nType )
	{
		case ARROW_TYPE_EXPLOSIVE:
			pNewArrow = [[ExplosiveArrow alloc] InitArrow:nDirection:nPlayerType];
			break;
		case ARROW_TYPE_SHOCK:
			pNewArrow = [[ShockArrow alloc] InitArrow:nDirection:nPlayerType];
			break;
		case ARROW_TYPE_SLIPPERY:
			pNewArrow = [[SlipperyArrow alloc] InitArrow:nDirection:nPlayerType];
			break;
		case ARROW_TYPE_STICKY:
			pNewArrow = [[StickyArrow alloc] InitArrow:nDirection:nPlayerType];
			break;
		case ARROW_TYPE_NORMAL_ALL:
			pNewArrow = [[NormalAllArrow alloc] InitNormalAllArrow:nDirection :nPlayerType];
			break;
		default:
			pNewArrow = [[NormalArrow alloc] InitArrow:nDirection:nPlayerType];
			
	}
	
	pNewArrow.xPos = _xPos;
	pNewArrow.yPos = ARROW_QUE_BOTTOM;
	[pArrowQueue addObject:pNewArrow];
	[pNewArrow release];
}


//- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue
//{
//	return (arc4random() % (nHighValue-nLowRange+1)+nLowRange);
//}

- (void) DrawArrowQueue
{
	Arrow *pCurArrow = 0;
	float alphaBlend = 1.0f;
	int ii = 0;// our loop counter
	int nArrows = [pArrowQueue count];
	uf = [Utils GetInstance];
	
	if( !bPlayersTurn )
		alphaBlend = .5f;
	
	// loop through our tiles in the arrow queue
	for( ii = 0 ; ii < nArrows; ++ii )
	{
		pCurArrow = [pArrowQueue objectAtIndex:ii];
		
		if( pSelectedArrow )
		{
			if( ii == nCurrentArrowIndex )
				[pSelectedArrow BlitTranslateX:pCurArrow.xPos TranslateY:pCurArrow.yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:0.0f Green:1.0f Blue:0.0f Alpha:1.0f];
			else
				[pSelectedArrow BlitTranslateX:pCurArrow.xPos TranslateY:pCurArrow.yPos Rotate:0.0f ScaleX:TILE_SIZE ScaleY:(TILE_SIZE*-1) Red:0.0f Green:0.0f Blue:1.0f Alpha:1.0f];
		}
		
		[pCurArrow DrawArrow:alphaBlend];
	}
	
	[uf DrawNumber:(nQueueTimer/75) :15.0f :ARROW_QUE_BOTTOM :TILE_SIZE*2 :TILE_SIZE*2 :0.0f :1.0f :0.0f :1.0f];
}

// an update function, mainly for our arrow queue timer
- (void) UpdateArrowQueue
{
	// update our timer
	nQueueTimer--;
	
	if( nQueueTimer <= 0 )
	{
		bTimerRanOut = true;
	}
}

// reset our arrow queue timer
// either new turn or they placed an 
// arrow tile on the board
- (void) ResetArrowQueueTimer
{
	nQueueTimer = nMaxQueueTime;
	bTimerRanOut = false;
}


- (void) StopArrowQueueTimer
{
	nQueueTimer = 0;
	bTimerRanOut = false;
}

-(void) RemoveSelectedArrow
{
	[pArrowQueue removeObjectAtIndex:nCurrentArrowIndex];
	nCurrentArrowIndex = NO_TILE_SELECTED;
}

- (void) ArrowClicked:(float)xClick
					 :(float)yClick
{
	int		nArrows = [pArrowQueue count];
	Arrow	*pCurArrow;
	
	if( bTimerRanOut )
		return;
	
	// find out if they clicked on the arrow queue
	for( int ii = 0; ii < nArrows; ++ii )
	{
		pCurArrow = [pArrowQueue objectAtIndex:ii];
		
		if( xClick < pCurArrow.xPos )
			continue;
		if( xClick > (pCurArrow.xPos+TILE_SIZE))
			continue;
		if( yClick < pCurArrow.yPos )
			continue;
		if( yClick > (pCurArrow.yPos+TILE_SIZE))
			continue;
		
		// de-select the current tile
		if( nCurrentArrowIndex == ii ||
		   [pCurArrow GetArrowType] == ARROW_TYPE_UNKNOWN)
		{
			nCurrentArrowIndex = NO_TILE_SELECTED;
		}
		else
		{
			nCurrentArrowIndex = ii;
		}
				
		break;
	}
}

// return the selected arrow in the queue
// calling function must check for null
- (Arrow*)GetCurrentSelectedArrow
{
	Arrow *pCurArrow = 0;
	
	if( nCurrentArrowIndex != NO_TILE_SELECTED )
		pCurArrow = [pArrowQueue objectAtIndex:nCurrentArrowIndex];
	
	return pCurArrow;
}


// the player tried placing a tile on a
// game board tile that is not changable
- (void)BlockCurrentSelectedTile:(float)_oldXPos
{
	Arrow *pBad = [[Arrow alloc] InitArrow:0:nPlayerType];
	
	[pBad LoadBadArrowImage:_oldXPos];
	[pArrowQueue addObject:pBad];
	[pBad release];
}


// our shutdown process
- (BOOL) ShutdownArrowQueue
{ 
	BOOL bRet = TRUE;
	
	if( pArrowQueue )
		[pArrowQueue release];
	
	return bRet;
}


- (void) dealloc {
	
	[super dealloc];
}



@end
