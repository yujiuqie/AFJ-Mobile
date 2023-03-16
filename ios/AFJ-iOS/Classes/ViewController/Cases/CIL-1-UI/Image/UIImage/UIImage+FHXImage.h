//
//  UIImage+FHXImage.h
//  day11网易彩票
//
//  Created by 冯汉栩 on 2018/9/3.
//  Copyright © 2018年 fenghanxu.compang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FHXImage)

/**
 输入图片颜色返回一张图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 裁切图片的一个点进行延伸
 */
- (UIImage *)stretchableImage;

/**
 *  返回圆形图片   iconView.image = [[UIImage imageNamed:@"Yosemite01"] dc_circleImage];
 */
+ (instancetype)circleImage:(NSString *)name;

/**
 *  返回圆形图片   iconView.image = [[image imageNamed:@"Yosemite01"] dc_circleImage];
 */
- (instancetype)circleImage;

/**
 输入图片颜色跟大小返回一张图片 
 */
+ (UIImage *)createImageWithColor:(UIColor *)color withRect:(CGRect)rect;


/**
 加载gif动画
 */
+ (UIImage *)loadGifWithImageName:(NSString *)name;


@end
