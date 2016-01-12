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
    self.distanceMove = 80+arc4random()%40;
    int wView = [DataManager shared].view.frame.size.width;
    int hView = [DataManager shared].view.frame.size.height;
    int wIm = im.size.width;
    int hIm = im.size.height;
    int xstart = arc4random()%300;
    int ystart = arc4random()%600;
    _pointStart.origin.x = xstart;
    _pointStart.origin.y = ystart;
    if (xstart>=0&&ystart>=0&&xstart<_distanceMove&&ystart<_distanceMove) {
        _way = arc4random()%2;
    }else if (xstart>=0&&xstart<_distanceMove&&ystart>=hView-hIm&&ystart<=hView){
        _way = 3*arc4random()%2;
    }else if (xstart>=wView-wIm&&xstart<=wView&&ystart>=0&&ystart<_distanceMove){
        _way = 1+arc4random()%2;
    }else if (xstart>=wView-wIm&&xstart<=wView&&ystart>=hView-hIm&&ystart<=hView){
        _way = 2+arc4random()%2;
    }else{
        _way = arc4random()%4;
    }
    self.frame = CGRectMake(_pointStart.origin.x, _pointStart.origin.y, im.size.width, im.size.height);
    [[DataManager shared].view addSubview:self];
    _checkWay = true;
    [self startMonster];
    [[DataManager shared].arrMonster addObject:self];
}

- (void)startMonster{
    CADisplayLink *dl = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeCallBack:)];
    dl.frameInterval = 1;
    [dl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _display = dl;
}

- (void)timeCallBack:(CADisplayLink *)sender{
    CGRect newFrame = self.frame;
    switch (_way) {
        case 0:
            if (_checkWay) {
                if (newFrame.origin.x <= (_pointStart.origin.x + _distanceMove)) {
                    newFrame.origin.x+=1;
                }
                if (newFrame.origin.x == _pointStart.origin.x + _distanceMove){
                    _checkWay = false;
                }
            }else{
                if (newFrame.origin.x >= _pointStart.origin.x) {
                    newFrame.origin.x-=1;
                }
                if (newFrame.origin.x == _pointStart.origin.x) {
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
                    _checkWay = false;
                }
            }else{
                if (newFrame.origin.y >= _pointStart.origin.y) {
                    newFrame.origin.y-=1;
                }
                if (newFrame.origin.y == _pointStart.origin.y) {
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
                    _checkWay = false;
                }
            }else{
                if (newFrame.origin.x <= _pointStart.origin.x) {
                    newFrame.origin.x+=1;
                }
                if (newFrame.origin.x == _pointStart.origin.x) {
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
                    _checkWay = false;
                }
            }else{
                if (newFrame.origin.y <= _pointStart.origin.y) {
                    newFrame.origin.y+=1;
                }
                if (newFrame.origin.y == _pointStart.origin.y) {
                    _checkWay = true;
                }
            }
            break;
    }
    self.frame = newFrame;
}

- (void)removeMonster{
    [self removeFromSuperview];
    [[DataManager shared].arrMonster removeObject:self];
}
@end
