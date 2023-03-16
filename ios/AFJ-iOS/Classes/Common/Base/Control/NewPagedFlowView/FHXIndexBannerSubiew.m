//
//  ViewController.swift
//  CarPictureRotary
//
//  Created by 冯汉栩 on 2019/1/20.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

@implementation FHXIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {

        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleCellTapAction:)];
        [self addGestureRecognizer:singleTap];
    }

    return self;
}

- (void)singleCellTapAction:(UIGestureRecognizer *)gesture {
    if (self.didSelectCellBlock) {
        self.didSelectCellBlock(self.tag, self);
    }
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {

    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }

    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = superViewBounds;
}

- (UIImageView *)mainImageView {

    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}

@end
