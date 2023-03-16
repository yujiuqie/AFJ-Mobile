//
//  UIImage+BMKImage.m
//  BaiduMapDemo
//
//  Created by Baidu on 2020/5/24.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import "UIImage+BMKImage.h"

@implementation UIImage (BMKImage)

+ (UIImage *)bmk_getImageWithColor:(UIColor *)color {
    return [UIImage bmk_getImageWithColor:color height:1.0f];
}


+ (UIImage *)bmk_getImageWithColor:(UIColor *)color height:(CGFloat)height {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();

    return theImage;
}
@end
