//
//  Bullet.m
//  demogame
//
//  Created by HTK-Hoa on 1/4/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "Bullet.h"
#import "DataManager.h"
#import "CollisionController.h"

@interface Bullet ()

@property CADisplayLink *display;
@property int check;

@end

@implementation Bullet
- (void)createBullet {
    int check = [DataManager shared].player.check;
    UIImageView *player = [DataManager shared].player;
    float xplayer = player.frame.origin.x;
    float yplayer = player.frame.origin.y;
    int width = player.frame.size.width;
    int height = player.frame.size.height;
    UIView *view = [DataManager shared].view;
    //huong dan ban
    if (check == 2) {
        UIImage *im = [UIImage imageNamed:@"bullet.png"];
        self.image = im;
        self.frame = CGRectMake(xplayer+width/2-im.size.width/2, yplayer, im.size.width, im.size.height);
    }else if (check == 3) {
        UIImage *im = [UIImage imageNamed:@"bulletdown.png"];
        self.image = im;
        self.frame = CGRectMake(xplayer+width/2-im.size.width/2, yplayer+height/2, im.size.width, im.size.height);
    }else  if (check == 4) {
        UIImage *im = [UIImage imageNamed:@"bulletleft.png"];
        self.image = im;
        self.frame = CGRectMake(xplayer, yplayer+height/3+im.size.height/2, im.size.width, im.size.height);
    } else{
        UIImage *im = [UIImage imageNamed:@"bulletright.png"];
        self.image = im;
        self.frame = CGRectMake(xplayer+width/2, yplayer+height/3+im.size.height/2, im.size.width, im.size.height);
    }
    [view addSubview:self];
    [self startBullet];
}
- (void)startBullet {
    //tao vong lap
    CADisplayLink *dl = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeCallBack:)];
    dl.frameInterval = 1;
    [dl addToRunLoop:[NSRunLoop mainRunLoop] forMode: NSDefaultRunLoopMode];
    _display = dl;
}
- (void)timeCallBack:(CADisplayLink *)sender {
    int check = [DataManager shared].player.check;
    CGRect tempFrame = self.frame;
    if (tempFrame.origin.y<=0) {
        [sender removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        [self removeFromSuperview];
        [[DataManager shared].arrBullet removeObject:self];
    }else{
        //di chuyen dan theo huong
        if (!_check) {
            if (check == 2) {
                tempFrame.origin.y-=5;
                self.frame = tempFrame;
                _check=2;
            }else if (check == 3) {
                tempFrame.origin.y+=5;
                self.frame = tempFrame;
                _check=3;
            }else  if (check == 4) {
                tempFrame.origin.x-=5;
                self.frame = tempFrame;
                _check=4;
            } else{
                tempFrame.origin.x+=5;
                self.frame = tempFrame;
                _check=5;
            }
        }else{
            [self run:tempFrame];
        }
        for (int i = 0; i<[DataManager shared].arrMonster.count; i++) {
            if ([CollisionController checkCollisionObjectA:self andObjectB:[[DataManager shared].arrMonster objectAtIndex:i]]||[CollisionController checkCollisionObjectA:[[DataManager shared].arrMonster objectAtIndex:i] andObjectB:self]) {
                [sender removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
                [self removeFromSuperview];
                [[DataManager shared].arrBullet removeObject:self];
                [[[DataManager shared].arrMonster objectAtIndex:i] removeFromSuperview];
                [[DataManager shared].arrMonster removeObject:[[DataManager shared].arrMonster objectAtIndex:i]];
            }
        }
    }
}
- (void)run:(CGRect)tempFrame {
    if (_check == 2) {
        tempFrame.origin.y-=5;
        self.frame = tempFrame;
    }else if (_check == 3) {
        tempFrame.origin.y+=5;
        self.frame = tempFrame;
    }else  if (_check == 4) {
        tempFrame.origin.x-=5;
        self.frame = tempFrame;
    } else{
        tempFrame.origin.x+=5;
        self.frame = tempFrame;
    }
}
@end
