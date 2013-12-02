//
//  imageViewController.m
//  beto
//
//  Created by Sen on 13-11-20.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#import "imageViewController.h"
#import "Connect.h"


@implementation imageViewController

-(imageViewController*) init{
    [super init];
    self.address = [NSMutableArray arrayWithObjects: @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=cfe9bc1480cb39dbc1c06056e42e0824/b64543a98226cffc0c3a674cb8014a90f603ea38.jpg",@"http://h.hiphotos.baidu.com/image/w%3D1366%3Bcrop%3D0%2C0%2C1366%2C768/sign=5094c8be442309f7e76fa91144383790/728da9773912b31baf8f10038418367adab4e13d.jpg",@"http://c.hiphotos.baidu.com/image/w%3D2048/sign=1e594201d31b0ef46ce89f5ee9fc50da/f636afc379310a550982d4dbb64543a98226107e.jpg", nil];
    self.imgCounts = self.address.count;
    self.imgIdx = 0;
    _storageService = [[LocalStorageService alloc] init];
    return self;
}

-(void) dealloc{
    [self.thread release];
    [self.util release];
    [self.address release];
    [self.dbPath release];
    [super dealloc];
}

-(void) pinchHandle:(UIPinchGestureRecognizer *)sender{
    [[[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"" otherButtonTitles:@"", nil] show];
}

-(void) tapHandle:(UITapGestureRecognizer *)sender{
    [self changeImg];
}

-(void) swipHandle:(UISwipeGestureRecognizer *)sender{
    if(sender.direction == UISwipeGestureRecognizerDirectionLeft){
        if(self.imgIdx == 0){
            self.imgIdx = self.imgCounts - 1;
        }
        else
            self.imgIdx --;
    }
    if(sender.direction == UISwipeGestureRecognizerDirectionRight){
        if(self.imgIdx >= self.imgCounts-1){
            self.imgIdx = 0;
        }
        else
            self.imgIdx++;
    }
    [self showImg:self.imgIdx];
}

-(void) viewWillAppear:(BOOL)animated{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.imgView addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchHandle:)];
    [self.imgView addGestureRecognizer:pinchGesture];
    [pinchGesture release];
    
    UISwipeGestureRecognizer *swipGasture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipHandle:)];
    [self.imgView addGestureRecognizer:swipGasture];
    [swipGasture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipGasture release];
    
    swipGasture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipHandle:)];
    [self.imgView addGestureRecognizer:swipGasture];
    [swipGasture setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipGasture release];

    
    
    [self.imgView setUserInteractionEnabled:YES];
}

-(void) showImg:(NSInteger) idx{
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(requerstImg:) object:self.address[idx]];
    [self.thread start];

}

-(void) viewDidAppear:(BOOL)animated{
    [self showImg:self.imgIdx];
}

-(void) initAddress:(NSMutableArray *) obj{
    [self.address initWithArray:obj];
}
//localstorage
//animation
//thumb
//savedphoto
//messagepush

-(void) viewdidload{
    
}

-(void) requerstImg:(NSString *) urlString{
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    self.util = [[ConnectUtil alloc] init];
    [self.util createConnection:[[NSURL alloc] initWithString:urlString]];
    [self.util sendRequest];
    
    [pool release];
    
    while (![self.util isFinished]) {
        NSAutoreleasePool *pool =[[NSAutoreleasePool alloc]init];
        [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [pool release];
    }
    
    [self performSelectorOnMainThread:@selector(loadImage) withObject:self waitUntilDone:YES];
}

- (IBAction)tap:(id)sender {
    [self initDbInfo];
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString * insertSql = @"insert or replace into beto_img (img_name , img_image) values (?,?);";
    QParam *p = [[QParam alloc] init];
    p.index = 1;
//    p.ctype = @""
    p.obj = [@"image" stringByAppendingString:[NSString stringWithFormat:@"%d", _imgIdx]] ;
    p.colName = @"img_name";
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    [arr addObject:p];
    QParam *p1 = [[QParam alloc] init];
    p1.index = 2;
    p1.colName = @"img_image";
    NSData *data = UIImageJPEGRepresentation(_imgView.image, 1);
    p1.obj = data;
    [arr addObject:p1];
    
//    p = [[QParam alloc] init];
//    p.index = 1;
//    p.colName = @"img_id";
//    p.obj = (id)1;
//    [arr addObject:p];
    [_storageService executeNoquery:insertSql :arr];
    [pool release];
}

-(void) changeImg{
    if(self.imgIdx+1 >= self.imgCounts){
        self.imgIdx =0;
    }
    else
        self.imgIdx++;
    [self showImg:self.imgIdx];
}

-(void) loadImage{
    UIImage *img =[[UIImage alloc] initWithData:self.util.receivedData];
    [img resizingMode];
    
    self.imgView.image =img;
}

-(void) initDbInfo{
    _dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/beto.sqlite"];
    _storageService.path = _dbPath;
    _storageService.dbName = @"beto.sqlite";
    
    NSString *createSql =@"create table if not exists beto_img (img_id integer primary key autoincrement , img_name text , img_image blob)";
    [_storageService createTable:createSql];
}

-(void) temp{
    
}

@end