//
//  Monster.h
//  demogame
//
//  Created by HTK-Hoa on 1/8/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Monster : UIImageView

@property int way;
@property CGRect pointStart;
@property int distanceMove;
@property (strong,nonatomic)CADisplayLink *display;
@property BOOL checkWay;
@property(strong,nonatomic) NSMutableArray *imageArrLeft;
@property(strong,nonatomic) NSMutableArray *imageArrRight;
@property(strong,nonatomic) NSMutableArray *imageArrUp;
@property(strong,nonatomic) NSMutableArray *imageArrDown;

- (void)createMonster;
- (void)removeMonster;

@end
