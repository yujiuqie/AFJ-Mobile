//
//  CustomVCTransitionViewController.m
//  POPDemo
//
//  Created by Qilin Hu on 2020/5/9.
//  Copyright © 2020 Shanghai Haidian Information Technology Co.Ltd. All rights reserved.
//

#import "CustomVCTransitionViewController.h"

// Frameworks
#import <POP.h>

// Controllers
#import "DismissingAnimationController.h"
#import "PresentingAnimationController.h"
#import "CustomModalViewController.h"

@interface CustomVCTransitionViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation CustomVCTransitionViewController


#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((SCREENW - 200) / 2.0, 120, 200, 80);
        [btn setTitle:@"演示" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(200, 80) direction:ZQGradientChangeDirectionLevel startColor:[UIColor redColor] endColor:[UIColor greenColor]];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(didClickOnPresent) forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - Actions

- (void)didClickOnPresent {
    CustomModalViewController *modalVC = [[CustomModalViewController alloc] init];

    // 设置当前视图控制器实现「转场过渡动画」
    modalVC.transitioningDelegate = self;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;

    [self.navigationController presentViewController:modalVC animated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitionDelegate

// 用于展现 modal view controller 的转场动画
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[PresentingAnimationController alloc] init];
}

// 页面消失的动画
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissingAnimationController alloc] init];
}

@end
