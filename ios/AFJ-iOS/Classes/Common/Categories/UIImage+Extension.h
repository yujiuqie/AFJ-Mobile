//
//  UIImage+Extension.h
//  WeChat
//
//  Created by CoderMikeHe on 2017/8/9.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  根据图片名返回一张能够自由拉伸的图片 (从中间拉伸)
 */
+ (UIImage *)yc_resizableImage:(NSString *)imgName;

+ (UIImage *)yc_resizableImage:(NSString *)imgName capInsets:(UIEdgeInsets)capInsets;


/// 返回一张未被渲染的图片
+ (UIImage *)yc_imageAlwaysShowOriginalImageWithImageName:(NSString *)imageName;

/// 获取视频某个时间的帧图片
+ (UIImage *)yc_thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

/// 获取屏幕截图
///
/// @return 屏幕截图图像
+ (UIImage *)yc_screenShot;


/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)yc_imageWithColor:(UIColor *)color;


/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)yc_colorAtPoint:(CGPoint)point;


//more accurate method ,colorAtPixel 1x1 pixel
/**
 *  @brief  取某一像素的颜色
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)yc_colorAtPixel:(CGPoint)point;


/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)yc_hasAlphaChannel;


/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */
+ (UIImage *)yc_covertToGrayImageFromImage:(UIImage *)sourceImage;


/// 将图片进行base64编码，返回编码后的字符串
- (NSString *)base64Encode;

/// 将字符串进行base64解码，返回解码后的图像
+ (UIImage *)base64DecodedImageWith:(NSString *)base64String;


@end
