//
//  Player.h
//  demogame
//
//  Created by HTK-Hoa on 1/4/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Player : UIImageView

@property(nonatomic) int check;
@property(strong,nonatomic) NSMutableArray *imageArrLeft;
@property(strong,nonatomic) NSMutableArray *imageArrRight;
@property(strong,nonatomic) NSMutableArray *imageArrUp;
@property(strong,nonatomic) NSMutableArray *imageArrDown;

- (void)createPlayer;

@end
