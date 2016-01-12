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
        [DataManager shared].player.animationImages = [DataManager shared].player.imageArrUp;
        [[DataManager shared].player startAnimating];
    }
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        UIView *view = [DataManager shared].view;
        UIImageView *joystick = [DataManager shared].joystick;
        Player *player = [DataManager shared].player;
        CGPoint point = [recognizer locationInView:view];
        float xcenter = joystick.center.x;
        float ycenter = joystick.center.y;
        float xpoint = point.x;
        float ypoint = point.y;
        float r = sqrtf(powf((xcenter-xpoint), 2)+powf((ycenter-ypoint), 2));
        float sin = (ypoint-ycenter)/r;
        float cos = (xpoint-xcenter)/r;
        float alpha = acosf(cos)*180/M_PI;
        if (sin<=0) {
            alpha = 360-alpha;
        }
        if (alpha<315&&alpha>=225) {
            _check = 2;
        } else if (alpha>=45&&alpha<135){
            _check = 3;
            
        } else if (alpha>=135&&alpha<225){
            _check = 4;
        } else{
            _check = 5;
        }
        if ((_check != player.check)) {
            player.check = _check;
            switch (_check) {
                case 2:
                    player.animationImages = player.imageArrUp;
                    break;
                case 3:
                    player.animationImages = player.imageArrDown;
                    break;
                case 4:
                    player.animationImages = player.imageArrLeft;
                    break;
                default:
                    player.animationImages = player.imageArrRight;
                    break;
            }
            [player startAnimating];
        }
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
        switch ([DataManager shared].player.check) {
            case 2:
                [DataManager shared].player.image = [[DataManager shared].arrImagePlayer objectAtIndex:12];
                break;
            case 3:
                [DataManager shared].player.image = [[DataManager shared].arrImagePlayer objectAtIndex:0];
                break;
            case 4:
                [DataManager shared].player.image = [[DataManager shared].arrImagePlayer objectAtIndex:4];
                break;
            default:
                [DataManager shared].player.image = [[DataManager shared].arrImagePlayer objectAtIndex:8];
                break;
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
    float xcenter = joystick.center.x;
    float ycenter = joystick.center.y;
    float xpoint = point.x;
    float ypoint = point.y;
    float r = sqrtf(powf((xcenter-xpoint), 2)+powf((ycenter-ypoint), 2));
    float sin = (ypoint-ycenter)/r;
    float cos = (xpoint-xcenter)/r;
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
