//
//  FHXNavigationController.h
//  Navigation和TarBar
//
//  Created by 冯汉栩一体机 on 2018/7/13.
//  Copyright © 2018年 com.fenghanxu.demol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHXNavigationController : UINavigationController

//缩放图片
@property(nonatomic, strong) UIImage *icon;
//动画起始位置
@property(nonatomic, assign) CGRect startRect;
//动画结束位置
@property(nonatomic, assign) CGRect endRect;

@end
