//
//  Arrow.h
//  DREngine
//
//  Created by Rob DelBianco on 4/1/12.
//  Copyright 2012 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTexture.h"
#import "Arrow.h"


@interface ArrowQueue : NSObject {

	NSMutableArray *pArrowQueue;
	int nPlayerType;
	int nMaxQueueTime;
	int nQueueTimer;
	int nCurrentArrowIndex;
	bool	bTimerRanOut;
	bool	bPlayersTurn;
	DRTexture *pSelectedArrow;
	Utils	*uf;
}

- (ArrowQueue*)initArrowQueue:(int)plr;
- (BOOL) ShutdownArrowQueue;

- (void) DrawArrowQueue;

- (void)UpdateArrowQueue;

- (void) ArrowClicked:(float)xClick
					 :(float)yClick;

- (void)AddNewArrowToQueue:(float)_xPos;

//- (int)GetRandomNumber:(int)nLowRange:(int)nHighValue;

- (Arrow*)GetCurrentSelectedArrow;
-(void) RemoveSelectedArrow;

- (void)BlockCurrentSelectedTile:(float)_oldXPos;

- (void) ResetArrowQueueTimer;
- (void) StopArrowQueueTimer;

//@property(nonatomic, assign) int nMaxQueueTime;
//@property(nonatomic, assign) int nCurrentArrowIndex;
@property(nonatomic, assign) bool bTimerRanOut;


@end
