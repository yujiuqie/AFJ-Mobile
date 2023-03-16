//
//  UIView+FHXExtView.m
//  OCDemol
//
//  Created by 冯汉栩 on 2018/9/15.
//  Copyright © 2018年 com.fenghanxu.demol. All rights reserved.
//

@implementation UIView (FHXExtView)

- (void)setOcWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)ocWidth {
    return self.frame.size.width;
}

- (void)setOcHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)ocHeight {
    return self.frame.size.height;
}

- (void)setOcLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)ocLeft {
    return self.frame.origin.x;
}

- (void)setOcTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)ocTop {
    return self.frame.origin.y;
}

- (void)setOcRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = self.superview.bounds.size.width - self.bounds.size.width - right;
    self.frame = frame;
}

- (CGFloat)ocRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setOcBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = self.superview.bounds.size.height - self.bounds.size.height - bottom;
    self.frame = frame;
}

- (CGFloat)ocBottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setOcCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)ocCenterX {
    return self.center.x;
}

- (void)setOcCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)ocCenterY {
    return self.center.y;
}

- (void)setOcOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)ocOrigin {
    return self.frame.origin;
}

- (void)setOcSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)ocSize {
    return self.frame.size;
}

@end
