//
//  TableViewDataSource.m
//  beto
//
//  Created by Sen on 13-12-4.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#import "TableViewDataSource.h"

@implementation TableViewDataSource

-(TableViewDataSource *)init{
    if(self = [super init]){
        _list = [[NSArray alloc]initWithObjects: @"aaaa",@"bbbbb",@"ccccc",@"ddddd",nil];
    }
    return self;
}

-(void)dealloc{
    [_list release];
    [super dealloc];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_list count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [_list objectAtIndex:row];
//    cell.imageView.image = [UIImage imageNamed:@"green.png"];
//    cell.detailTextLabel.text = @"详细信息";
//    cell.accessoryType = UITableViewCellSelectionStyleGray;
    return cell;

}

@end