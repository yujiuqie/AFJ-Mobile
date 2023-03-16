//
//  BMKGlobalLocResultView.m
//  BMKGlobalLocOCDemo
//
//  Created by v_chiyuanwei on 2020/7/14.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKGlobalLocInfoView.h"


@interface BMKGlobalLocInfoView ()

@property(nonatomic, strong) UILabel *coldTitleLabel;
@property(nonatomic, strong) UILabel *hotTitleLabel;
@property(nonatomic, strong) UIView *sptrLine;
@property(nonatomic, strong) UITextView *coldInfoTextView;
@property(nonatomic, strong) UITextView *hotInfoTextView;

@end

@implementation BMKGlobalLocInfoView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        [self setupViews];
    }

    return self;
}

#pragma mark -

- (void)setupViews {
    [self addSubview:self.coldTitleLabel];
    [self addSubview:self.hotTitleLabel];
    [self addSubview:self.sptrLine];
    [self addSubview:self.coldInfoTextView];
    [self addSubview:self.hotInfoTextView];
}

#pragma mark -

- (void)setColdInfo:(NSString *)coldInfo {
    _coldInfo = coldInfo;

    self.coldInfoTextView.text = coldInfo;
}

- (void)setHotInfo:(NSString *)hotInfo {
    _hotInfo = hotInfo;

    self.hotInfoTextView.text = hotInfo;
}

#pragma mark -

- (UILabel *)coldTitleLabel {
    if (!_coldTitleLabel) {
        _coldTitleLabel = [[UILabel alloc] init];
        _coldTitleLabel.frame = CGRectMake((self.frame.size.width / 2 - 120) / 2, 5, 120, 25);
        _coldTitleLabel.font = [UIFont systemFontOfSize:16];
        _coldTitleLabel.textAlignment = NSTextAlignmentCenter;
        _coldTitleLabel.text = @"单次定位";
    }
    return _coldTitleLabel;
}

- (UILabel *)hotTitleLabel {
    if (!_hotTitleLabel) {
        _hotTitleLabel = [[UILabel alloc] init];
        _hotTitleLabel.frame = CGRectMake(self.frame.size.width / 2 + (self.frame.size.width / 2 - 120) / 2, 5, 120, 25);
        _hotTitleLabel.font = [UIFont systemFontOfSize:16];
        _hotTitleLabel.textAlignment = NSTextAlignmentCenter;
        _hotTitleLabel.text = @"连续定位";
    }
    return _hotTitleLabel;
}

- (UIView *)sptrLine {
    if (!_sptrLine) {
        _sptrLine = [[UIView alloc] init];
        _sptrLine.frame = CGRectMake(10, CGRectGetMaxY(self.coldTitleLabel.frame) + 5, self.frame.size.width - 20, 0.5);
        _sptrLine.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
    }
    return _sptrLine;
}

- (UITextView *)coldInfoTextView {
    if (!_coldInfoTextView) {
        _coldInfoTextView = [[UITextView alloc] init];
        _coldInfoTextView.frame = CGRectMake(10, CGRectGetMaxY(self.sptrLine.frame) + 10, (self.frame.size.width - 30) / 2, self.frame.size.height - CGRectGetMaxY(self.sptrLine.frame) - 10);
        _coldInfoTextView.backgroundColor = [UIColor clearColor];
        _coldInfoTextView.font = [UIFont systemFontOfSize:13];
        _coldInfoTextView.editable = false;
    }
    return _coldInfoTextView;
}

- (UITextView *)hotInfoTextView {
    if (!_hotInfoTextView) {
        _hotInfoTextView = [[UITextView alloc] init];
        _hotInfoTextView.frame = CGRectMake(CGRectGetMaxX(self.coldInfoTextView.frame) + 10, CGRectGetMaxY(self.sptrLine.frame) + 10, (self.frame.size.width - 30) / 2, self.frame.size.height - CGRectGetMaxY(self.sptrLine.frame) - 10);
        _hotInfoTextView.backgroundColor = [UIColor clearColor];
        _hotInfoTextView.font = [UIFont systemFontOfSize:13];
        _hotInfoTextView.editable = false;
    }
    return _hotInfoTextView;
}

@end
