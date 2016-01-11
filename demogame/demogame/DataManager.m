//
//  DataManager.m
//  demogame
//
//  Created by HTK-Hoa on 1/7/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
+ (DataManager *)shared {
    static DataManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}
- (instancetype)init {
    self = [super init];
    _arrBullet = [[NSMutableArray alloc] init];
    _arrMonster = [[NSMutableArray alloc] init];
    return self;
}
@end
