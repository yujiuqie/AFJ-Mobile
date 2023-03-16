//
//  FHXMainTitleBtn.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/12/31.
//  Copyright © 2019 fenghanxu.compang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHXLeftTitleBtn : UIControl

@property(nonatomic, assign) CGFloat width;//图片宽度

@property(nonatomic, assign) CGFloat height;//图片高度

@property(nonatomic, copy) NSString *iconName;

@property(nonatomic, copy) NSString *title;

@property(nonatomic, strong) UIColor *titleColor;

@property(nonatomic, assign) CGFloat fnt;

@property(nonatomic, strong) UIColor *backgroundColors;

@property(nonatomic, assign) NSTextAlignment textAlignments;//label对齐方式


@property(nonatomic, assign) CGFloat iconLeftDistance;

@property(nonatomic, assign) CGFloat titleLeftDistance;

@end

NS_ASSUME_NONNULL_END
