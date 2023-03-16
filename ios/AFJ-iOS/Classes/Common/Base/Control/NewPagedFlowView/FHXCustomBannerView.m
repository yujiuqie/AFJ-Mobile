//
//  ViewController.swift
//  CarPictureRotary
//
//  Created by 冯汉栩 on 2019/1/20.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

@interface FHXCustomBannerView ()

@end

@implementation FHXCustomBannerView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {
        [self addSubview:self.indexLabel];
    }

    return self;
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {

    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }

    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = superViewBounds;
    self.indexLabel.frame = CGRectMake(0, 10, superViewBounds.size.width, 20);
}

- (UILabel *)indexLabel {
    if (_indexLabel == nil) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _indexLabel.font = [UIFont systemFontOfSize:16.0];
        _indexLabel.textColor = [UIColor whiteColor];
    }
    return _indexLabel;
}

@end
