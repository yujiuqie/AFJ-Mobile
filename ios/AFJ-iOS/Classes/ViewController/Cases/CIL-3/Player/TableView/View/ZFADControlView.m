//
//  ZFADControlView.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2019/5/15.
//  Copyright © 2019 紫枫. All rights reserved.
//

#import "ZFADControlView.h"
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/ZFUtilities.h>
#import <ZFPlayer/ZFPlayerController.h>


@interface ZFADControlView ()
@property(nonatomic, strong) UIImageView *bgImgView;

@property(nonatomic, strong) UIButton *skipBtn;

@property(nonatomic, strong) UIButton *fullScreenBtn;

@end

@implementation ZFADControlView
@synthesize player = _player;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.skipBtn];
        [self addSubview:self.fullScreenBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.zf_width;
    CGFloat min_view_h = self.bounds.size.height;

    self.bgImgView.frame = self.bounds;

    min_x = min_view_w - 100;
    min_y = 20;
    min_w = 70;
    min_h = 30;
    self.skipBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.skipBtn.layer.cornerRadius = min_h / 2;
    self.skipBtn.layer.masksToBounds = YES;

    min_w = 30;
    min_h = min_w;
    min_x = min_view_w - min_w - 20;
    min_y = min_view_h - min_h - 20;
    self.fullScreenBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.fullScreenBtn.layer.cornerRadius = min_h / 2;
    self.fullScreenBtn.layer.masksToBounds = YES;
}


- (void)skipBtnClick {
    if (self.skipCallback) self.skipCallback();
}

- (void)fullScreenBtnClick {
    if (self.fullScreenCallback) self.fullScreenCallback();
}

/// 加载状态改变
- (void)videoPlayer:(ZFPlayerController *)videoPlayer loadStateChanged:(ZFPlayerLoadState)state {
    if (state == ZFPlayerLoadStatePrepare) {
        self.bgImgView.hidden = NO;
    } else if (state == ZFPlayerLoadStatePlaythroughOK || state == ZFPlayerLoadStatePlayable) {
        self.bgImgView.hidden = YES;
    }
}

/// 播放进度改变回调
- (void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {
    NSString *title = [NSString stringWithFormat:@"跳过 %zd秒", (NSInteger) (totalTime - currentTime)];
    [self.skipBtn setTitle:title forState:UIControlStateNormal];
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer orientationWillChange:(ZFOrientationObserver *)observer {
    self.fullScreenBtn.selected = observer.isFullScreen;
}

- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl {

}

- (void)setPlayer:(ZFPlayerController *)player {
    _player = player;
    player.currentPlayerManager.scalingMode = ZFPlayerScalingModeAspectFill;
    [player.currentPlayerManager.view insertSubview:self.bgImgView atIndex:0];
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.userInteractionEnabled = YES;
    }
    return _bgImgView;
}

- (UIButton *)skipBtn {
    if (!_skipBtn) {
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [_skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipBtn;
}

- (UIButton *)fullScreenBtn {
    if (!_fullScreenBtn) {
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn setImage:ZFPlayer_Image(@"ZFPlayer_fullscreen") forState:UIControlStateNormal];
        [_fullScreenBtn setImage:ZFPlayer_Image(@"ZFPlayer_shrinkscreen") forState:UIControlStateSelected];
        [_fullScreenBtn addTarget:self action:@selector(fullScreenBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _fullScreenBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }
    return _fullScreenBtn;
}


@end
