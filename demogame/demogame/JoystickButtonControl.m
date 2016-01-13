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
@property UIView *view;
@property UIImageView *joystick;
@property Player *player;
@property float sin;
@property float cos;

@end

@implementation JoystickButtonControl

- (void)createJoystickButton {
    _view = [DataManager shared].view;
    _joystick = [DataManager shared].joystick;
    _player = [DataManager shared].player;
    UIImage *im = self.image;
    self.frame = CGRectMake(_joystick.center.x-im.size.width/2, _joystick.center.y-im.size.height/2, im.size.width, im.size.height);
    self.alpha = 0.65;
    [_view addSubview:self];
    _player.animationDuration = 1;
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
        switch (_player.check) {
            case 2:
                _player.animationImages = _player.imageArrUp;
                [_player startAnimating];
                break;
            case 3:
                _player.animationImages = _player.imageArrDown;
                [_player startAnimating];
                break;
            case 4:
                _player.animationImages = _player.imageArrLeft;
                [_player startAnimating];
                break;
            default:
                _player.animationImages = _player.imageArrRight;
                [_player startAnimating];
                break;
        }
    }
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [recognizer locationInView:_view];
        float xcenter = _joystick.center.x;
        float ycenter = _joystick.center.y;
        float xpoint = point.x;
        float ypoint = point.y;
        float r = sqrtf(powf((xcenter-xpoint), 2)+powf((ycenter-ypoint), 2));
        _sin = (ypoint-ycenter)/r;
        _cos = (xpoint-xcenter)/r;
        float alpha = acosf(_cos)*180/M_PI;
        if (_sin<=0) {
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
        if (_check != _player.check) {
            _player.check = _check;
            switch (_check) {
                case 2:
                    _player.animationImages = _player.imageArrUp;
                    break;
                case 3:
                    _player.animationImages = _player.imageArrDown;
                    break;
                case 4:
                    _player.animationImages = _player.imageArrLeft;
                    break;
                default:
                    _player.animationImages = _player.imageArrRight;
                    break;
            }
            [_player startAnimating];
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
        [_player stopAnimating];
        CGRect newFrame = self.frame;
        newFrame.origin.x = _joystick.center.x-self.frame.size.width/2;
        newFrame.origin.y = _joystick.center.y-self.frame.size.height/2;
        self.frame = newFrame;
        //set image when stop.
        switch (_player.check) {
            case 2:
                _player.image = [_player.imageArrUp objectAtIndex:0];
                break;
            case 3:
                _player.image = [_player.imageArrDown objectAtIndex:0];
                break;
            case 4:
                _player.image = [_player.imageArrLeft objectAtIndex:0];
                break;
            default:
                _player.image = [_player.imageArrRight objectAtIndex:0];
                break;
        }
    }
}

- (void)run {
    UILongPressGestureRecognizer *recognizer = _timer.userInfo;
    CGPoint point = [recognizer locationInView:_view];
    CGRect newJoyFrame = self.frame;
    //di chuyen joysticbutton
    float xjoy = point.x-self.frame.size.width/2;
    float yjoy = point.y-self.frame.size.height/2;
    if (xjoy>=_joystick.frame.origin.x&&xjoy<=_view.frame.size.width-self.frame.size.width) {
        newJoyFrame.origin.x = xjoy;
    }
    if (yjoy>=_joystick.frame.origin.y&&yjoy<=_view.frame.size.height-self.frame.size.height) {
        newJoyFrame.origin.y = yjoy;
    }
    self.frame = newJoyFrame;
    //di chuyen nguoi choi
    CGRect newframe = _player.frame;
    float x = _player.frame.origin.x+3*_cos;
    float y = _player.frame.origin.y+3*_sin;
    if (x>=0&&x<=(_view.frame.size.width-_player.frame.size.width)) {
        newframe.origin.x = x;
    }
    if (y>=0&&y<=(_view.frame.size.height-_player.frame.size.height)) {
        newframe.origin.y = y;
    }
    _player.frame = newframe;
}

@end
