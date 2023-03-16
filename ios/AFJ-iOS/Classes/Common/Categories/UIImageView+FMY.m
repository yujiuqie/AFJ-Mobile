//
//  UIImageView+FMY.m
//  XWJSC
//
//  Created by xuewu.long on 16/12/13.
//  Copyright © 2016年 fmylove. All rights reserved.
//

@implementation UIImageView (FMY)

+ (UIImageView *)imgvFrame:(CGRect)frame backgroundColor:(UIColor *)color mode:(UIViewContentMode)mode {
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:frame];
    imgv.backgroundColor = color;
    imgv.contentMode = mode;
    return imgv;
}

@end
