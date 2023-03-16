//
//  BMKGlobalLocTabView.m
//  BMKGlobalLocOCDemo
//
//  Created by v_chiyuanwei on 2020/7/14.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKGlobalLocTabView.h"

@interface BMKGlobalLocTabView ()
/// 单次定位
@property(nonatomic, strong) UIButton *coldLocBtn;
/// 连续定位
@property(nonatomic, strong) UIButton *hotLocBtn;

@end

@implementation BMKGlobalLocTabView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:34.f / 255.f green:37.f / 255.f blue:61.f / 255.f alpha:0.7f];

        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.coldLocBtn];
    [self addSubview:self.hotLocBtn];
}

#pragma mark -

- (void)singleLocBtnAction:(UIButton *)btn {
    if (self.didClickTabBlock) {
        self.didClickTabBlock(0, btn.selected);
    }
}

- (void)continueLocBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;

    if (self.didClickTabBlock) {
        self.didClickTabBlock(1, btn.selected);
    }
}

#pragma mark -

- (UIButton *)coldLocBtn {
    if (!_coldLocBtn) {
        _coldLocBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _coldLocBtn.frame = CGRectMake(20, 10, (self.frame.size.width - 60) / 2, self.frame.size.height - 20);
        _coldLocBtn.backgroundColor = [UIColor colorWithRed:34.f / 255.f green:37.f / 255.f blue:61.f / 255.f alpha:1.f];
        [_coldLocBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _coldLocBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_coldLocBtn setTitle:@"开始单次定位" forState:UIControlStateNormal];
        _coldLocBtn.layer.cornerRadius = 20;
        _coldLocBtn.layer.masksToBounds = YES;

        [_coldLocBtn addTarget:self action:@selector(singleLocBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coldLocBtn;
}

- (UIButton *)hotLocBtn {
    if (!_hotLocBtn) {
        _hotLocBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hotLocBtn.frame = CGRectMake(CGRectGetMaxX(self.coldLocBtn.frame) + 20, 10, (self.frame.size.width - 60) / 2, self.frame.size.height - 20);
        _hotLocBtn.backgroundColor = [UIColor colorWithRed:34.f / 255.f green:37.f / 255.f blue:61.f / 255.f alpha:1.f];
        [_hotLocBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _hotLocBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_hotLocBtn setTitle:@"开始连续定位" forState:UIControlStateNormal];
        [_hotLocBtn setTitle:@"停止连续定位" forState:UIControlStateSelected];
        _hotLocBtn.layer.cornerRadius = 20;
        _hotLocBtn.layer.masksToBounds = YES;

        [_hotLocBtn addTarget:self action:@selector(continueLocBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotLocBtn;
}

@end
