//
//  FHXNavigationController.m
//  Navigation和TarBar
//
//  Created by 冯汉栩一体机 on 2018/7/13.
//  Copyright © 2018年 com.fenghanxu.demol. All rights reserved.
//

@interface FHXNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation FHXNavigationController

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //设置不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置背景为白色
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    //把导航栏底部的灰线改为白色
    self.navigationBar.shadowImage = [UIImage createImageWithColor:[Color line]];
    //把ContentView的白色设置为白色
    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    //设置标题栏颜色
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:18]};

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    //全部修改返回按钮,但是会失去右滑返回的手势
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count >= 1) {

        UIImage *image = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];

        self.hidesBottomBarWhenPushed = YES;
        self.tabBarController.tabBar.hidden = YES;

    }

    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    /**这里解决  手势右滑返回到根控制器  显示tabBar控制器**/
    // 当前页控制器和跳转后的控制器
    //如果当前控制器是倒数第二个控制器点击返回按键的时候就把tabbar显示回出来
    if (self.viewControllers.count == 1) {
        //设置显示tabbar按键
        self.hidesBottomBarWhenPushed = NO;
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)backBtnClick {
    [self popViewControllerAnimated:YES];
    //如果当前控制器是倒数第二个控制器点击返回按键的时候就把tabbar显示回出来
    if (self.viewControllers.count == 1) {
        //设置显示tabbar按键
        self.hidesBottomBarWhenPushed = NO;
        self.tabBarController.tabBar.hidden = NO;
    }

}

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0) {
    //下面的代码是之前检测ShopListViewController控制器跳去ProductDetailVC的时候做对应的转场动画用到的。
//  if (([NSStringFromClass([fromVC class]) isEqual:@"ShopListViewController"] && [NSStringFromClass([toVC class]) isEqual:@"ProductDetailVC"]) || ([NSStringFromClass([fromVC class]) isEqual:@"ProductDetailVC"] && [NSStringFromClass([toVC class]) isEqual:@"ShopListViewController"])) {
//    return [FHXNavTransition transitionWithType:operation == UINavigationControllerOperationPush ? FHXNavTransitionPush : FHXNavTransitionPop WithImage:self.icon byCellStartRect:self.startRect byCellEndRect:self.endRect];
//  } else {
//    return nil;
//  }
    return nil;
}

@end

