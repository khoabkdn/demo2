//
//  ButtonShoot.m
//  demogame
//
//  Created by HTK-Hoa on 1/7/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "ButtonShoot.h"
#import "DataManager.h"

@implementation ButtonShoot
-(void)createButton{
    [self setFrame:CGRectMake(0, [DataManager shared].view.frame.size.height - self.imageView.image.size.height, self.imageView.image.size.width, self.imageView.image.size.height)];
    self.imageView.alpha = 0.7;
    [[DataManager shared].view addSubview:self];
    [self addTarget:self action:@selector(actionShoot:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (IBAction)actionShoot:(id)sender {
    Bullet *bl = [[Bullet alloc] init];
    [bl createBullet];
    [[DataManager shared].arrBullet addObject:bl];
}
@end
