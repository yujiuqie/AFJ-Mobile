//
//  ZFWeChatControlView.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2020/7/11.
//  Copyright © 2020 紫枫. All rights reserved.
//

#import "ZFWeChatControlView.h"
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/ZFUtilities.h>
#import "ZFLoadingView.h"

@interface ZFWeChatControlView ()

/// 加载loading
@property(nonatomic, strong) ZFLoadingView *activity;

@end

@implementation ZFWeChatControlView
@synthesize player = _player;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.activity];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;

    min_w = 44;
    min_h = 44;
    self.activity.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.activity.zf_centerX = self.zf_centerX;
    self.activity.zf_centerY = self.zf_centerY;
}

/// 播放状态改变
- (void)videoPlayer:(ZFPlayerController *)videoPlayer playStateChanged:(ZFPlayerPlaybackState)state {
    if (state == ZFPlayerPlayStatePlaying) {
        /// 开始播放时候判断是否显示loading
        if (videoPlayer.currentPlayerManager.loadState == ZFPlayerLoadStateStalled) {
            [self.activity startAnimating];
        } else if ((videoPlayer.currentPlayerManager.loadState == ZFPlayerLoadStateStalled || videoPlayer.currentPlayerManager.loadState == ZFPlayerLoadStatePrepare)) {
            [self.activity startAnimating];
        }
    } else if (state == ZFPlayerPlayStatePaused) {
        /// 暂停的时候隐藏loading
        [self.activity stopAnimating];
    } else if (state == ZFPlayerPlayStatePlayFailed) {
        [self.activity stopAnimating];
    }
}

/// 加载状态改变
- (void)videoPlayer:(ZFPlayerController *)videoPlayer loadStateChanged:(ZFPlayerLoadState)state {
    if (state == ZFPlayerLoadStateStalled && videoPlayer.currentPlayerManager.isPlaying) {
        [self.activity startAnimating];
    } else if ((state == ZFPlayerLoadStateStalled || state == ZFPlayerLoadStatePrepare) && videoPlayer.currentPlayerManager.isPlaying) {
        [self.activity startAnimating];
    } else {
        [self.activity stopAnimating];
    }
}

- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl {
    if (!self.player.isFullScreen) {
        [self.player enterPortraitFullScreen:YES animated:YES];
    }
}

/// 手势筛选，返回NO不响应该手势
- (BOOL)gestureTriggerCondition:(ZFPlayerGestureControl *)gestureControl gestureType:(ZFPlayerGestureType)gestureType gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer touch:(nonnull UITouch *)touch {
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        if (gestureRecognizer == gestureControl.singleTap && !self.player.isFullScreen) {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (void)setPlayer:(ZFPlayerController *)player {
    _player = player;
}

- (void)showCoverViewWithUrl:(NSString *)coverUrl {
    [self.player.currentPlayerManager.view.coverImageView setImageWithURLString:coverUrl placeholder:[UIImage imageNamed:@"img_video_loading"]];
}

#pragma mark - getter

- (ZFLoadingView *)activity {
    if (!_activity) {
        _activity = [[ZFLoadingView alloc] init];
        _activity.hidesWhenStopped = YES;
        _activity.animType = ZFLoadingTypeFadeOut;
    }
    return _activity;
}

@end
