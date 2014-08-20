/*
 *  Hazard.h
 *  DREngine
 *
 *  Created by Rob DelBianco on 12/27/12.
 *  Copyright 2012 Pocket Cheese. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import "DRTexture.h"

// arrow blows up when player crosses
@interface Hazard : NSObject
{
	float	xPos;
	float	yPos;
	DRTexture *pHazardImage;
}

@property(nonatomic, assign) float xPos;
@property(nonatomic, assign) float yPos;

@end