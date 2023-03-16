//
//  AFJAnimationBaseViewController.h
//  侧滑菜单
//
//  Created by yixiang on 15/7/18.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "AFJRootViewController.h"
#import "TitleButton.h"

@interface AFJAnimationBaseViewController : AFJRootListViewController

/**
 *  当前Controller的标题
 *
 *  @return 标题
 */
- (NSString *)controllerTitle;

/**
 *  初始化View
 */
- (void)initView;

/**
 *  按钮操作区的数组元素
 *
 *  @return 数组
 */
- (NSArray *)operateTitleArray;

/**
 *  每个按钮的点击时间
 *
 *  @param btn 
 */
- (void)clickBtn:(UIButton *)btn;

@end
