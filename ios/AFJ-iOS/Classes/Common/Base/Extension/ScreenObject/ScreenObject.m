//
//  ScreensView.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/11/12.
//  Copyright © 2019 fenghanxu.compang.cn. All rights reserved.
//

@implementation ScreenObject

// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
// 判断刘海屏，返回YES表示是 非刘海屏   NO刘海屏
+ (BOOL)isNotchScreen {

    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return NO;
    }

    CGSize size = [UIScreen mainScreen].bounds.size;
    NSInteger notchValue = size.width / size.height * 100;

    if (216 == notchValue || 46 == notchValue) {
        return YES;
    }

    return NO;
}


@end
