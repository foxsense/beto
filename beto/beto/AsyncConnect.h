//
//  AsyncConnect.h
//  beto
//
//  Created by Sen on 13-11-22.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//
#import "Connect.h"

#ifndef beto_AsyncConnect_h
#define beto_AsyncConnect_h



#endif

@interface AsyncConnect : NSObject 

@property (assign) ConnectUtil *util;
@property (assign) NSURL *aurl;
@property (assign,getter = isExecuting) BOOL executing;
@property (assign,getter = isFinished) BOOL finished;
@property (retain) NSError *error;
@property (retain) NSData *data;

-(void) start;

-(void) stop;

+(AsyncConnect*) start:(NSURL*) url;

@end