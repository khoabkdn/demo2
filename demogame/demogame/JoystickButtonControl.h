//
//  JoyStickManager.h
//  demogame
//
//  Created by HTK-Hoa on 1/6/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JoystickControl.h"
#import "Player.h"

@interface JoystickButtonControl : UIImageView

- (void)createJoystickButton;
- (void)joystickLongPressGestureRecognizer;

@end
