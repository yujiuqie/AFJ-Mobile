//
//  ZFADViewController.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2019/6/5.
//  Copyright © 2019 紫枫. All rights reserved.
//

#import "ZFADViewController.h"
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFIJKPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/ZFPlayerConst.h>
#import "UIImageView+ZFCache.h"
#import "ZFUtilities.h"
#import "ZFADControlView.h"

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

@interface ZFADViewController ()

@property(nonatomic, strong) ZFPlayerController *player;
@property(nonatomic, strong) UIImageView *containerView;
@property(nonatomic, strong) ZFPlayerControlView *controlView;
@property(nonatomic, strong) ZFADControlView *adControlView;
@property(nonatomic, strong) ZFAVPlayerManager *playerManager;
@property(nonatomic, strong) ZFAVPlayerManager *adPlayerManager;
@end

@implementation ZFADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];

    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w * 9 / 16;
    self.containerView.frame = CGRectMake(x, y, w, h);


    self.playerManager = [[ZFAVPlayerManager alloc] init];
    /// 广告
    self.adPlayerManager = [[ZFAVPlayerManager alloc] init];

    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:self.adPlayerManager containerView:self.containerView];
    self.player.controlView = self.adControlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;

    @zf_weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController *_Nonnull player, BOOL isFullScreen) {
        kAppDelegate.allowOrentitaionRotation = isFullScreen;
    };

    /// 播放完成
    self.player.playerDidToEnd = ^(id _Nonnull asset) {
        @zf_strongify(self)
        if (self.player.currentPlayerManager == self.adPlayerManager) {
            self.player.controlView = self.controlView;
            self.player.currentPlayerManager = self.playerManager;
            self.player.currentPlayerManager.shouldAutoPlay = YES;
            [self.player.currentPlayerManager play];
            [self.controlView showTitle:@"iPhone X" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        } else {
            [self.player stop];
        }
    };

    /// 一定要在player初始化之后设置assetURL
    self.playerManager.shouldAutoPlay = NO;
    self.playerManager.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"];

    self.adPlayerManager.assetURL = [NSURL URLWithString:@"https://fcvideo.cdn.bcebos.com/smart/f103c4fc97d2b2e63b15d2d5999d6477.mp4"];
    self.adPlayerManager.shouldAutoPlay = YES;

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w * 9 / 16;
    self.containerView.frame = CGRectMake(x, y, w, h);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
    }
    return _controlView;
}

- (ZFADControlView *)adControlView {
    if (!_adControlView) {
        _adControlView = [[ZFADControlView alloc] init];
        @zf_weakify(self)
        _adControlView.skipCallback = ^{
            @zf_strongify(self)
            self.player.controlView = self.controlView;
            self.player.currentPlayerManager = self.playerManager;
            self.playerManager.shouldAutoPlay = YES;
            [self.player.currentPlayerManager play];
            [self.controlView showTitle:@"iPhone X" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        };

        _adControlView.fullScreenCallback = ^{
            @zf_strongify(self)
            if (self.player.isFullScreen) {
                [self.player enterFullScreen:NO animated:YES];
            } else {
                [self.player enterFullScreen:YES animated:YES];
            }
        };
    }
    return _adControlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView setImageWithURLString:kVideoCover placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}

@end
