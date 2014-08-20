//
// StoryBoardAhCoolWalk.m
// DREngine
//
// Created by Yan Zhang on 11/2/2009.
// Copyright 2009 Silver Ram Studio.  All rights reserved.


#import "StoryBoardAhCoolWalk.h"


@implementation StoryBoardAhCoolWalk

- (void) Initialize
{
	BeginTime = 0.0416666666666667;
	EndTime = 0.833333333333333;

	DRKeyFrameAnimation* kfa1 = [[DRKeyFrameAnimation alloc] initWithTargetName:@"AhCoolBody" StartTime:0.04166667 EndTime:0.8333333];
	[Animations AddValue:kfa1];
	DRKeyFrame* kf_1_1 = [[DRKeyFrame alloc] initWithTranslationX:0 TranslationY:0.3161403 TranslationZ:0 RotationX:0 RotationY:-0.174532925199433 RotationZ:0 Time:0.04166667];
	[kfa1 AddKeyFrame:kf_1_1];
	DRKeyFrame* kf_1_2 = [[DRKeyFrame alloc] initWithTranslationX:0 TranslationY:0.3161403 TranslationZ:0 RotationX:0 RotationY:0.174532925199433 RotationZ:0 Time:0.4166667];
	[kfa1 AddKeyFrame:kf_1_2];
	DRKeyFrame* kf_1_3 = [[DRKeyFrame alloc] initWithTranslationX:0 TranslationY:0.3161403 TranslationZ:0 RotationX:0 RotationY:-0.174532925199433 RotationZ:0 Time:0.8333333];
	[kfa1 AddKeyFrame:kf_1_3];

	DRKeyFrameAnimation* kfa2 = [[DRKeyFrameAnimation alloc] initWithTargetName:@"FrameAhCoolHead" StartTime:0.04166667 EndTime:0.8333333];
	[Animations AddValue:kfa2];
	DRKeyFrame* kf_2_1 = [[DRKeyFrame alloc] initWithTranslationX:0 TranslationY:0.2735192 TranslationZ:0 RotationX:0.0169727417459953 RotationY:0.173714053098504 RotationZ:0.0978937153835152 Time:0.04166667];
	[kfa2 AddKeyFrame:kf_2_1];
	DRKeyFrame* kf_2_2 = [[DRKeyFrame alloc] initWithTranslationX:0 TranslationY:0.2735192 TranslationZ:0 RotationX:0.0204522594981301 RotationY:-0.173342558771195 RotationZ:-0.118045630647928 Time:0.4166667];
	[kfa2 AddKeyFrame:kf_2_2];
	DRKeyFrame* kf_2_3 = [[DRKeyFrame alloc] initWithTranslationX:0 TranslationY:0.2735192 TranslationZ:0 RotationX:0.0167621033888242 RotationY:0.173734293122789 RotationZ:0.0966751028029654 Time:0.8333333];
	[kfa2 AddKeyFrame:kf_2_3];

	DRKeyFrameAnimation* kfa3 = [[DRKeyFrameAnimation alloc] initWithTargetName:@"AhCoolLeftLeg" StartTime:0.04166667 EndTime:0.8333333];
	[Animations AddValue:kfa3];
	DRKeyFrame* kf_3_1 = [[DRKeyFrame alloc] initWithTranslationX:0.1327348 TranslationY:-0.03341732 TranslationZ:0 RotationX:-0.500764898990987 RotationY:0 RotationZ:0 Time:0.04166667];
	[kfa3 AddKeyFrame:kf_3_1];
	DRKeyFrame* kf_3_2 = [[DRKeyFrame alloc] initWithTranslationX:0.1327348 TranslationY:-0.03341732 TranslationZ:0 RotationX:0.538451990656484 RotationY:0 RotationZ:0 Time:0.4166667];
	[kfa3 AddKeyFrame:kf_3_2];
	DRKeyFrame* kf_3_3 = [[DRKeyFrame alloc] initWithTranslationX:0.1327348 TranslationY:-0.03341732 TranslationZ:0 RotationX:-0.678114649675396 RotationY:0 RotationZ:0 Time:0.8333333];
	[kfa3 AddKeyFrame:kf_3_3];

	DRKeyFrameAnimation* kfa4 = [[DRKeyFrameAnimation alloc] initWithTargetName:@"AhCoolRightArm" StartTime:0.04166667 EndTime:0.8333333];
	[Animations AddValue:kfa4];
	DRKeyFrame* kf_4_1 = [[DRKeyFrame alloc] initWithTranslationX:-0.1760844 TranslationY:0.2748399 TranslationZ:4.237046E-33 RotationX:-0.629697848425538 RotationY:0 RotationZ:-0.619626572131185 Time:0.04166667];
	[kfa4 AddKeyFrame:kf_4_1];
	DRKeyFrame* kf_4_2 = [[DRKeyFrame alloc] initWithTranslationX:-0.1760844 TranslationY:0.2748399 TranslationZ:4.237046E-33 RotationX:0.620394428052482 RotationY:0 RotationZ:-0.619626572131185 Time:0.4166667];
	[kfa4 AddKeyFrame:kf_4_2];
	DRKeyFrame* kf_4_3 = [[DRKeyFrame alloc] initWithTranslationX:-0.1760844 TranslationY:0.2748399 TranslationZ:4.237046E-33 RotationX:-0.589860087732233 RotationY:-2.77555740916751E-17 RotationZ:-0.619626572131185 Time:0.8333333];
	[kfa4 AddKeyFrame:kf_4_3];

	DRKeyFrameAnimation* kfa5 = [[DRKeyFrameAnimation alloc] initWithTargetName:@"AhCoolRightLeg" StartTime:0.04166667 EndTime:0.8333333];
	[Animations AddValue:kfa5];
	DRKeyFrame* kf_5_1 = [[DRKeyFrame alloc] initWithTranslationX:-0.1359499 TranslationY:-0.03298923 TranslationZ:0 RotationX:0.493424461367915 RotationY:0 RotationZ:0 Time:0.04166667];
	[kfa5 AddKeyFrame:kf_5_1];
	DRKeyFrame* kf_5_2 = [[DRKeyFrame alloc] initWithTranslationX:-0.1359499 TranslationY:-0.03298923 TranslationZ:0 RotationX:-0.666746081035039 RotationY:0 RotationZ:0 Time:0.4166667];
	[kfa5 AddKeyFrame:kf_5_2];
	DRKeyFrame* kf_5_3 = [[DRKeyFrame alloc] initWithTranslationX:-0.1359499 TranslationY:-0.03298923 TranslationZ:0 RotationX:0.575824562997243 RotationY:0 RotationZ:0 Time:0.8333333];
	[kfa5 AddKeyFrame:kf_5_3];

	DRKeyFrameAnimation* kfa6 = [[DRKeyFrameAnimation alloc] initWithTargetName:@"AhCoolLeftArm" StartTime:0.04166667 EndTime:0.8333333];
	[Animations AddValue:kfa6];
	DRKeyFrame* kf_6_1 = [[DRKeyFrame alloc] initWithTranslationX:0.1737769 TranslationY:0.2789505 TranslationZ:2.696302E-33 RotationX:0.681236873158378 RotationY:-5.55111518792286E-17 RotationZ:0.73955703839586 Time:0.04166667];
	[kfa6 AddKeyFrame:kf_6_1];
	DRKeyFrame* kf_6_2 = [[DRKeyFrame alloc] initWithTranslationX:0.1737769 TranslationY:0.2789505 TranslationZ:2.696302E-33 RotationX:-0.412204140101492 RotationY:-2.77555740916751E-17 RotationZ:0.73955703839586 Time:0.4166667];
	[kfa6 AddKeyFrame:kf_6_2];
	DRKeyFrame* kf_6_3 = [[DRKeyFrame alloc] initWithTranslationX:0.1737769 TranslationY:0.2789505 TranslationZ:2.696302E-33 RotationX:0.631040148193965 RotationY:2.77555740916751E-17 RotationZ:0.73955703839586 Time:0.8333333];
	[kfa6 AddKeyFrame:kf_6_3];


}

@end
