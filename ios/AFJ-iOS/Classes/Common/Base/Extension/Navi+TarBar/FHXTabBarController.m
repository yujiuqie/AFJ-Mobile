//
//  FHXTabBarController.m
//  Navigation和TarBar
//
//  Created by 冯汉栩一体机 on 2018/7/13.
//  Copyright © 2018年 com.fenghanxu.demol. All rights reserved.
//

@interface FHXTabBarController () <UITabBarControllerDelegate>

@end

@implementation FHXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];//这个设置背景颜色不行 因为他在tint的后面
    self.delegate = self;
    [self.tabBar setBarTintColor:[UIColor whiteColor]];//设置背景颜色
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 添加一个子控制器

- (void)setUpOneChildViewController:(UIViewController *)vc image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTitleTextAttributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:12],
            NSForegroundColorAttributeName: [Color theme]
    }                            forState:UIControlStateSelected];

    [vc.tabBarItem setTitleTextAttributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:12],
            NSForegroundColorAttributeName: [Color textBlank]
    }                            forState:UIControlStateNormal];


    FHXNavigationController *nav = [[FHXNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    if (viewController == self.selectedViewController) {
        if (self.selectedIndex == 0) {
            NSLog(@"  ");
        }
        return NO;
    }
    return YES;
}


@end
