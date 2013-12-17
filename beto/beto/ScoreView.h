//
//  ScoreView.h
//  beto
//
//  Created by Sen on 13-12-16.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "IScoreChange.h"

#ifndef beto_ScoreView_h
#define beto_ScoreView_h



#endif

@interface ScoreView : UIView

@property (assign,nonatomic) int maxScore;
@property (assign,nonatomic) float score;
@property (assign) BOOL canModify;
@property (retain,nonatomic) UIImage *selectedImage;
@property (retain,nonatomic) UIImage *halfSelectedImage;
@property (retain,nonatomic) UIImage *nonSelectedImage;
@property (retain) NSMutableArray *imageViews;
@property (retain) id<ScoreViewDelegate> delegate;

@end