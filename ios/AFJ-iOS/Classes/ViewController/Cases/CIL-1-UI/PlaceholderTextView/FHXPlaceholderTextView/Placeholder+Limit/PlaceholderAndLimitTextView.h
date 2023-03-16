//
//  PlaceholderAndLimitTextView.h
//  Frame
//
//  Created by 冯汉栩 on 2021/5/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PlaceholderAndLimitTextView;

@protocol PlaceholderAndLimitTextViewDelegate <NSObject>

- (void)placeholderAndLimitTextView:(PlaceholderAndLimitTextView *)textView returnCurrentValue:(NSString *)value;

@end

@interface PlaceholderAndLimitTextView : UIView

@property(nonatomic, weak) id <PlaceholderAndLimitTextViewDelegate> delegate;

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

/** textView背景颜色 */
@property(nonatomic, strong) UIColor *bgColor;

/** textView内容文字大小 */
@property(nonatomic, strong) UIFont *contentFont;

/** 限制文字大小 */
@property(nonatomic, strong) UIFont *limitFont;

/** 限制文字颜色 */
@property(nonatomic, strong) UIColor *limitColor;

/** 限制文字总数 */
@property(nonatomic, assign) NSInteger limitAllCount;

/** 当前文字个数 */
@property(nonatomic, assign) NSInteger limitCurrentCount;

@end

NS_ASSUME_NONNULL_END
