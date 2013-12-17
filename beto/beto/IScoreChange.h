//
//  IScoreChange.h
//  beto
//
//  Created by Sen on 13-12-16.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//
#import <UIKit/Uikit.h>
#import <Foundation/foundation.h>

#ifndef beto_IScoreChange_h
#define beto_IScoreChange_h



#endif
@class ScoreView;
@protocol ScoreViewDelegate <NSObject>

-(void) scoreView:(ScoreView *) scoreView scoreDidChange:(float) score;

@end