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

-(NSArray *)loadImageLeftOfPlayer;
-(NSArray *)loadImageRightOfPlayer;
-(NSArray *)loadImageUpOfPlayer;
-(NSArray *)loadImageDownOfPlayer;
-(void)createPlayer;
-(void)typeRun:(NSArray *)imageArr;

@end
