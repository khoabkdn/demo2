//
//  ImageManager.h
//  demogame
//
//  Created by HTK-Hoa on 1/7/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
#import <UIKit/UIKit.h>

@interface ImageManager : UIImage

@property (nonatomic) UInt8 *dataPixel;
-(void)createDataPixel;
-(NSArray *)cutImageWithM:(int)m xN:(int)n;
@end
