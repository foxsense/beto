//
//  LocalStroageService.m
//  beto
//
//  Created by Sen on 13-11-24.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#import "LocalStorageService.h"

@implementation LocalStorageService

-(LocalStorageService*) init{
    return self;
}

-(LocalStorageService*) initWithObject:(sqlite3_stmt *) stmt :(sqlite3 *)sqlite{
    self.dbController = sqlite;
    self.stmt = stmt;
    return self;
}

-(void) dealloc{
    [self close];
//    [self.stmt release];
    [self.dbName release];
//    [self.]
    [super dealloc];
}

-(BOOL) createTable:(NSString *)createSql{
    if (![self isOpend]) {
        [self open];
    }
    char *errMsg;
    if(SQLITE_OK == sqlite3_exec(self.dbController, [createSql UTF8String], nil, nil, &errMsg))
        return YES;
    
    NSLog(@"%@",[NSString stringWithUTF8String:errMsg]);
    [self close];
    return NO;
}

-(void) executeNoquery:(NSString *)sql :(NSArray*) params{
    if(![self isOpend]){
        [self open];
    }
    if(sqlite3_prepare_v2(_dbController, [sql UTF8String] , -1, &_stmt, Nil)== SQLITE_OK)
    {
        for (id p in params) {
            [self bindParameter:_stmt :p];
        }
        if (sqlite3_step(_stmt) != SQLITE_DONE)
            NSAssert(0, @"更新数据库表FIELDS出错: ");
        sqlite3_finalize(_stmt);
    }
}

-(id) executeScalar:(NSString *)sql :(NSArray *)params{
    if(![self isOpend]){
        [self open];
    }
    if(sqlite3_prepare_v2(_dbController, [sql UTF8String], -1, &_stmt, Nil) == SQLITE_OK){
        if(params.count >0)
        {
            [self bindParameter:_stmt :params[0]];
        }
//        else
//            return ([NSNull null]);
        if(sqlite3_step(_stmt) == SQLITE_ROW)
        {
//            QParam *obj = params[0];
            id returnObj = (id)sqlite3_column_int(_stmt, 0);
//            [returnObj autorelease];
            return returnObj;
        }
    }
    else
        NSLog(@"%@",@"执行executeScalar 出错");

    return ([NSNull null]);
}

-(void) bindParameter:(sqlite3_stmt *)statement :(QParam *) p{
//    if(p.ctype == typeof(NSString)){
    if (p.index == 1) {
        sqlite3_bind_text(statement, p.index, [p.obj UTF8String], -1, nil);
    }
    if(p.index == 2){
        NSInteger length = [((NSData*)p.obj) length];
        sqlite3_bind_blob(statement, p.index,[((NSData*)p.obj) bytes] , length, nil);
    }
//    if(p.index ==1 ){
//        sqlite3_bind_int(statement,1, 1);
//    }
//    }
}

-(id) execute:(NSString *)sql{
    return nil;
}

-(void) beginTransaction{
    //taskList
}

-(void) commit{
    //flush taskList
}

-(void) rollback{
    
}

-(void) prepare{
    
}

-(void) open{
    if(SQLITE_OK != sqlite3_open([self.path UTF8String], &self->_dbController)){
        sqlite3_close(_dbController);
        [self release];
        _opend = YES;
    }
}

-(void) close{
    if (sqlite3_close(_dbController)==SQLITE_OK) {
        _opend = NO;
    }
}

@end

@implementation QParam


@end
