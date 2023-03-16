//
//  UIViewController+CZAddition.m
//
//  Created by 刘凡 on 16/5/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

@implementation UIViewController (CZAddition)

- (void)cz_addChildController:(UIViewController *)childController intoView:(UIView *)view {

    [self addChildViewController:childController];

    [view addSubview:childController.view];

    [childController didMoveToParentViewController:self];
}


/// 判断当前是否显示本视图控制器
- (BOOL)isVisible {
    return (self.isViewLoaded && self.view.window);
}

@end
