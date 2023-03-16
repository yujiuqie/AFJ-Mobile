//
//  UIImage+BMKImage.h
//  BaiduMapDemo
//
//  Created by Baidu on 2020/5/24.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (BMKImage)


/// 根据颜色生成一张尺寸为1*1的相同颜色图片
/// @param color 颜色
+ (UIImage *)bmk_getImageWithColor:(UIColor *)color;

/// 根据颜色生成图片
/// @param color 颜色
/// @param height 高度
+ (UIImage *)bmk_getImageWithColor:(UIColor *)color height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
