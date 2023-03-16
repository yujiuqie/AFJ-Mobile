//
//  UIImageSize.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/3/28.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (RoundCorner)
/**
 给view设置圆角
 
 @param corners 圆角位置
 @param cornerRadii 圆角弧度
 */
- (void)setCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;


@end

NS_ASSUME_NONNULL_END
