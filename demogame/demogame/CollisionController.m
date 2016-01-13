//
//  CollisionController.m
//  demogame
//
//  Created by Dell Pro on 01/11/2016.
//  Copyright © 2016 HTK-Hoa. All rights reserved.
//

#import "CollisionController.h"

@implementation CollisionController

+ (BOOL)checkCollisionObjectA:(UIImageView *)objectA andObjectB:(UIImageView *)objectB{//va cham khung
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

+ (double)xpointFrontA:(UIImageView *)objectA B:(UIImageView *)objectB{
    int x_B = objectB.frame.origin.x;
    int x_A = objectA.frame.origin.x;
    return MAX(x_A, x_B);
}

+ (double)ypointFrontA:(UIImageView *)objectA B:(UIImageView *)objectB{
    int y_B = objectB.frame.origin.y;
    int y_A = objectA.frame.origin.y;
    return MAX(y_A, y_B);
}

+ (double)xpointBehindA:(UIImageView *)objectA B:(UIImageView *)objectB{
    int x_B = objectB.frame.origin.x;
    int x_A = objectA.frame.origin.x;
    int w_B = objectB.frame.size.width;
    int w_A = objectA.frame.size.width;
    return MIN(x_A+w_A, x_B+w_B);
}

+ (double)ypointBehindA:(UIImageView *)objectA B:(UIImageView *)objectB{
    int y_B = objectB.frame.origin.y;
    int y_A = objectA.frame.origin.y;
    int h_B = objectB.frame.size.height;
    int h_A = objectA.frame.size.height;
    return MIN(y_A+h_A, y_B+h_B);
}

+ (BOOL)checkAlphaColor:(UIImage *)image xOfInmage:(int)x yOfImage:(int)y data:(UInt8 *) data{//kiem tra mau alpha
    int pixelInfo = ((image.size.width  * y) + x ) * 4;
    UInt8 alpha = data[pixelInfo + 3];
    if (alpha==255) return YES;
    else return NO;
}

@end
