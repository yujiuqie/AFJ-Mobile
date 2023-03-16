//
//  UIColor+Hex.h
//  OCDemol
//
//  Created by 冯汉栩 on 2019/3/17.
//  Copyright © 2019年 com.fenghanxu.demol. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

// 透明度固定为1，以0x开头的十六进制转换成的颜色   [UIColor colorWithHex:333333];
+ (UIColor *)colorWithHex:(long)hexColor;

// 0x开头的十六进制转换成的颜色,透明度可调整      [UIColor colorWithHex:123456 alpha:0.4];
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
//[UIColor colorWithHexString:@"#333333"];
//[UIColor colorWithHexString:@"0X333333"];
+ (UIColor *)colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
