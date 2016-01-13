//
//  Monster.m
//  demogame
//
//  Created by HTK-Hoa on 1/8/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "Monster.h"
#import "DataManager.h"
#import "CollisionController.h"

@implementation Monster
- (void)createMonster {
    UIImage *im = [[DataManager shared].arrImageMonster objectAtIndex:0];
    self.image = im;
    _imageArrDown = [[NSMutableArray alloc] init];
    _imageArrUp = [[NSMutableArray alloc] init];
    _imageArrLeft = [[NSMutableArray alloc] init];
    _imageArrRight = [[NSMutableArray alloc] init];
    for (int i = 0; i<4; i++) {
        [_imageArrDown addObject:[[DataManager shared].arrImageMonster objectAtIndex:i]];
    }
    for (int i = 12; i<16; i++) {
        [_imageArrUp addObject:[[DataManager shared].arrImageMonster objectAtIndex:i]];
    }
    for (int i = 4; i<8; i++) {
        [_imageArrLeft addObject:[[DataManager shared].arrImageMonster objectAtIndex:i]];
    }
    for (int i = 8; i<12; i++) {
        [_imageArrRight addObject:[[DataManager shared].arrImageMonster objectAtIndex:i]];
    }
    self.distanceMove = 80+arc4random()%40;
    int xstart = 120+arc4random()%135;
    int ystart = 120+arc4random()%427;
    _pointStart.origin.x = xstart;
    _pointStart.origin.y = ystart;
    _way = arc4random()%4;
    self.frame = CGRectMake(_pointStart.origin.x, _pointStart.origin.y, im.size.width, im.size.height);
    [[DataManager shared].view addSubview:self];
    _checkWay = true;
    self.animationDuration = 1;
    switch (_way) {
        case 0:
            self.animationImages = _imageArrRight;
            [self startAnimating];
            break;
        case 1:
            self.animationImages = _imageArrDown;
            [self startAnimating];
            break;
        case 2:
            self.animationImages = _imageArrLeft;
            [self startAnimating];
            break;
        default:
            self.animationImages = _imageArrUp;
            [self startAnimating];
            break;
    }
    [self startMonster];
    [[DataManager shared].arrMonster addObject:self];
}

- (void)startMonster {
    CADisplayLink *dl = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeCallBack:)];
    dl.frameInterval = 1;
    [dl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _display = dl;
}

- (void)timeCallBack:(CADisplayLink *)sender {
    CGRect newFrame = self.frame;
    switch (_way) {
        case 0:
            if (_checkWay) {
                if (newFrame.origin.x <= (_pointStart.origin.x + _distanceMove)) {
                    newFrame.origin.x+=1;
                }
                if (newFrame.origin.x == _pointStart.origin.x + _distanceMove){
                    self.animationImages = _imageArrLeft;
                    [self startAnimating];
                    _checkWay = false;
                }
            }else{
                if (newFrame.origin.x >= _pointStart.origin.x) {
                    newFrame.origin.x-=1;
                }
                if (newFrame.origin.x == _pointStart.origin.x) {
                    self.animationImages = _imageArrRight;
                    [self startAnimating];
                    _checkWay = true;
                }
            }
            break;
        case 1:
            if (_checkWay) {
                if (newFrame.origin.y <= (_pointStart.origin.y + _distanceMove)) {
                    newFrame.origin.y+=1;
                }
                if (newFrame.origin.y == _pointStart.origin.y + _distanceMove){
                    self.animationImages = _imageArrUp;
                    [self startAnimating];
                    _checkWay = false;
                }
            }else{
                if (newFrame.origin.y >= _pointStart.origin.y) {
                    newFrame.origin.y-=1;
                }
                if (newFrame.origin.y == _pointStart.origin.y) {
                    self.animationImages = _imageArrDown;
                    [self startAnimating];
                    _checkWay = true;
                }
            }
            break;
        case 2:
            if (_checkWay) {
                if (newFrame.origin.x >= (_pointStart.origin.x - _distanceMove)) {
                    newFrame.origin.x-=1;
                }
                if (newFrame.origin.x == _pointStart.origin.x - _distanceMove){
                    self.animationImages = _imageArrRight;
                    [self startAnimating];
                    _checkWay = false;
                }
            }else{
                if (newFrame.origin.x <= _pointStart.origin.x) {
                    newFrame.origin.x+=1;
                }
                if (newFrame.origin.x == _pointStart.origin.x) {
                    self.animationImages = _imageArrLeft;
                    [self startAnimating];
                    _checkWay = true;
                }
            }
            break;
        case 3:
            if (_checkWay) {
                if (newFrame.origin.y >= (_pointStart.origin.y - _distanceMove)) {
                    newFrame.origin.y-=1;
                }
                if (newFrame.origin.y == _pointStart.origin.y - _distanceMove){
                    self.animationImages = _imageArrDown;
                    [self startAnimating];
                    _checkWay = false;
                }
            }else{
                if (newFrame.origin.y <= _pointStart.origin.y) {
                    newFrame.origin.y+=1;
                }
                if (newFrame.origin.y == _pointStart.origin.y) {
                    self.animationImages = _imageArrUp;
                    [self startAnimating];
                    _checkWay = true;
                }
            }
            break;
    }
    self.frame = newFrame;
}

- (void)removeMonster {
    [self removeFromSuperview];
    [[DataManager shared].arrMonster removeObject:self];
}
@end
