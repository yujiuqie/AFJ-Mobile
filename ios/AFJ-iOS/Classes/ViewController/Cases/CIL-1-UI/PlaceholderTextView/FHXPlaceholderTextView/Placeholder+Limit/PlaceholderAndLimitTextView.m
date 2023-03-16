//
//  PlaceholderAndLimitTextView.m
//  Frame
//
//  Created by 冯汉栩 on 2021/5/26.
//

#import "PlaceholderAndLimitTextView.h"
#import "FHXPlaceholderTextView.h"
#import "NerdyUI.h"

@interface PlaceholderAndLimitTextView () <UITextViewDelegate>
@property(nonatomic, strong) FHXPlaceholderTextView *textView;
@property(nonatomic, strong) UILabel *limintLabel;
@end

@implementation PlaceholderAndLimitTextView

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textView.placeholder = _placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.textView.placeholderColor = _placeholderColor;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    self.textView.placeholderFont = _placeholderFont;
}

- (void)setPlaceholderTopDistance:(CGFloat)placeholderTopDistance {
    _placeholderTopDistance = placeholderTopDistance;
    self.textView.placeholderTopDistance = _placeholderTopDistance;
    // 使用textContainerInset设置top、left、botto, right
    self.textView.textContainerInset = UIEdgeInsetsMake(_placeholderLeftDistance, _placeholderTopDistance, 5, 5);
    //当光标在最后一行时，始终显示低边距，需使用contentInset设置bottom.
    self.textView.contentInset = UIEdgeInsetsMake(0, 0, _placeholderLeftDistance, 0);
    //防止在拼音打字时抖动
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
}

- (void)setPlaceholderLeftDistance:(CGFloat)placeholderLeftDistance {
    _placeholderLeftDistance = placeholderLeftDistance;
    self.textView.placeholderLeftDistance = _placeholderLeftDistance;
    // 使用textContainerInset设置top、left、botto, right
    self.textView.textContainerInset = UIEdgeInsetsMake(_placeholderLeftDistance, _placeholderTopDistance, 5, 5);
    //当光标在最后一行时，始终显示低边距，需使用contentInset设置bottom.
    self.textView.contentInset = UIEdgeInsetsMake(0, 0, _placeholderLeftDistance, 0);
    //防止在拼音打字时抖动
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.textView.bgColor(_bgColor);
}

- (void)setContentFont:(UIFont *)contentFont {
    _contentFont = contentFont;
    self.textView.font = _contentFont;
}

- (void)setLimitFont:(UIFont *)limitFont {
    _limitFont = limitFont;
    self.limintLabel.font = _limitFont;
}

- (void)setLimitColor:(UIColor *)limitColor {
    _limitColor = limitColor;
    self.limintLabel.textColor = _limitColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self buildUI];
    return self;
}

- (void)setLimitAllCount:(NSInteger)limitAllCount {
    _limitAllCount = limitAllCount;
    self.limintLabel.text = [NSString stringWithFormat:@"%ld/%ld", _limitCurrentCount, _limitAllCount];
}

- (void)setLimitCurrentCount:(NSInteger)limitCurrentCount {
    _limitCurrentCount = limitCurrentCount;
    self.limintLabel.text = [NSString stringWithFormat:@"%ld/%ld", _limitCurrentCount, _limitAllCount];
}

- (void)buildUI {
    self.backgroundColor = [Color backgroung];

    self.textView = [FHXPlaceholderTextView new];
    self.textView.addTo(self);

    self.limintLabel = [UILabel new];
    [self addSubview:self.limintLabel];

}

- (void)layoutSubviews {
    [super layoutSubviews];


    self.textView.xywh(0, 0, self.bounds.size.width, self.bounds.size.height - self.limintLabel.bounds.size.height - 5);
    self.textView.delegate = self;

    [self.limintLabel sizeToFit];
    self.limintLabel.ocLeft = self.bounds.size.width - self.limintLabel.bounds.size.width - 15;
    self.limintLabel.ocBottom = 20;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length >= _limitAllCount) {
        self.limintLabel.text = [NSString stringWithFormat:@"%ld/%ld", _limitAllCount, _limitAllCount];
        [self.limintLabel sizeToFit];
        NSString *value = [textView.text substringToIndex:_limitAllCount];
        self.textView.text = value;
        if ([self.delegate respondsToSelector:@selector(placeholderAndLimitTextView:returnCurrentValue:)]) {
            [self.delegate placeholderAndLimitTextView:self returnCurrentValue:value];
        }
    } else {
        self.limintLabel.text = [NSString stringWithFormat:@"%ld/%ld", textView.text.length, _limitAllCount];
        [self.limintLabel sizeToFit];
        if ([self.delegate respondsToSelector:@selector(placeholderAndLimitTextView:returnCurrentValue:)]) {
            [self.delegate placeholderAndLimitTextView:self returnCurrentValue:textView.text];
        }
    }
}

@end
