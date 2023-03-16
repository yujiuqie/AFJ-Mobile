//
//  UIImage+Extension.h
//  WeChat
//
//  Created by CoderMikeHe on 2017/8/9.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

@implementation UIImage (Extension)

/**
 *  根据图片名返回一张能够自由拉伸的图片 (从中间拉伸)
 */
+ (UIImage *)yc_resizableImage:(NSString *)imgName {
    UIImage *image = [UIImage imageNamed:imgName];
    return [self yc_resizableImage:imgName capInsets:UIEdgeInsetsMake(image.size.height * .5f, image.size.width * .5f, image.size.height * .5f, image.size.width * .5f)];
}

+ (UIImage *)yc_resizableImage:(NSString *)imgName capInsets:(UIEdgeInsets)capInsets {
    UIImage *image = [UIImage imageNamed:imgName];
    return [image resizableImageWithCapInsets:capInsets];
}

+ (UIImage *)yc_imageAlwaysShowOriginalImageWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    if ([image respondsToSelector:@selector(imageWithRenderingMode:)]) {   //iOS 7.0+
        return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        return image;
    }
}

+ (UIImage *)yc_thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {

    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;

    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];

    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);

    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;

    return thumbnailImage;
}

/// 获取屏幕截图
///
/// @return 屏幕截图图像
+ (UIImage *)yc_screenShot {
    // 1. 获取到窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    // 2. 开始上下文
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, YES, 0);

    // 3. 将 window 中的内容绘制输出到当前上下文
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];

    // 4. 获取图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();

    // 5. 关闭上下文
    UIGraphicsEndImageContext();

    return screenShot;
}

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)yc_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)yc_colorAtPoint:(CGPoint)point {
    if (point.x < 0 || point.y < 0) return nil;

    CGImageRef imageRef = self.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    if (point.x >= width || point.y >= height) return nil;

    unsigned char *rawData = malloc(height * width * 4);
    if (!rawData) return nil;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData,
            width,
            height,
            bitsPerComponent,
            bytesPerRow,
            colorSpace,
            kCGImageAlphaPremultipliedLast
                    | kCGBitmapByteOrder32Big);
    if (!context) {
        free(rawData);
        return nil;
    }
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);

    int byteIndex = (bytesPerRow * point.y) + point.x * bytesPerPixel;
    CGFloat red = (rawData[byteIndex] * 1.0) / 255.0;
    CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue = (rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;

    UIColor *result = nil;
    result = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    free(rawData);
    return result;
}

/**
 *  @brief  取某一像素的颜色
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)yc_colorAtPixel:(CGPoint)point {
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }

    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {0, 0, 0, 0};
    CGContextRef context = CGBitmapContextCreate(pixelData,
            1,
            1,
            bitsPerComponent,
            bytesPerRow,
            colorSpace,
            kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);

    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY - (CGFloat) height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat) width, (CGFloat) height), cgImage);
    CGContextRelease(context);

    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red = (CGFloat) pixelData[0] / 255.0f;
    CGFloat green = (CGFloat) pixelData[1] / 255.0f;
    CGFloat blue = (CGFloat) pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat) pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)yc_hasAlphaChannel {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */

+ (UIImage *)yc_covertToGrayImageFromImage:(UIImage *)sourceImage {
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);

    if (context == NULL) {
        return nil;
    }

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);

    return grayImage;
}

// base64“加密”密码 无论是编码解码还是加密解密 都是直接操作的二进制数据
- (NSString *)base64Encode {
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    return [data base64EncodedStringWithOptions:0];
}

+ (UIImage *)base64DecodedImageWith:(NSString *)base64String {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    return [UIImage imageWithData:data];
}

@end
