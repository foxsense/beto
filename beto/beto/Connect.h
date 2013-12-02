//
//  Connect.h
//  beto
//
//  Created by Sen on 13-11-19.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef beto_Connect_h
#define beto_Connect_h



#endif
typedef enum{
    POSTRequest,
    GETREquest
} HTTPRequestType;



@interface ConnectUtil : NSObject<NSURLConnectionDataDelegate>

@property (retain) NSURLConnection *conn;

@property (retain) NSMutableData *receivedData;

@property (assign,getter = isFinished) BOOL finished;

@property (assign) HTTPRequestType requestType;

@property(assign) NSInteger count;

-(BOOL) createConnection:(NSURL*) url;

-(BOOL) sendRequest;

-(BOOL) cancelRequest;

-(id) receiveData;

@end