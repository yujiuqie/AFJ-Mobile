//
//  FHXTabBarController.h
//  Navigation和TarBar
//
//  Created by 冯汉栩一体机 on 2018/7/13.
//  Copyright © 2018年 com.fenghanxu.demol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHXTabBarController : UITabBarController

- (void)setUpOneChildViewController:(UIViewController *)vc image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title;

@end
