//
//  GradualChange.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/6/19.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

@implementation GradualChange

/*
 view 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+ (void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {

    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = view.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint = startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = view.layer;
    view.frame = gradientLayer1.bounds;
}

/*
 control 是要设置渐变字体的控件   bgVIew是control的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+ (void)TextGradientControl:(UIControl *)control bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {

    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = control.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint = startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = control.layer;
    control.frame = gradientLayer1.bounds;
}


@end
