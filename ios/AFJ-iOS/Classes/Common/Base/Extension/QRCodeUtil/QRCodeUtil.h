//
//  QRCodeUtil.h
//  SDBank_iOS
//
//  Created by sdebank on 2021/9/18.
//  Copyright © 2021 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCodeUtil : NSObject
/**
 *  生成二维码图片
 *
 *  @param QRString  二维码内容
 *  @param sizeWidth 图片size（正方形）
 *  @param color     填充色
 *
 *  @return  二维码图片
 */
+ (UIImage *)createQRimageString:(NSString *)QRString sizeWidth:(CGFloat)sizeWidth fillColor:(UIColor *)color;

/**
 *  读取图片中二维码信息
 *
 *  @param image 图片
 *
 *  @return 二维码内容
 */
+ (NSString *)readQRCodeFromImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
