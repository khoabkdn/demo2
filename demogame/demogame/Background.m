//
//  Background.m
//  demogame
//
//  Created by HTK-Hoa on 1/4/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "Background.h"

@implementation Background
+(void)setBacgroundWithImageName:(NSString *)imageString view:(UIView *)view{
    UIGraphicsBeginImageContext(view.frame.size);
    [[UIImage imageNamed:imageString] drawInRect: view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    view.backgroundColor = [UIColor colorWithPatternImage:image];
}
@end
