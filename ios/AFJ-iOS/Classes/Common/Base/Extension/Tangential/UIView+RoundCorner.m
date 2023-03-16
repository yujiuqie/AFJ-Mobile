//
//  UIImageSize.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/3/28.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

@implementation UIView (RoundCorner)
/**
 给view设置圆角
 
 @param corners 圆角位置
 @param cornerRadii 圆角弧度
 */
- (void)setCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    //??:两个cornerRadii宽高不一样会怎样
    //测试结果显示，虽然cornerRadii类型是CGSize但是圆角半径其实取的是size中的width

    //TODO:能否做到设置不同的角有不同半径的圆角

    //给self视图添加圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;

    self.layer.mask = maskLayer;

}


@end
