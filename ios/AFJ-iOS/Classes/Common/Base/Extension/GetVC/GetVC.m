//
//  GetVC.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/3/18.
//  Copyright © 2019年 com.fenghanxu.demol. All rights reserved.
//

@implementation GetVC

//获取Win
+ (UIWindow *)getCurrentWindow {
    if ([[[UIApplication sharedApplication] delegate] window]) {
        return [[[UIApplication sharedApplication] delegate] window];
    } else {
        if (@available(iOS 13.0, *)) {
            NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene *windowScene = (UIWindowScene *) array[0];
            UIWindow *mainWindow = [windowScene valueForKeyPath:@"delegate.window"];
            if (mainWindow) {
                return mainWindow;
            } else {
                return [UIApplication sharedApplication].windows.lastObject;
            }
        } else {
            return [UIApplication sharedApplication].keyWindow;
        }
    }
}

+ (UIViewController *)getRootViewController {

    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+ (UIViewController *)getCurrentViewController {

    UIViewController *currentViewController = [self getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {

            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {

            UINavigationController *navigationController = (UINavigationController *) currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];

        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {

            UITabBarController *tabBarController = (UITabBarController *) currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {

            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {

                currentViewController = currentViewController.childViewControllers.lastObject;

                return currentViewController;
            } else {

                return currentViewController;
            }
        }

    }
    return currentViewController;
}


//获取当前所在的TabBarController
+ (FHXTabBarController *)tabbarController {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIViewController *tabbarController = window.rootViewController;
    if ([tabbarController isKindOfClass:[FHXTabBarController class]]) {
        return (FHXTabBarController *) tabbarController;
    }
    return nil;

}

//获取当前TabBarController所选中的
+ (FHXNavigationController *)currentTabbarSelectedNavigationController {
    FHXTabBarController *tabbarController = [GetVC tabbarController];
    FHXNavigationController *selectedNV = (FHXNavigationController *) tabbarController.selectedViewController;
    if ([selectedNV isKindOfClass:[FHXNavigationController class]]) {
        return selectedNV;
    }
    return nil;
}

//获取当前所在控制器 方法一
+ (UIViewController *)getCurrentViewControllerFrist {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIViewController *rootVC = window.rootViewController;
    UIViewController *presentedViewController = rootVC.presentedViewController;
    if (presentedViewController != nil) {
        if ([presentedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nv = (UINavigationController *) presentedViewController;
            return [nv.viewControllers lastObject];
        } else {
            return presentedViewController;
        }
    } else {
        return nil;
    }
}

//获取当前所在控制器 方法二
+ (UIViewController *)getCurrentViewControllerSecond {
    UINavigationController *selectedNV = [GetVC currentTabbarSelectedNavigationController];
    if (selectedNV.viewControllers.count > 1) {
        return [selectedNV.viewControllers lastObject];
    }
    return nil;
}

//通过View获取View所在的控制器
+ (UIViewController *)getViewcontrollerView:(UIView *)view {

    UIViewController *vc = nil;
    for (UIView *temp = view; temp; temp = temp.superview) {
        if ([temp.nextResponder isKindOfClass:[UIViewController class]]) {
            vc = (UIViewController *) temp.nextResponder;
            break;
        }
    }
    return vc;
}

//通过递归方法遍历当前View的所有子试图
+ (void)getMysubViewsWithCurrentViews:(UIView *)currentView byViewName:(NSString *)viewName {
    NSArray *arrayViews = currentView.subviews;
    for (UIView *obj in arrayViews) {
        Class cls = NSClassFromString(viewName);
        UIView *view = [[cls alloc] init];
        if ([obj isKindOfClass:[view class]]) {
            NSLog(@"找到了 %@", view);
        }
        [self getMysubViewsWithCurrentViews:obj byViewName:viewName];
    }
}

@end
