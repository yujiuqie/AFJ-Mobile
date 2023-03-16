//
//  UIView+NSLayout.h
//  XWJSC
//
//  Created by xuewu.long on 16/12/13.
//  Copyright © 2016年 fmylove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NSLayout)

#pragma mark base set

- (void)layoutWidth:(CGFloat)width;

- (void)layoutHeight:(CGFloat)height;

- (void)layoutTop:(CGFloat)top;

- (void)layoutLeft:(CGFloat)left;

- (void)layoutRight:(CGFloat)right;

- (void)layoutBottom:(CGFloat)bottom;

#pragma mark  two-dimension set

- (void)layoutSize:(CGSize)size;

- (void)layoutAuthor:(CGPoint)point;

#pragma mark relation dimension set

- (void)relation:(NSLayoutRelation)relation
          toItem:(nullable UIView *)toView
    desAttribute:(NSLayoutAttribute)desAttri
     toAttribute:(NSLayoutAttribute)toAttri
      multiplier:(CGFloat)multiplier
        constant:(CGFloat)constant;

- (void)leftSpan:(CGFloat)spanH toItem:(UIView *_Nonnull)toView;

- (void)rightSpan:(CGFloat)spanH toItem:(UIView *_Nonnull)toView;

- (void)topSpan:(CGFloat)spanV toItem:(UIView *_Nonnull)toView;

- (void)bottomSpan:(CGFloat)spanV toItem:(UIView *_Nonnull)toView;

- (void)equalAttribute:(NSLayoutAttribute)attribute toItem:(UIView *_Nonnull)toView;


/*
 约束的大量叠加使用，is not a good ideal
 这里只是为了掩饰怎么使用约束。
 */

@end
