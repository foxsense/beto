//
//  PhotoShowRoom.h
//  beto
//
//  Created by Sen on 13-12-2.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalStorageService.h"
#import <sqlite3.h>
#ifndef beto_PhotoShowRoom_h
#define beto_PhotoShowRoom_h



#endif

@interface PhotoShowRoom : UIViewController

@property (copy,nonatomic) IBOutlet UICollectionView *collectView;

@property (retain,nonatomic) LocalStorageService *storageService;

@property (assign) NSInteger countInDb;

@end