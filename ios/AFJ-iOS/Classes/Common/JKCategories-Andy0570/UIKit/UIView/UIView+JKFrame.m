//
//  UIView+JKFrame.m
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+JKFrame.h"

@implementation UIView (JKFrame)

- (void)setJk_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)jk_left {
    return CGRectGetMinX(self.frame);
}

- (void)setJk_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - CGRectGetWidth(self.frame);
    self.frame = frame;
}

- (CGFloat)jk_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setJk_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)jk_top {
    return CGRectGetMinY(self.frame);
}

- (void)setJk_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)jk_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setJk_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)jk_width {
    return CGRectGetWidth(self.frame);
}

- (void)setJk_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)jk_height {
    return CGRectGetHeight(self.frame);
}

- (void)setJk_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)jk_centerX {
    return self.center.x;
}

- (void)setJk_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)jk_centerY {
    return self.center.y;
}

- (void)setJk_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)jk_origin {
    return self.frame.origin;
}

- (void)setJk_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)jk_size {
    return self.frame.size;
}

@end
