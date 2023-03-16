//
//  UIView+CZAddition.m
//
//  Created by 刘凡 on 16/5/11.
//  Copyright © 2016年 itheima. All rights reserved.
//

@implementation UIView (CZAddition)

- (UIImage *)cz_snapshotImage {

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);

    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];

    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return result;
}


+ (UINavigationController *)getCurrentNavigationController {
    if (![[UIApplication sharedApplication].windows.lastObject isKindOfClass:[UIWindow class]]) {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getCurrentNavigationControllerFrom:rootViewController];
}

+ (UINavigationController *)getCurrentNavigationControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nc = ((UITabBarController *) vc).selectedViewController;
        return [self getCurrentNavigationControllerFrom:nc];
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *) vc).presentedViewController) {
            return [self getCurrentNavigationControllerFrom:((UINavigationController *) vc).presentedViewController];
        }
        return [self getCurrentNavigationControllerFrom:((UINavigationController *) vc).topViewController];
    } else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.presentedViewController) {
            return [self getCurrentNavigationControllerFrom:vc.presentedViewController];
        } else {
            return vc.navigationController;
        }
    } else {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
}


#pragma mark - XIB设置圆角

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

#pragma mark - XIB 设置边框颜色和宽度

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}


- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;   //----取值
    frame.origin.x = x;    //----赋值
    self.frame = frame;     //----把值返回
}

- (CGFloat)x {
    return self.frame.origin.x;
}


- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}


- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}


- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setRadio {
    [self.layer setCornerRadius:5];
    [self.layer setMasksToBounds:YES];
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}


- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

#pragma mark - 设置View任意角为圆角

/// 设置View任意角度为圆角
/// @param view 待设置的view
/// @param viewSize view的size
/// @param corners 设置的角，左上、左下、右上、右下，可以组合
/// 如左下和右上 (UIRectCornerBottomLeft | UIRectCornerTopRight)
/// @param radius 圆角的半径
- (void)setCornerWithView:(UIView *)view
                 viewSize:(CGSize)viewSize
                  corners:(UIRectCorner)corners
                   radius:(CGFloat)radius {
    CGRect fr = CGRectZero;
    fr.size = viewSize;

    UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:fr byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];

    CAShapeLayer *shape = [[CAShapeLayer alloc] init];

    [shape setPath:round.CGPath];
    view.layer.mask = shape;
}

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
              borderColor:(UIColor *)borderColor {
    CGRect fr = CGRectZero;
    fr.size = viewSize;

    UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:fr byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];

    CAShapeLayer *shape = [[CAShapeLayer alloc] init];

    [shape setPath:round.CGPath];
    shape.strokeColor = borderColor.CGColor;
    shape.fillColor = [UIColor clearColor].CGColor;
    [view.layer addSublayer:shape];
}
@end
