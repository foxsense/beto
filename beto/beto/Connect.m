//
//  Connect.m
//  beto
//
//  Created by Sen on 13-11-19.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#import "Connect.h"

@implementation ConnectUtil

-(ConnectUtil *) init{
    self.receivedData = [[NSMutableData alloc] init];
    self.requestType = GETREquest;
    self.count = 0;
    return self;
}

-(BOOL) createConnection:(NSURL*) url{

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    self.conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    self.count++;
    return YES;
}

-(BOOL) sendRequest{
    if (self.conn) {
        [self.conn start];
        return YES;
    }
    return NO;
}

-(BOOL) cancelRequest{
    if (self.conn) {
        [self.conn cancel];
        return YES;
    }
    return NO;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.receivedData appendData:data];
    self.count++;

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error");
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.finished  = NO;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.finished = YES;
}

-(id) receiveData{
    return self.receivedData;
}

-(void) dealloc{
    self.conn = nil;
    self.receivedData  = nil;
    [super dealloc];
}
@end