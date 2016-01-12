//
//  ImageManager.m
//  demogame
//
//  Created by HTK-Hoa on 1/7/16.
//  Copyright (c) 2016 HTK-Hoa. All rights reserved.
//

#import "ImageManager.h"

@interface ImageManager ()
@property (strong,nonatomic)NSMutableArray *imageArr;
@end

@implementation ImageManager

-(NSArray *)cutImageWithM:(int)m xN:(int)n{
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc] init];
    }
    for (int y=0; y<self.size.height; y+=self.size.height/n) {
        for (int x=0; x<self.size.width; x+=self.size.width/m) {
            CGRect fromRect = CGRectMake(x, y, self.size.width/4, self.size.height/4);
            CGImageRef drawImage = CGImageCreateWithImageInRect(self.CGImage, fromRect);
            ImageManager *newImage = [[ImageManager alloc] initWithCGImage:drawImage];
            [newImage createDataPixel];
            [_imageArr addObject:newImage];
            CGImageRelease(drawImage);
        }
    }
    return _imageArr;
}
-(void)createDataPixel{
    CFDataRef pxData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage));
    _dataPixel = (UInt8 *)CFDataGetBytePtr(pxData);
}

@end
