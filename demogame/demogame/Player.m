//
//  Player.m
//  demogame
//
//  Created by HTK-Hoa on 1/4/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "Player.h"
#import "DataManager.h"

@implementation Player

- (void)createPlayer {
    UIImage *im = [[DataManager shared].arrImagePlayer objectAtIndex:12];
    _check = 2;//huong ban dau
    self.image = im;
    self.frame = CGRectMake([DataManager shared].view.frame.size.width/2-im.size.width/2, [DataManager shared].view.frame.size.height-im.size.height, im.size.width, im.size.height);
    [[DataManager shared].view addSubview:self];
    _imageArrDown = [[NSMutableArray alloc] init];
    _imageArrUp = [[NSMutableArray alloc] init];
    _imageArrLeft = [[NSMutableArray alloc] init];
    _imageArrRight = [[NSMutableArray alloc] init];
    for (int i = 0; i<4; i++) {
        [_imageArrDown addObject:[[DataManager shared].arrImagePlayer objectAtIndex:i]];
    }
    for (int i = 12; i<16; i++) {
        [_imageArrUp addObject:[[DataManager shared].arrImagePlayer objectAtIndex:i]];
    }
    for (int i = 4; i<8; i++) {
        [_imageArrLeft addObject:[[DataManager shared].arrImagePlayer objectAtIndex:i]];
    }
    for (int i = 8; i<12; i++) {
        [_imageArrRight addObject:[[DataManager shared].arrImagePlayer objectAtIndex:i]];
    }
}

- (void)removePlayer {
    [self removeFromSuperview];
}
@end
