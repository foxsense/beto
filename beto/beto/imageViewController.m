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

//@synthesize isDbMode = _isDbMode;
-(imageViewController*) init{
    [super init];
    self.address = [NSMutableArray arrayWithObjects: @"http://b.hiphotos.baidu.com/image/w%3D2048/sign=353192aca6c27d1ea5263cc42fedad6e/024f78f0f736afc3983f1f6db119ebc4b7451282.jpg",@"http://c.hiphotos.baidu.com/image/w%3D2048/sign=0950f78e2fdda3cc0be4bf2035d13801/5d6034a85edf8db1897512750823dd54564e7443.jpg",@"http://b.hiphotos.baidu.com/image/w%3D2048/sign=4add5f8a5bafa40f3cc6c9dd9f5c024f/a08b87d6277f9e2f3e25f5b01e30e924b899f372.jpg",@"http://h.hiphotos.baidu.com/image/w%3D2048/sign=4c05b00c69600c33f079d9c82e74500f/a044ad345982b2b7f7c44adc33adcbef76099b4a.jpg", nil];
    self.imgCounts = self.address.count;
    self.imgIdx = 0;
    _dbMode = NO;
    _storageService = [[LocalStorageService alloc] init];
    return self;
}

-(imageViewController *) initWithSqlite:(NSString *) dbName{
    if(self = [super init])
    {
        self.address = nil;
        _storageService = [[LocalStorageService alloc] init];
        _dbMode = YES;
//        [self initDbInfo];
    }
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

-(void) imgAnimation:(UISwipeGestureRecognizer *) sender{
//    CGRect imgPos = _imgView.frame;
//    _imgView animationDidStart:
//    imgPos.origin.x = imgPos.origin.x + 50;
    
//    [_imgView setFrame:imgPos];
    
}

-(void) swipHandle:(UISwipeGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateRecognized || sender.state == UIGestureRecognizerStateChanged) {
        [self imgAnimation:sender];
    }
    if (sender.state == UIGestureRecognizerStateRecognized) {
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
    if(!self.isDbMode)
    {
        self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(requerstImg:) object:self.address[idx]];
        [self.thread start];
    }
    else
    {
        [self loadImage];
    }
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
//    [_storageService ]
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
    UIImage *img = nil;
    if(!self.isDbMode)
    {
        img = [[UIImage alloc] initWithData:self.util.receivedData];
    }
    else
    {
        img = [[UIImage alloc] initWithData:[self loadImageFromDb:_imgIdx]];
    }
    [img resizingMode];
    [self.imgView.image release];
    [_imgView setContentMode:UIViewContentModeScaleAspectFit];
//    [self.imgView release];
    [self.imgView setImage:img];
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"moveIn"];// rippleEffect
    [animation setSubtype:kCATransitionFromLeft];
    [_imgView.layer addAnimation:animation forKey:nil];
    
    CGRect rect = _imgView.frame;
//    rect.size.height = 200+rand() % 300;
//    rect.size.width = 200+rand() % 300;
    [_imgView setFrame:rect];
}


-(NSData *) loadImageFromDb:(NSInteger) idx{
    NSData *data = nil;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *sql = @"select img_id, img_name ,img_image from beto_img where img_id = ?";
    NSMutableArray *params = [[NSMutableArray alloc]init];
    QParam *p = [[QParam alloc] init];
    p.index = 3;
    p.colName = @"img_id";
    p.obj = [NSString stringWithFormat:@"%ld",(_imgIdx + 1) ];
    [params addObject:p];
    DataRow *row = [_storageService executeQuery:sql :params];
    NSArray *results = row.result;
    
    data = (NSData*)results[2];
    [pool release];
    [data autorelease];
    return data;
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