//
//  CollisionController.m
//  demogame
//
//  Created by Dell Pro on 01/11/2016.
//  Copyright © 2016 HTK-Hoa. All rights reserved.
//

#import "CollisionController.h"

@implementation CollisionController

+ (BOOL)checkCollisionObjectA:(UIImageView *)objectA andObjectB:(UIImageView *)objectB{
    int x_B = objectB.frame.origin.x;
    int y_B = objectB.frame.origin.y;
    int x_A = objectA.frame.origin.x;
    int y_A = objectA.frame.origin.y;
    int w_B = objectB.frame.size.width;
    int h_A = objectA.frame.size.height;
    int w_A = objectA.frame.size.width;
    if ((y_B>=y_A&&y_B<=(y_A+h_A)&&x_B>=x_A && x_B<=(x_A+w_A))||(y_B>=y_A&&y_B<=(y_A+h_A)&&(x_B+w_B)>=x_A&&(x_B+w_B)<=(x_A+w_A))){
        return true;
    }else{
        return false;
    }
}

@end
