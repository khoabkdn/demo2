//
//  ViewController.m
//  demogame
//
//  Created by HTK-Hoa on 1/4/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ImageManager *imagePlayer = [[ImageManager alloc] initWithCGImage:[UIImage imageNamed:@"player2"].CGImage];//animation image of player
    [DataManager shared].arrImagePlayer = [imagePlayer cutImageWithM:4 xN:4];//cut image of player and save in array
    Player *player = [[Player alloc] init];
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
    ImageManager *imageMonster = [[ImageManager alloc] initWithCGImage:[UIImage imageNamed:@"monster"].CGImage];
    [DataManager shared].arrImageMonster = [imageMonster cutImageWithM:4 xN:4];
    Monster *monster = [[Monster alloc] init];
    [monster createMonster];
    Monster *monster1 = [[Monster alloc] init];
    [monster1 createMonster];
    Monster *monster2 = [[Monster alloc] init];
    [monster2 createMonster];
    Monster *monster3 = [[Monster alloc] init];
    [monster3 createMonster];
    Monster *monster4 = [[Monster alloc] init];
    [monster4 createMonster];
    Monster *monster5 = [[Monster alloc] init];
    [monster5 createMonster];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
