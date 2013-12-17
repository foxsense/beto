//
//  ScoreView.m
//  beto
//
//  Created by Sen on 13-12-16.
//  Copyright (c) 2013年 Sen.edu. All rights reserved.
//

#import "ScoreView.h"

@implementation ScoreView

#pragma mark init dealloc
@synthesize maxScore = _maxScore;
@synthesize score = _score;
@synthesize halfSelectedImage = _halfSelectedImage;
@synthesize selectedImage = _selectedImage;
@synthesize nonSelectedImage = _nonSelectedImage;
-(void) initProperty{
    _canModify = YES;
    _maxScore = 5;
    _score = 0;
    _nonSelectedImage = nil;
    _selectedImage = nil;
    _halfSelectedImage = nil;
    _delegate = nil;
    _imageViews = [[NSMutableArray alloc]init];
}


-(id) initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initProperty];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initProperty];
    }
    return self;
}

-(void)dealloc{
    [_nonSelectedImage release];
    [_selectedImage release];
    [_halfSelectedImage release];
    [_imageViews release];
    [super dealloc];
}

#pragma mark 

-(void) refresh{
    for(int i = 0; i < self.imageViews.count; ++i) {
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        if (_score >= i+1) {
            imageView.image = _selectedImage;
        } else if (_score > i) {
            imageView.image = _halfSelectedImage;
        } else {
            imageView.image = _nonSelectedImage;
        }
    }
}

-(void) layoutSubviews{
    [super layoutSubviews];
    if (_nonSelectedImage == nil) {
        return;
    }
    int imgWidth = 10;
    int imgHeight = 10;
    for (int i =0 ; i < _imageViews.count; i++) {
        UIImageView *views = [_imageViews objectAtIndex:i];
        CGRect frame = CGRectMake(5 + i* (5+ imgWidth), 0, imgWidth, imgHeight);
        views.frame = frame;
    }
}

-(void) setMaxScore:(int)maxScore{
    _maxScore = maxScore;
    for (int i=0; i < _imageViews.count; i++) {
        UIImageView *imageView = [_imageViews objectAtIndex:i];
        [imageView removeFromSuperview];
    }
    [_imageViews removeAllObjects];
    
    for (int i = 0 ; i<maxScore ; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_imageViews addObject:imageView];
        [self addSubview:imageView];
    }
    
    [self setNeedsLayout];
    [self refresh];
}

-(void) setScore:(float)score{
    _score = score;
    [self refresh];
}

-(void) setNonSelectedImage:(UIImage *)nonSelectedImage{
    _nonSelectedImage = nonSelectedImage;
    [self refresh];
}

-(void) setHalfSelectedImage:(UIImage *)halfSelectedImage{
    _halfSelectedImage =halfSelectedImage;
    [self refresh];
}

-(void) setSelectedImage:(UIImage *)selectedImage{
    _selectedImage = selectedImage;
    [self refresh];
}

-(void) handleTouch:(CGPoint) point{
    if(!_canModify){
        return;
    }
    int cScore = 0;
    for (int i = 0; i<_imageViews.count; i++) {
        UIImageView *imageView = [_imageViews objectAtIndex:i];
        if(imageView.frame.origin.x > point.x){
            cScore = i+1;
            break;
        }
    }
    _score = cScore;
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self handleTouch:p];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self handleTouch:p];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.delegate scoreView:self scoreDidChange:_score];
}

@end