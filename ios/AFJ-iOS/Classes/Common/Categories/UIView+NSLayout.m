//
//  UIView+NSLayout.m
//  XWJSC
//
//  Created by xuewu.long on 16/12/13.
//  Copyright © 2016年 fmylove. All rights reserved.
//

@implementation UIView (NSLayout)


- (void)readyForLayout {
    /* 如果要使用LayoutConstrai， 必须设置此项    对于View来说，默认是YES，可以通过frame进行尺寸约束。*/
    self.translatesAutoresizingMaskIntoConstraints = NO;
}


/**
 对于 无需toItem对象的约束设置，
 1. toItem：nil 即可
 2. 直接在本对象上添加约束 self addConstraint：
 */
- (void)layoutWidth:(CGFloat)width {
    [self readyForLayout];
    [self addConstraint:[NSLayoutConstraint
            constraintWithItem:self
                     attribute:NSLayoutAttributeWidth
                     relatedBy:NSLayoutRelationEqual
                        toItem:nil
                     attribute:NSLayoutAttributeNotAnAttribute
                    multiplier:1
                      constant:width]];
}

- (void)layoutHeight:(CGFloat)height {
    [self readyForLayout];
    [self addConstraint:[NSLayoutConstraint
            constraintWithItem:self
                     attribute:NSLayoutAttributeHeight
                     relatedBy:NSLayoutRelationEqual
                        toItem:nil
                     attribute:NSLayoutAttributeNotAnAttribute
                    multiplier:1
                      constant:height]];
}


/**
 对于存在相对关系的约束设置，
  1. 则toItem：_Nonnull  为关系对象（可能是superView， 也可能是和自己同级的item）
  2. 约束添加对象， 需要是当前对象的父视图。
 */
- (void)layoutTop:(CGFloat)top {
    [self readyForLayout];
    [self.superview addConstraint:[NSLayoutConstraint
            constraintWithItem:self
                     attribute:NSLayoutAttributeTop
                     relatedBy:NSLayoutRelationEqual
                        toItem:self.superview
                     attribute:NSLayoutAttributeTop
                    multiplier:1
                      constant:top]];
}

- (void)layoutLeft:(CGFloat)left {
    [self readyForLayout];
    [self.superview addConstraint:[NSLayoutConstraint
            constraintWithItem:self
                     attribute:NSLayoutAttributeLeft
                     relatedBy:NSLayoutRelationEqual
                        toItem:self.superview
                     attribute:NSLayoutAttributeLeft
                    multiplier:1
                      constant:left]];
}

- (void)layoutRight:(CGFloat)right {
    [self readyForLayout];
    [self.superview addConstraint:[NSLayoutConstraint
            constraintWithItem:self
                     attribute:NSLayoutAttributeRight
                     relatedBy:NSLayoutRelationEqual
                        toItem:self.superview
                     attribute:NSLayoutAttributeRight
                    multiplier:1
                      constant:-right]];
}

- (void)layoutBottom:(CGFloat)bottom {
    [self readyForLayout];
    [self.superview addConstraint:[NSLayoutConstraint
            constraintWithItem:self
                     attribute:NSLayoutAttributeBottom
                     relatedBy:NSLayoutRelationEqual
                        toItem:self.superview
                     attribute:NSLayoutAttributeBottom
                    multiplier:1
                      constant:-bottom]];
}


- (void)layoutAuthor:(CGPoint)point; {
    [self layoutLeft:point.x];
    [self layoutTop:point.y];
}

- (void)layoutSize:(CGSize)size {
#if 0
    [self layoutWidth:size.width];
    [self layoutHeight:size.height];
#else

    [self readyForLayout];

    NSLayoutConstraint *wC = [NSLayoutConstraint
            constraintWithItem:self
                     attribute:NSLayoutAttributeWidth
                     relatedBy:NSLayoutRelationEqual
                        toItem:nil
                     attribute:NSLayoutAttributeNotAnAttribute
                    multiplier:1
                      constant:size.width];

    NSLayoutConstraint *hC = [NSLayoutConstraint
            constraintWithItem:self
                     attribute:NSLayoutAttributeHeight
                     relatedBy:NSLayoutRelationEqual
                        toItem:nil
                     attribute:NSLayoutAttributeNotAnAttribute
                    multiplier:1
                      constant:size.height];

    [self addConstraints:@[wC, hC]];
#endif

}


- (void)relation:(NSLayoutRelation)relation
          toItem:(nullable UIView *)toView
    desAttribute:(NSLayoutAttribute)desAttri
     toAttribute:(NSLayoutAttribute)toAttri
      multiplier:(CGFloat)multiplier
        constant:(CGFloat)constant {
    [self readyForLayout];
    [self.superview addConstraint:[NSLayoutConstraint
            constraintWithItem:self
                     attribute:desAttri
                     relatedBy:relation
                        toItem:toView
                     attribute:toAttri
                    multiplier:multiplier
                      constant:constant]];

}

- (void)relation:(NSLayoutRelation)relation toItem:(UIView *_Nonnull)toView spanH:(CGFloat)spanH {
    [self relation:relation
            toItem:toView
      desAttribute:NSLayoutAttributeRight
       toAttribute:NSLayoutAttributeLeft
        multiplier:1
          constant:-spanH];
}

- (void)leftSpan:(CGFloat)spanH toItem:(UIView *_Nonnull)toView; {
    [self relation:NSLayoutRelationEqual
            toItem:toView
      desAttribute:NSLayoutAttributeLeft
       toAttribute:NSLayoutAttributeRight
        multiplier:1
          constant:spanH];
}

- (void)rightSpan:(CGFloat)spanH toItem:(UIView *_Nonnull)toView; {
    [self relation:NSLayoutRelationEqual
            toItem:toView
      desAttribute:NSLayoutAttributeRight
       toAttribute:NSLayoutAttributeLeft
        multiplier:1
          constant:-spanH];
}

- (void)topSpan:(CGFloat)spanV toItem:(UIView *_Nonnull)toView; {
    [self relation:NSLayoutRelationEqual
            toItem:toView
      desAttribute:NSLayoutAttributeTop
       toAttribute:NSLayoutAttributeBottom
        multiplier:1
          constant:spanV];
}

- (void)bottomSpan:(CGFloat)spanV toItem:(UIView *_Nonnull)toView; {
    [self relation:NSLayoutRelationEqual
            toItem:toView
      desAttribute:NSLayoutAttributeBottom
       toAttribute:NSLayoutAttributeTop
        multiplier:1
          constant:-spanV];
}


- (void)equalAttribute:(NSLayoutAttribute)attribute toItem:(UIView *_Nonnull)toView; {
    [self relation:NSLayoutRelationEqual
            toItem:toView
      desAttribute:attribute
       toAttribute:attribute
        multiplier:1
          constant:0];
}


@end
