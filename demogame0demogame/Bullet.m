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

@property (nonatomic) CGPoint vectoRun;
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
    //huong dan ban dau
    ImageManager *im;
    switch (check) {//kiem tra huong
        case 2:
            im = [[ImageManager alloc] initWithCGImage:[UIImage imageNamed:@"bullet1.png"].CGImage];
            self.image = im;
            self.frame = CGRectMake(xplayer+width/2-im.size.width/2, yplayer, im.size.width, im.size.height);
            _vectoRun.x = 0;
            _vectoRun.y = -5;
            break;
        case 3:
            im = [[ImageManager alloc] initWithCGImage:[UIImage imageNamed:@"bulletdown.png"].CGImage];
            self.image = im;
            self.frame = CGRectMake(xplayer+width/2-im.size.width/2, yplayer+height/2, im.size.width, im.size.height);
            _vectoRun.x = 0;
            _vectoRun.y = 5;
            break;
        case 4:
            im = [[ImageManager alloc] initWithCGImage:[UIImage imageNamed:@"bulletleft.png"].CGImage];
            self.image = im;
            self.frame = CGRectMake(xplayer, yplayer+height/3+im.size.height/2, im.size.width, im.size.height);
            _vectoRun.x = -5;
            _vectoRun.y = 0;
            break;
        default:
            im = [[ImageManager alloc] initWithCGImage:[UIImage imageNamed:@"bulletright.png"].CGImage];
            self.image = im;
            self.frame = CGRectMake(xplayer+width/2, yplayer+height/3+im.size.height/2, im.size.width, im.size.height);
            _vectoRun.x = 5;
            _vectoRun.y = 0;
            break;
    }
    [im createDataPixel];
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
    CGRect tempFrame = self.frame;
    if (tempFrame.origin.y<=0) {
        [sender removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        [self removeFromSuperview];
        [[DataManager shared].arrBullet removeObject:self];
    }else{
        tempFrame.origin.x+=_vectoRun.x;
        tempFrame.origin.y+=_vectoRun.y;
        self.frame = tempFrame;
        for (int i = 0; i<[DataManager shared].arrMonster.count; i++) {
            Monster *temp = [[DataManager shared].arrMonster objectAtIndex:i];
            if ([CollisionController checkCollisionObjectA:self andObjectB:temp]||
                [CollisionController checkCollisionObjectA:temp andObjectB:self]) {
                int xFront = [CollisionController xpointFrontA:self B:temp];
                int yFront = [CollisionController ypointFrontA:self B:temp];
                int xBehind = [CollisionController xpointBehindA:self B:temp];
                int yBehind = [CollisionController ypointBehindA:self B:temp];
                for (int i = xFront; i<=xBehind; i++) {
                    for (int j = yFront; j<=yBehind; j++) {
                        ImageManager *imageBullet = (ImageManager*)self.image;
                        ImageManager *imageMonster = (ImageManager*)temp.image;
                        if ([CollisionController checkAlphaColor:self.image xOfInmage:i-self.frame.origin.x yOfImage:j-self.frame.origin.y data:imageBullet.dataPixel]&&
                            [CollisionController checkAlphaColor:temp.image xOfInmage:i-self.frame.origin.x yOfImage:j-self.frame.origin.y data:imageMonster.dataPixel]) {
                            [sender removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
                            [self removeBullet];
                            [temp removeMonster];
                        }
                    }
                }
            }
        }
    }
}

- (void)removeBullet {
    [self removeFromSuperview];
    [[DataManager shared].arrBullet removeObject:self];
}
@end
