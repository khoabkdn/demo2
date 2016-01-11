//
//  DataManager.h
//  demogame
//
//  Created by HTK-Hoa on 1/7/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Bullet.h"
#import "Player.h"
#import "JoystickControl.h"
#import "JoystickButtonControl.h"
#import "Monster.h"

@interface DataManager : NSObject

@property(strong,nonatomic) Player *player;
@property(strong,nonatomic) Bullet *bullet;
@property(strong,nonatomic) UIView *view;
@property(strong,nonatomic) NSArray *arrImagePlayer;
@property(strong,nonatomic) JoystickControl *joystick;
@property(strong,nonatomic) NSArray *arrImageMonster;
@property(strong,nonatomic) NSMutableArray *arrBullet;
@property(strong,nonatomic) NSMutableArray *arrMonster;

+ (DataManager *)shared;
@end
