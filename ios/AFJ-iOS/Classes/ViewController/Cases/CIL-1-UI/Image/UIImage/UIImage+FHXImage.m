//
//  UIImage+FHXImage.m
//  day11网易彩票
//
//  Created by 冯汉栩 on 2018/9/3.
//  Copyright © 2018年 fenghanxu.compang.cn. All rights reserved.
//

@implementation UIImage (FHXImage)

/**
 输入图片颜色返回一张图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);  //图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    return image;
}

/**
 裁切图片的一个点进行延伸
 */
- (UIImage *)stretchableImage {
    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
}

/**
 *  返回圆形图片   iconView.image = [[UIImage imageNamed:@"Yosemite01"] dc_circleImage];
 */
+ (instancetype)circleImage:(NSString *)name {

    return [[self imageNamed:name] circleImage];
}

- (instancetype)circleImage {

    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);

    // 裁剪
    CGContextClip(ctx);
    // 绘制图片
    [self drawInRect:rect];
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();

    return image;
}


/**
 输入图片颜色跟大小返回一张图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color withRect:(CGRect)rect {

    UIGraphicsBeginImageContext(rect.size); //填充画笔

    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制

    CGContextSetFillColorWithColor(context, color.CGColor);

    CGContextFillRect(context, rect); //联系显示区域

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息

    UIGraphicsEndImageContext(); //消除画笔

    return image;

}

/**
 加载gif动画
 */
+ (UIImage *)loadGifWithImageName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    return [UIImage sd_imageWithGIFData:gifData];
}

@end




