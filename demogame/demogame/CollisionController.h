//
//  CollisionController.h
//  demogame
//
//  Created by Dell Pro on 01/11/2016.
//  Copyright © 2016 HTK-Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CollisionController : NSObject

+(BOOL)checkCollisionObjectA:(UIImageView *)objectA andObjectB:(UIImageView *)objectB;
+(double)xpointFrontA:(UIImageView *)objectA B:(UIImageView *)objectB;
+(double)ypointFrontA:(UIImageView *)objectA B:(UIImageView *)objectB;
+(double)xpointBehindA:(UIImageView *)objectA B:(UIImageView *)objectB;
+(double)ypointBehindA:(UIImageView *)objectA B:(UIImageView *)objectB;
+(BOOL)checkAlphaColor:(UIImage *)image xOfInmage:(int)x yOfImage:(int)y data:(UInt8 *) data;

@end
