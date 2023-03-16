//
//  FHXPlaceholderTextView.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/11/8.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

#import "FHXPlaceholderTextView.h"

@interface FHXPlaceholderTextView ()

/* 占位文字label */
@property(strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation FHXPlaceholderTextView
/** 顶部边距 */
- (void)setPlaceholderTopDistance:(CGFloat)placeholderTopDistance {
    _placeholderTopDistance = placeholderTopDistance;
    self.placeholderLabel.ocTop = self.placeholderTopDistance + 4;
}

/** 左边边距 */
- (void)setPlaceholderLeftDistance:(CGFloat)placeholderLeftDistance {
    _placeholderLeftDistance = placeholderLeftDistance;
    self.placeholderLabel.ocLeft = self.placeholderLeftDistance + 5;
}

#pragma mark - 占位Label

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        //添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //竖直方向永远有弹簧效果
        self.alwaysBounceVertical = YES;
        //监听文字改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //竖直方向永远有弹簧效果
        self.alwaysBounceVertical = YES;
        //监听文字改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}


#pragma mark - 重写setter

/** 占位符颜色 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;

    self.placeholderLabel.textColor = placeholderColor;
}

/** 占位符文字 */
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;

}

/** 占位符文字大小 */
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    self.placeholderLabel.font = _placeholderFont;
}


#pragma mark - 监听占位文字改变

- (void)textDidChange {
    //占位文字显示是还是隐藏
    self.placeholderLabel.hidden = self.hasText;
}

/**
 * 更新占位文字的尺寸
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.placeholderLabel sizeToFit];//自适应Label宽高
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
