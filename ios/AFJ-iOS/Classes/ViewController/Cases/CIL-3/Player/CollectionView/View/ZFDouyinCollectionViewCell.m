//
//  ZFDouyinCollectionViewCell.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2019/6/4.
//  Copyright © 2019 紫枫. All rights reserved.
//

#import "ZFDouyinCollectionViewCell.h"
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/ZFUtilities.h>
#import "ZFLoadingView.h"

@interface ZFDouyinCollectionViewCell ()

@property(nonatomic, strong) UIImageView *coverImageView;

@property(nonatomic, strong) UIButton *likeBtn;

@property(nonatomic, strong) UIButton *commentBtn;

@property(nonatomic, strong) UIButton *shareBtn;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIImage *placeholderImage;

@property(nonatomic, strong) UIButton *rotation;

@end

@implementation ZFDouyinCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.likeBtn];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.shareBtn];
        [self.contentView addSubview:self.rotation];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.coverImageView.frame = self.contentView.bounds;

    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.zf_width;
    CGFloat min_view_h = self.zf_height;
    CGFloat margin = 30;

    min_w = 40;
    min_h = min_w;
    min_x = min_view_w - min_w - 20;
    min_y = min_view_h - min_h - 80;
    self.shareBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);

    min_w = CGRectGetWidth(self.shareBtn.frame);
    min_h = min_w;
    min_x = CGRectGetMinX(self.shareBtn.frame);
    min_y = CGRectGetMinY(self.shareBtn.frame) - min_h - margin;
    self.commentBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);

    min_w = CGRectGetWidth(self.shareBtn.frame);
    min_h = min_w;
    min_x = CGRectGetMinX(self.commentBtn.frame);
    min_y = CGRectGetMinY(self.commentBtn.frame) - min_h - margin;
    self.likeBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);

    min_x = 20;
    min_h = 20;
    min_y = min_view_h - min_h - 50;
    min_w = self.likeBtn.zf_left - margin;
    self.titleLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);

    min_x = 20;
    min_w = 50;
    min_h = 50;
    min_y = (min_view_h - min_h) / 2;
    self.rotation.frame = CGRectMake(min_x, min_y, min_w, min_h);
}

#pragma mark - action

- (void)rotationClick {
    if ([self.delegate respondsToSelector:@selector(zf_douyinRotation)]) {
        [self.delegate zf_douyinRotation];
    }
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
    return _likeBtn;
}


- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    }
    return _commentBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

- (UIImage *)placeholderImage {
    if (!_placeholderImage) {
        _placeholderImage = [ZFUtilities imageWithColor:[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1] size:CGSizeMake(1, 1)];
    }
    return _placeholderImage;
}

- (void)setData:(ZFTableData *)data {
    _data = data;
    [self.coverImageView setImageWithURLString:data.thumbnail_url placeholder:[UIImage imageNamed:@"loading_bgView"]];
    self.titleLabel.text = data.title;
    if (data.video_width > data.video_height) { /// 横屏视频才支持旋转
        self.rotation.hidden = NO;
    } else {
        self.rotation.hidden = YES;
    }
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.tag = kPlayerViewTag;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}

- (UIButton *)rotation {
    if (!_rotation) {
        _rotation = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rotation setImage:[UIImage imageNamed:@"zfplayer_rotaiton"] forState:UIControlStateNormal];
        [_rotation addTarget:self action:@selector(rotationClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rotation;
}

@end
