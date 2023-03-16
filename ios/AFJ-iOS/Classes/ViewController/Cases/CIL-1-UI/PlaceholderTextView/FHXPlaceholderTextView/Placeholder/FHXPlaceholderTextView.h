//
//  FHXPlaceholderTextView.h
//  OCDemol
//
//  Created by 冯汉栩 on 2019/11/8.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHXPlaceholderTextView : UITextView

/** 占位文字 */
@property(nonatomic, copy) NSString *placeholder;

/** 占位文字的颜色 */
@property(nonatomic, strong) UIColor *placeholderColor;

/** 占位文字的大小 */
@property(nonatomic, strong) UIFont *placeholderFont;

/** 占位文字的左边距离 */
@property(nonatomic, assign) CGFloat placeholderLeftDistance;

/** 占位文字的右边距离 */
@property(nonatomic, assign) CGFloat placeholderTopDistance;

@end

NS_ASSUME_NONNULL_END
