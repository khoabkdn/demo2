//
//  Player.m
//  demogame
//
//  Created by HTK-Hoa on 1/4/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "Player.h"
#import "DataManager.h"

@interface Player ()

@property (strong,nonatomic) NSMutableArray *imageArrLeft;
@property (strong,nonatomic) NSMutableArray *imageArrRight;
@property (strong,nonatomic) NSMutableArray *imageArrUp;
@property (strong,nonatomic) NSMutableArray *imageArrDown;

@end

@implementation Player

- (void)createPlayer{
    UIImage *im = [[DataManager shared].arrImagePlayer objectAtIndex:12];
    _check = 2;
    self.image = im;
    self.frame = CGRectMake([DataManager shared].view.frame.size.width/2-im.size.width/2, [DataManager shared].view.frame.size.height-im.size.height, im.size.width, im.size.height);
    [[DataManager shared].view addSubview:self];
}

-(void)typeRun:(NSArray *)imageArr{//animation cho player
    [self stopAnimating];
    self.animationImages = imageArr;
    self.animationDuration = 3;
    self.contentMode = UIViewContentModeScaleAspectFill;
    [self startAnimating];
}

-(NSArray *)loadImageDownOfPlayer{//mang animation di xuong
    if (!_imageArrDown) {
        _imageArrDown = [[NSMutableArray alloc] init];
    }
    for (int i = 0; i<4; i++) {
        [_imageArrDown addObject:[[DataManager shared].arrImagePlayer objectAtIndex:i]];
    }
    return _imageArrDown;
}

-(NSArray *)loadImageUpOfPlayer{//mang animation di len
    if (!_imageArrUp) {
        _imageArrUp = [[NSMutableArray alloc] init];
    }
    for (int i = 12; i<16; i++) {
        [_imageArrUp addObject:[[DataManager shared].arrImagePlayer objectAtIndex:i]];
    }
    return _imageArrUp;
}

-(NSArray *)loadImageLeftOfPlayer{//mang animation di qua trai
    if (!_imageArrLeft) {
        _imageArrLeft = [[NSMutableArray alloc] init];
    }
    for (int i = 4; i<8; i++) {
        [_imageArrLeft addObject:[[DataManager shared].arrImagePlayer objectAtIndex:i]];
    }
    return _imageArrLeft;
}

-(NSArray *)loadImageRightOfPlayer{//mang animation di qua phai
    if (!_imageArrRight) {
        _imageArrRight = [[NSMutableArray alloc] init];
    }
    for (int i = 8; i<12; i++) {
        [_imageArrRight addObject:[[DataManager shared].arrImagePlayer objectAtIndex:i]];
    }
    return _imageArrRight;
}

@end
