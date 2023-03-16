//
//  GetVC.h
//  OCDemol
//
//  Created by 冯汉栩 on 2019/3/18.
//  Copyright © 2019年 com.fenghanxu.demol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FHXTabBarController.h"
#import "FHXNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetVC : NSObject

//获取Win
+ (UIWindow *)getCurrentWindow;

//获取跟控制器
+ (UIViewController *)getRootViewController;

//获取当前控制器
+ (UIViewController *)getCurrentViewController;

//获取当前所在的TabBarController
+ (FHXTabBarController *)tabbarController;

//获取当前TabBarController所选中的
+ (FHXNavigationController *)currentTabbarSelectedNavigationController;

//获取当前所在控制器 方法一
+ (UIViewController *)getCurrentViewControllerFrist;

//获取当前所在控制器 方法二
+ (UIViewController *)getCurrentViewControllerSecond;

//通过View获取View所在的控制器
+ (UIViewController *)getViewcontrollerView:(UIView *)view;

//通过递归方法遍历当前View的所有子试图
+ (void)getMysubViewsWithCurrentViews:(UIView *)currentView byViewName:(NSString *)viewName;

@end

NS_ASSUME_NONNULL_END
