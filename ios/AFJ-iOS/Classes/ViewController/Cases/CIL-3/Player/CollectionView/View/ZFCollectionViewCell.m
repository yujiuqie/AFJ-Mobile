//
//  ZFCollectionViewCell.m
//  Player
//
//  Created by 任子丰 on 17/3/22.
//  Copyright © 2017年 任子丰. All rights reserved.
//

#import "ZFCollectionViewCell.h"
#import <ZFPlayer/UIImageView+ZFCache.h>

@implementation ZFCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.coverImageView.tag = kPlayerViewTag;
        [self.contentView addSubview:self.coverImageView];
        [self.coverImageView addSubview:self.playBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.coverImageView.frame = self.contentView.bounds;
    self.playBtn.frame = CGRectMake(0, 0, 44, 44);
    self.playBtn.center = self.coverImageView.center;
}

- (void)setData:(ZFTableData *)data {
    _data = data;
    [self.coverImageView setImageWithURLString:data.thumbnail_url placeholder:[UIImage imageNamed:@"loading_bgView"]];
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.tag = kPlayerViewTag;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
    }
    return _coverImageView;
}


- (void)playBtnClick:(UIButton *)sender {
    if (self.playBlock) {
        self.playBlock(sender);
    }
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
@end
