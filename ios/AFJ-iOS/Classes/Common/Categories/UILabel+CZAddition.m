//
//  UILabel+CZAddition.m
//
//  Created by 刘凡 on 16/4/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

@implementation UILabel (CZAddition)

+ (instancetype)cz_labelWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[self alloc] init];

    label.text = text;
    label.font = font;

    label.textColor = color;
    label.numberOfLines = 0;

    [label sizeToFit];

    return label;
}

@end
