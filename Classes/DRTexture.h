//
//  DRTexture.h
//  Draco Engine
//
//  Created by yan zhang on 5/18/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#ifndef	_DRTEXTURE_H_
#define _DRTEXTURE_H_

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface DRTexture : NSObject {
@private
	GLuint _textureID;
	NSString* Name;
}

@property (nonatomic, assign) NSString* Name;

- (id)InitWithResourceName:(NSString*)szResourceName;
- (void) Bind;
- (void) BlitTranslateX:(float)fTranslateX TranslateY:(float)fTranslateY Rotate:(float)fRotation ScaleX:(float)fScaleX ScaleY:(float)fScaleY 
					Red:(float)fRed Green:(float)fGreen Blue:(float)fBlue Alpha:(float)fAlpha;
- (void) BlitTranslateX:(float)fTranslateX TranslateY:(float)fTranslateY Rotate:(float)fRotation ScaleX:(float)fScaleX ScaleY:(float)fScaleY;
- (void) BlitTranslateX:(float)fTranslateX TranslateY:(float)fTranslateY Rotate:(float)fRotation;
- (void) BlitTranslateX:(float)fTranslateX TranslateY:(float)fTranslateY Rotate:(float)fRotation ScaleX:(float)fScaleX ScaleY:(float)fScaleY 
					Red:(float)fRed Green:(float)fGreen Blue:(float)fBlue Alpha:(float)fAlpha 
				   TexX:(float)fTX TexY:(float)fTY TexSX:(float)fSX TexSY:(float)fSY;

@end

#endif
