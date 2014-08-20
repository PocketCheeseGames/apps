//
//  UtilFuncs.h
//  DREngine
//
//  Created by Rob DelBianco on 2/24/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTexture.h"


@interface Utils : NSObject {
	
	DRTexture	*pNumbers[9]; // I need a 0 value....

}

- (Utils*) Init;
+ (Utils*) CreateInstance;
+ (Utils*) GetInstance;
+ (void) DeleteInstance;

- (void) DrawNumber:(int)numToDraw
				   :(float)xLoc
				   :(float)yLoc
				   :(float)xScale
				   :(float)yScale
				   :(float)red
				   :(float)green
				   :(float)blue
				   :(float)alpha;


- (int) GetRandomNumber:(int)nLowRange:(int)nHighRange;

- (bool) isCollision:(float)x1
					:(float)y1
					:(float)x2
					:(float)y2
					:(float)offset;

- (bool) IsBitSet:(unsigned int) AllBits:(unsigned int) BitToCheck;

- (unsigned int) SetBit:(unsigned int) AllBits:(unsigned int) BitToSet;

- (unsigned int) ClearBit:(unsigned int) AllBits:(unsigned int) BitToClear;

- (unsigned int) ToggleBit:(unsigned int) AllBits:(unsigned int) BitToToggle;

- (float) GetVelocityOffset:(float)xV:(float)yV;

- (float) GetPlayerRedValue:(int)index;
- (float) GetPlayerBlueValue:(int)index;
- (float) GetPlayerGreenValue:(int)index;

@end

