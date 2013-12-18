//
//  imageViewController.h
//  beto
//
//  Created by Sen on 13-11-20.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#ifndef beto_imageViewController_h
#define beto_imageViewController_h



#endif
#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "LocalStorageService.h"
#import "Connect.h"
#import "ScoreView.h"
#import "IScoreChange.h"

@interface imageViewController : UIViewController<ScoreViewDelegate>

@property (nonatomic,retain)IBOutlet UIImageView *imgView;

@property (retain, nonatomic) IBOutlet ScoreView *scoreView;

@property (nonatomic,retain) ConnectUtil *util;

@property (retain) LocalStorageService *storageService;

@property (retain) NSString *dbPath;

@property (retain) NSThread *thread;

@property (retain) NSMutableArray *address;

@property (assign) NSInteger imgIdx;

@property (assign) NSInteger imgCounts;

@property (assign,getter = isDbMode) BOOL dbMode;

-(imageViewController *) initWithSqlite:(NSString *) dbName;

@end