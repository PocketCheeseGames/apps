//
//  GameSettings.h
//  DREngine
//
//  Created by Rob DelBianco on 2/24/13.
//  Copyright 2013 Pocket Cheese. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameSettings : NSObject {

}

- (GameSettings*) Init;
+ (GameSettings*) CreateInstance;
+ (GameSettings*) GetInstance;
+ (void) DeleteInstance;


@end

