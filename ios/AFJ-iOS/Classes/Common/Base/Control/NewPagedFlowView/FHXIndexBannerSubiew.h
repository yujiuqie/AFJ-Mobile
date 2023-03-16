//
//  ViewController.swift
//  CarPictureRotary
//
//  Created by 冯汉栩 on 2019/1/20.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHXIndexBannerSubiew : UIView

/**
 *  主图
 */
@property(nonatomic, strong) UIImageView *mainImageView;

/**
 *  用来变色的view
 */
@property(nonatomic, strong) UIView *coverView;

@property(nonatomic, copy) void (^didSelectCellBlock)(NSInteger tag, FHXIndexBannerSubiew *cell);

/**
 设置子控件frame,继承后要重写

 @param superViewBounds <#superViewBounds description#>
 */
- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds;

@end
