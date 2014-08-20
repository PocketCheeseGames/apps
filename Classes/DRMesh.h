//
//  DRMesh.h
//  DREngine
//
//  Created by yan zhang on 9/21/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRList.h"
#import "DRRenderEffect.h"

@interface DRMesh : NSObject {
@public
	float*	VertexData;	// Vertext coordinates
	float*	NormalData; // Normal data
	DRList*	UVSets;		// list of UV Data to support multi texturing
	NSString* Name;
	int		NumberOfVertices;
	DRRenderEffect* Effect;
	bool	IsAlpha;
}

@property (nonatomic, assign) float* VertexData;
@property (nonatomic, assign) float* NormalData;
@property (nonatomic, assign) DRList* UVSets;
@property (nonatomic, assign) NSString* Name;
@property (nonatomic, assign) int NumberOfVertices;
@property (nonatomic, assign) DRRenderEffect* Effect;
@property (nonatomic, assign) bool IsAlpha;

- (DRMesh*) init;

@end
