//
//  PhotoShowRoom.m
//  beto
//
//  Created by Sen on 13-12-2.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#import "PhotoShowRoom.h"


@implementation PhotoShowRoom

-(PhotoShowRoom*) init{
    if (self =[super init]) {
        _storageService = [[LocalStorageService alloc]init];
        [self initDbInfo];
    }
    _countInDb = [self imgCountInDb];
    return (self);
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%d",1] delegate:self cancelButtonTitle:@"" otherButtonTitles:@"", nil] show];
}

-(void) viewDidLoad{
    [[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%d",1] delegate:self cancelButtonTitle:@"" otherButtonTitles:@"", nil] show];
}

-(void) viewWillAppear:(BOOL)animated{
    int c = [self imgCountInDb];
    [[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%d",c] delegate:self cancelButtonTitle:@"" otherButtonTitles:@"", nil] show];
}

-(void) loadPhoto{
//    NSString *querySql = @"select ";
}

-(int) imgCountInDb{
    NSString *countsql = @"select count(1) from beto_img";
    id count = [_storageService executeScalar:countsql :nil];
    return (int)count;
}

-(void) initDbInfo{
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/beto.sqlite"];
    _storageService.path = dbPath;
    _storageService.dbName = @"beto.sqlite";
    
//    NSString *createSql =@"create table if not exists beto_img (img_id integer primary key autoincrement , img_name text , img_image blob)";
//    [_storageService createTable:createSql];
}

-(void) dealloc{
    [_storageService release];
    [_collectView release];
    [super dealloc];
}

@end