//
//  UIView+FHXExtView.h
//  OCDemol
//
//  Created by 冯汉栩 on 2018/9/15.
//  Copyright © 2018年 com.fenghanxu.demol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FHXExtView)

// 自动创建get  和 set 方法。
// 自动创建get  和 set 方法。
@property(nonatomic, assign) CGFloat ocWidth;
@property(nonatomic, assign) CGFloat ocHeight;

@property(nonatomic, assign) CGFloat ocLeft;
@property(nonatomic, assign) CGFloat ocTop;
@property(nonatomic, assign) CGFloat ocRight;
@property(nonatomic, assign) CGFloat ocBottom;
@property(nonatomic, assign) CGFloat ocCenterX;
@property(nonatomic, assign) CGFloat ocCenterY;
@property(nonatomic, assign) CGPoint ocOrigin;
@property(nonatomic, assign) CGSize ocSize;

@end
