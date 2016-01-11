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

@end
