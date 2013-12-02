//
//  AsyncConnect.m
//  beto
//
//  Created by Sen on 13-11-22.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#import "AsyncConnect.h"

@implementation AsyncConnect

-(AsyncConnect*) initWithURL:(NSURL*) url{
    self.util = [[ConnectUtil alloc] init];
    self.executing = NO;
    self.finished = NO;
    self.data = self.util.receivedData;
    return self;
}

-(void) start{
}

-(void) stop{
    
}

+(AsyncConnect*) start:(NSURL *)url{
    AsyncConnect *result = [[AsyncConnect alloc] initWithURL:url];
    [result start];
    return result;
}

@end