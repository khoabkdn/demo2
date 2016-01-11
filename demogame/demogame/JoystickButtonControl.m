//
//  JoyStickManager.m
//  demogame
//
//  Created by HTK-Hoa on 1/6/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "JoystickButtonControl.h"
#import "DataManager.h"

@interface JoystickButtonControl ()

@property int check;
@property NSTimer *timer;

@end

@implementation JoystickButtonControl

- (void)createJoystickButton {
    UIImage *im = self.image;
    self.frame = CGRectMake([DataManager shared].joystick.center.x-im.size.width/2, [DataManager shared].joystick.center.y-im.size.height/2, im.size.width, im.size.height);
    self.alpha = 0.65;
    [[DataManager shared].view addSubview:self];
    [DataManager shared].player.animationDuration = 1;
    [self joystickLongPressGestureRecognizer];
}

- (void)joystickLongPressGestureRecognizer {
    //su kien nhan
    UILongPressGestureRecognizer *joystickRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleJoystickGame:)];
    self.userInteractionEnabled = true;
    joystickRecognizer.minimumPressDuration = 0.01;
    [self addGestureRecognizer:joystickRecognizer];
}

- (void)handleJoystickGame:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (_timer == nil) {
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                      target:self
                                                    selector:@selector(run)
                                                    userInfo:recognizer
                                                     repeats:YES];
            
        }
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [_timer invalidate];
        _timer = nil;
        [[DataManager shared].player stopAnimating];
        //set image when stop.
        if ([DataManager shared].player.check == 2) {
            [DataManager shared].player.image = [[DataManager shared].arrImagePlayer objectAtIndex:12];
            
        }else if ([DataManager shared].player.check == 3) {
            [DataManager shared].player.image = [[DataManager shared].arrImagePlayer objectAtIndex:0];
            
        }else  if ([DataManager shared].player.check == 4) {
            [DataManager shared].player.image = [[DataManager shared].arrImagePlayer objectAtIndex:4];
        } else{
            [DataManager shared].player.image = [[DataManager shared].arrImagePlayer objectAtIndex:8];
        }
    }
}

- (void)run {
    UIView *view = [DataManager shared].view;
    UIImageView *joystick = [DataManager shared].joystick;
    Player *player = [DataManager shared].player;
    UILongPressGestureRecognizer *recognizer = _timer.userInfo;
    CGPoint point = [recognizer locationInView:view];
    CGRect newJoyFrame = self.frame;
    //di chuyen joysticbutton
    float xjoy = point.x-self.frame.size.width/2;
    float yjoy = point.y-self.frame.size.height/2;
    if (xjoy>=joystick.frame.origin.x&&xjoy<=view.frame.size.width-self.frame.size.width) {
        newJoyFrame.origin.x = xjoy;
    }
    if (yjoy>=joystick.frame.origin.y&&yjoy<=view.frame.size.height-self.frame.size.height) {
        newJoyFrame.origin.y = yjoy;
    }
    self.frame = newJoyFrame;
    //set animation image ung voi huong di chuyen
    float xcenter = joystick.center.x;
    float ycenter = joystick.center.y;
    float xpoint = point.x;
    float ypoint = point.y;
    float sin = (ypoint-ycenter)/sqrtf(powf((xcenter-xpoint), 2)+powf((ycenter-ypoint), 2));
    float cos = (xpoint-xcenter)/sqrtf(powf((xcenter-xpoint), 2)+powf((ycenter-ypoint), 2));
    if (acosf(cos)<3*M_PI/4&&acosf(cos)>M_PI/4&&asinf(sin)<0) {
        player.check = 2;
        if (_check == player.check) {
            if (![player isAnimating]) {
                player.animationImages = player.imageArrUp;
                [player startAnimating];
            }
        }else{
            player.animationImages = player.imageArrUp;
            _check = player.check;
        }
    } else if (acosf(cos)<3*M_PI/4&&acosf(cos)>M_PI/4&&asinf(sin)>0){
        player.check = 3;
        if (_check == player.check) {
            if (![player isAnimating]) {
                player.animationImages = player.imageArrDown;
                [player startAnimating];
            }
        }else{
            player.animationImages = player.imageArrDown;
            _check = player.check;
        }
        
    } else if (acosf(cos)<5*M_PI/4&&acosf(cos)>3*M_PI/4){
        player.check = 4;
        if (_check == player.check) {
            if (![player isAnimating]) {
                player.animationImages = player.imageArrLeft;
                [player startAnimating];
            }
        }else{
            player.animationImages = player.imageArrLeft;
            _check = player.check;
        }
    } else{
        player.check = 5;
        if (_check == player.check) {
            if (![player isAnimating]) {
                player.animationImages = player.imageArrRight;
                [player startAnimating];
            }
        }else{
            player.animationImages = player.imageArrRight;
            _check = player.check;
        }
    }
    //di chuyen nguoi choi
    CGRect newframe = player.frame;
    float x = player.frame.origin.x+3*cos;
    float y = player.frame.origin.y+3*sin;
    if (x>=0&&x<=(view.frame.size.width-player.frame.size.width)) {
        newframe.origin.x = x;
    }
    if (y>=0&&y<=(view.frame.size.height-player.frame.size.height)) {
        newframe.origin.y = y;
    }
    player.frame = newframe;
}

@end
