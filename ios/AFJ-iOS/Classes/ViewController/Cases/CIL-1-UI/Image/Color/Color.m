//
//  Color.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/3/23.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

@implementation Color

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1];
}

+ (UIColor *)theme {
    return [UIColor colorWithHexString:@"#cd001e"];
}

+ (UIColor *)themeLight {
    return [UIColor colorWithHexString:@"#ff5000"];
}

+ (UIColor *)themeShallow {
    return [UIColor colorWithHexString:@"#F08080"];
}

+ (UIColor *)themeWeak {
    return [UIColor colorWithHexString:@"#fcf0f2"];
}

+ (UIColor *)textBlank {
    return [UIColor colorWithHexString:@"#333333"];
}

+ (UIColor *)textSub {
    return [UIColor colorWithHexString:@"#8c8c8c"];
}

+ (UIColor *)nonActivated {
    return [UIColor colorWithHexString:@"#bebebe"];
}

+ (UIColor *)textLine {
    return [UIColor colorWithHexString:@"#dddddd"];
}

+ (UIColor *)line {
    return [UIColor colorWithHexString:@"#e5e5e5"];
}

+ (UIColor *)backgroung {
    return [UIColor colorWithHexString:@"#F5F5F5"];
}

+ (UIColor *)assist {
    return [UIColor colorWithHexString:@"#ffac03"];
}

+ (UIColor *)assistDeep {
    return [UIColor colorWithHexString:@"#f4a400"];
}

+ (UIColor *)greenLight {
    return [UIColor colorWithHexString:@"#82a542"];
}

+ (UIColor *)greenDeep {
    return [UIColor colorWithHexString:@"#6d7b52"];
}

+ (UIColor *)greenDeepLight {
    return [UIColor colorWithHexString:@"#75953c"];
}

+ (UIColor *)royalBlue {
    return [UIColor colorWithHexString:@"#4169E1"];
}

+ (UIColor *)bisque {
    return [UIColor colorWithHexString:@"#FAEBD7"];
}

+ (UIColor *)limeGreen {
    return [UIColor colorWithHexString:@"#3CB371"];
}

+ (UIColor *)doderBlue {
    return [UIColor colorWithHexString:@"#00A4E3"];
}

+ (UIColor *)tan {
    return [UIColor colorWithHexString:@"#A58561"];
}

+ (UIColor *)textTheme {
    return [UIColor colorWithHexString:@"#010101"];
}

+ (UIColor *)robed {
    return [UIColor colorWithHexString:@"#e56a7e"];
}

@end
