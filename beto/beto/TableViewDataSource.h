//
//  TableViewDataSource.h
//  beto
//
//  Created by Sen on 13-12-4.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//
#import <UIKIT/UIKIT.h>
#ifndef beto_TableViewDataSource_h
#define beto_TableViewDataSource_h



#endif

@interface TableViewDataSource : NSObject<UITableViewDataSource>

@property (retain) NSArray *list;

- (TableViewDataSource *) init;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end