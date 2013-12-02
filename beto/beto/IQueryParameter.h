//
//  IQueryParameter.h
//  beto
//
//  Created by Sen on 13-11-27.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef beto_IQueryParameter_h
#define beto_IQueryParameter_h



#endif
@protocol IQueryParameter <NSObject>

@property (retain) id obj;

@property (retain) Class type;

@property (assign) NSInteger index;

@property (retain) NSString *colName;

@end