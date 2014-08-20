//
//  DRResourceManager.h
//  DREngine
//
//  Created by yan zhang on 10/7/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTexture.h"
#import "DRMesh.h"
#import "DRList.h"
#import "DRListIterator.h"
#import "DRDataHolder.h"

@interface DRResourceManager : NSObject {
@private
	DRList* Textures;
	DRList* Meshes;
}

@property (nonatomic, assign)DRList* Textures;
@property (nonatomic, assign)DRList* Meshes;

+ (DRResourceManager*) CreateInstance;
+ (DRResourceManager*) GetInstance;
+ (void) DeleteInstance;

- (DRResourceManager*) init;
- (void) Destroy;

- (DRTexture*) LoadTexture:(NSString*) resourceName;
- (void) AddMesh:(id) mesh;
- (DRMesh*) GetMesh:(NSString*) name;
- (DRTexture*) GetTexture:(NSString*) name;

@end
