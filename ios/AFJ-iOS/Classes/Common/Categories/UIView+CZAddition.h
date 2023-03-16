//
//  UIView+CZAddition.h
//
//  Created by 刘凡 on 16/5/11.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CZAddition)

/// 返回视图截图
- (UIImage *)cz_snapshotImage;

/// 获取当前view的导航控制器
+ (UINavigationController *)getCurrentNavigationController;


#pragma mark - XIB 设置圆角
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

#pragma mark - XIB 设置边框颜色和宽度
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;

@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGPoint origin;
@property(nonatomic, assign) CGSize size;

/// 设置View任意角度为圆角
/// @param view 待设置的view
/// @param viewSize view的size
/// @param corners 设置的角，左上、左下、右上、右下，可以组合
/// 如左下和右上 (UIRectCornerBottomLeft | UIRectCornerTopRight)
/// @param radius 圆角的半径
- (void)setCornerWithView:(UIView *)view
                 viewSize:(CGSize)viewSize
                  corners:(UIRectCorner)corners
                   radius:(CGFloat)radius;


/// 绘制view的圆角边框, 只是在view上画了一个圆角边框，并不会裁剪view
/// @param view 待设置的view
/// @param viewSize view的size
/// @param corners 设置的角，左上、左下、右上、右下，可以组合
/// 如左下和右上 (UIRectCornerBottomLeft | UIRectCornerTopRight)
/// @param radius 圆角的半径
/// @param borderColor 边框颜色
- (void)setCornerWithView:(UIView *)view
                 viewSize:(CGSize)viewSize
                  corners:(UIRectCorner)corners
                   radius:(CGFloat)radius
              borderColor:(UIColor *)borderColor;

- (void)setRadio;
@end
