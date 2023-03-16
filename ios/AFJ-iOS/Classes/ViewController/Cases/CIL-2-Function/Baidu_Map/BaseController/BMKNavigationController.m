//
//  BMKNavigationController.m
//  BaiduMapSDKDemo
//
//  Created by baidu on 2020/5/26.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKNavigationController.h"

@implementation BMKNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        //导航栏颜色
        self.navigationBar.barTintColor = [COLOR(0x22253D) colorWithAlphaComponent:1.0];
        //导航栏字体颜色
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        //隐藏导航返回按钮文字
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-320, 0)
                                                             forBarMetrics:UIBarMetricsDefault];
        //设置导航返回按钮颜色
        self.navigationBar.tintColor = [UIColor whiteColor];

    }
    return self;
}

@end
