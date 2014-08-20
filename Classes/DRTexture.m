//
//  DRTexture.m
//  Draco Engine
//
//  Created by yan zhang on 5/18/09.
//  Copyright 2009 Silver Ram Studio. All rights reserved.
//

#import "DRRenderManager.h"
#import "DRTexture.h"

// Sets up an array of values to use as the sprite vertices.
const GLfloat spriteVertices[] = {
-0.5f, -0.5f,
0.5f, -0.5f,
-0.5f,  0.5f,
0.5f,  0.5f,
};

// Sets up an array of values for the texture coordinates.
const GLfloat spriteTexcoords[] = {
0.0f, 0.0f,
1.0f, 0.0f,
0.0f, 1.0f,
1.0f, 1.0f,
};

@implementation DRTexture

@synthesize Name;

- (void) Bind
{
	if ([DRRenderManager GetInstance].CurBoundTexture != _textureID)
	{
		glBindTexture(GL_TEXTURE_2D, _textureID);
		[DRRenderManager GetInstance].CurBoundTexture = _textureID;
	}
}
- (void) BlitTranslateX:(float) fTranslateX TranslateY:(float) fTranslateY Rotate:(float) fRotation ScaleX:(float) fScaleX ScaleY:(float) fScaleY 
					Red:(float) fRed Green:(float) fGreen Blue:(float) fBlue Alpha:(float) fAlpha
{
	glPushMatrix();
	
	glTranslatef(fTranslateX, fTranslateY, 0.0f);
	
	glRotatef(fRotation, 0.0f, 0.0f, 1.0f);	
	
	glScalef(fScaleX, fScaleY, 1.0f);
	
	glColor4f(fRed, fGreen, fBlue, fAlpha);
	
	// Bind the texture name. 
	glBindTexture(GL_TEXTURE_2D, _textureID);
	
	// Sets up pointers and enables states needed for using vertex arrays and textures
	glVertexPointer(2, GL_FLOAT, 0, spriteVertices);
	glTexCoordPointer(2, GL_FLOAT, 0, spriteTexcoords);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	glPopMatrix();
}
- (void) BlitTranslateX:(float)fTranslateX TranslateY:(float)fTranslateY Rotate:(float)fRotation ScaleX:(float)fScaleX ScaleY:(float)fScaleY 
					Red:(float)fRed Green:(float)fGreen Blue:(float)fBlue Alpha:(float)fAlpha 
				   TexX:(float)fTX TexY:(float)fTY TexSX:(float)fSX TexSY:(float)fSY
{
	glPushMatrix();
	
	glTranslatef(fTranslateX, fTranslateY, 0.0f);
	
	glRotatef(fRotation, 0.0f, 0.0f, 1.0f);	
	
	glScalef(fScaleX, fScaleY, 1.0f);
	
	glColor4f(fRed, fGreen, fBlue, fAlpha);
	
	// Bind the texture name. 
	glBindTexture(GL_TEXTURE_2D, _textureID);
	
	glMatrixMode(GL_TEXTURE);
	glPushMatrix();
	glTranslatef(fTX, fTY, 0.0f);
	glScalef(fSX, fSY, 1.0f);
	
	// Sets up pointers and enables states needed for using vertex arrays and textures
	glVertexPointer(2, GL_FLOAT, 0, spriteVertices);
	glTexCoordPointer(2, GL_FLOAT, 0, spriteTexcoords);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	glPopMatrix();
	glMatrixMode(GL_MODELVIEW);
	
	glPopMatrix();
}

- (void) BlitTranslateX:(float) fTranslateX TranslateY:(float) fTranslateY Rotate:(float) fRotation ScaleX:(float) fScaleX ScaleY:(float) fScaleY
{
	glPushMatrix();
	
	glTranslatef(fTranslateX, fTranslateY, 0.0f);
	
	glRotatef(fRotation, 0.0f, 0.0f, 1.0f);	
	
	glScalef(fScaleX, fScaleY, 1.0f);
	
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	
	// Bind the texture name. 
	glBindTexture(GL_TEXTURE_2D, _textureID);
	
	// Sets up pointers and enables states needed for using vertex arrays and textures
	glVertexPointer(2, GL_FLOAT, 0, spriteVertices);
	glTexCoordPointer(2, GL_FLOAT, 0, spriteTexcoords);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	glPopMatrix();
}

- (void) BlitTranslateX:(float) fTranslateX TranslateY:(float) fTranslateY Rotate:(float) fRotation
{
	glPushMatrix();
	
	glTranslatef(fTranslateX, fTranslateY, 0.0f);
	
	glRotatef(fRotation, 0.0f, 0.0f, 1.0f);	
	
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	
	// Bind the texture name. 
	glBindTexture(GL_TEXTURE_2D, _textureID);
	
	// Sets up pointers and enables states needed for using vertex arrays and textures
	glVertexPointer(2, GL_FLOAT, 0, spriteVertices);
	glTexCoordPointer(2, GL_FLOAT, 0, spriteTexcoords);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	glPopMatrix();
}

- (id) InitWithResourceName:(NSString*) szResourceName
{
	CGImageRef spriteImage;
	CGContextRef spriteContext;
	GLubyte *spriteData;
	size_t	width, height;
	
	Name = szResourceName;
	
	// Creates a Core Graphics image from an image file
	spriteImage = [UIImage imageNamed:szResourceName].CGImage;
	// Get the width and height of the image
	width = CGImageGetWidth(spriteImage);
	height = CGImageGetHeight(spriteImage);
	// Texture dimensions must be a power of 2. If you write an application that allows users to supply an image,
	// you'll want to add code that checks the dimensions and takes appropriate action if they are not a power of 2.
	
	if(spriteImage) {		
		// Allocated memory needed for the bitmap context
		spriteData = (GLubyte *) malloc(width * height * 4);
		// Uses the bitmatp creation function provided by the Core Graphics framework. 
		spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width * 4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
		
		// Flip the texture so that it doesn't load upside down
		CGContextTranslateCTM(spriteContext, 0, height);
		CGContextScaleCTM(spriteContext, 1.0, -1.0);
		
		// After you create the context, you can draw the sprite image to the context.
		CGContextDrawImage(spriteContext, CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height), spriteImage);
		// You don't need the context at this point, so you need to release it to avoid memory leaks.
		CGContextRelease(spriteContext);
		
		// Use OpenGL ES to generate a name for the texture.
		glGenTextures(1, &_textureID);
		// Bind the texture name. 
		glBindTexture(GL_TEXTURE_2D, _textureID);
		// Speidfy a 2D texture image, provideing the a pointer to the image data in memory
		 glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
		 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		// Release the image data
		free(spriteData);
	}
	
	[szResourceName release];
	
	return self;
}

- (void) dealloc
{
	glDeleteTextures(1, &_textureID);
	
	[Name release];
	
	[super dealloc];
}

@end
