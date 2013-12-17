//
//  IDataRow.h
//  beto
//
//  Created by Sen on 13-12-3.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//
#import <sqlite3.h>
#import <Foundation/foundation.h>
#ifndef beto_IDataRow_h
#define beto_IDataRow_h



#endif

@protocol  IDataRow <NSObject>

@property (atomic) sqlite3_stmt *stmt;

@property (retain,atomic) NSMutableArray *result;

@property (retain,atomic) NSMutableDictionary *indexColNameDict;

@end
