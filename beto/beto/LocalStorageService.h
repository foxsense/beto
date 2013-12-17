//
//  LocalSotrageService.h
//  beto
//
//  Created by Sen on 13-11-24.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#import <sqlite3.h>
#import <Foundation/Foundation.h>
#import "IQueryParameter.h"
#import "IDataRow.h"

#ifndef beto_LocalSotrageService_h
#define beto_LocalSotrageService_h



#endif

@interface QueryParameterArray : NSArray

@property (retain) NSObject<IQueryParameter> * params;

@end

@interface DataRow : NSObject<IDataRow>

@end


@interface QParam : NSObject

@property (retain) id obj;

@property (retain) Class ctype;

@property (assign) NSInteger index;

@property (retain) NSString *colName;

@end


@interface LocalStorageService : NSObject

@property (atomic) sqlite3 *dbController;

@property (atomic) sqlite3_stmt *stmt;

@property (copy,nonatomic,getter = dbName) NSString *dbName;

@property (copy) NSString *path;

@property (assign,getter = isOpend) BOOL opend;

-(LocalStorageService*) initWithObject:(sqlite3_stmt *) stmt :(sqlite3 *)sqlite;

-(id) execute:(NSString *) sql;

-(void) beginTransaction;

-(void) commit;

-(void) rollback;

-(void) prepare;

-(BOOL) createTable:(NSString *)createSql;

-(void) executeNoquery:(NSString *)sql :(NSArray *) params;

-(id) executeScalar:(NSString *) sql :(NSArray *) params;

-(DataRow*) executeQuery:(NSString *)sql :(NSArray *) params;

-(void) close;

@end


