//
//  ViewController.m
//  demogame
//
//  Created by HTK-Hoa on 1/4/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
{
    Player *player;
    NSTimer *timer;
    NSArray *arrPlayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    player = [[Player alloc] init];
    ImageManager *im = [[ImageManager alloc] initWithCGImage:[UIImage imageNamed:@"player2"].CGImage];//animation image of player
    [DataManager shared].arrImagePlayer = [im cutImageWithM:4 xN:4];//cut image of player and save in array
    [DataManager shared].player = player;
    [DataManager shared].view = self.view;
    [player createPlayer];
    JoystickControl *joystick = [[JoystickControl alloc] initWithImage:[UIImage imageNamed:@"gameplay1"]];//can dieu khien
    [joystick createJoystick];
    [DataManager shared].joystick = joystick;
    JoystickButtonControl *joystickButton = [[JoystickButtonControl alloc] initWithImage:[UIImage imageNamed:@"gameplay2"]];//nut trong can dieu khien
    [joystickButton createJoystickButton];
    ButtonShoot *shoot = [[ButtonShoot alloc] init];//nut ban dan
    [shoot setImage:[UIImage imageNamed:@"btShoot"] forState:UIControlStateNormal];
    [shoot createButton];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
