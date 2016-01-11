//
//  JoyStickControl.m
//  demogame
//
//  Created by HTK-Hoa on 1/8/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "JoystickControl.h"
#import "DataManager.h"

@implementation JoystickControl

-(void)createJoystick{
    UIImage *im = self.image;
    self.frame = CGRectMake([DataManager shared].view.frame.size.width-im.size.width, [DataManager shared].view.frame.size.height-im.size.height, im.size.width, im.size.height);
    self.alpha = 0.45;
    [[DataManager shared].view addSubview:self];
}

@end
