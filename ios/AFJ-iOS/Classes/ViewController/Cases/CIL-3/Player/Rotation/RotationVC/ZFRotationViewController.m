//
//  ZFRotationViewController.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2019/6/4.
//  Copyright © 2019 紫枫. All rights reserved.
//

#import "ZFRotationViewController.h"
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFIJKPlayerManager.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/ZFPlayerConst.h>

@interface ZFRotationViewController ()

@property(nonatomic, strong) ZFPlayerController *player;
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation ZFRotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];

    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [[ZFPlayerController alloc] initWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    self.player.orientationWillChange = ^(ZFPlayerController *_Nonnull player, BOOL isFullScreen) {
        kAppDelegate.allowOrentitaionRotation = isFullScreen;
    };

    playerManager.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];

    [self.controlView showTitle:@"视频标题" coverURLString:@"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" fullScreenMode:ZFFullScreenModeLandscape];
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

- (IBAction)landscapeClick {
    self.controlView.fullScreenMode = ZFFullScreenModeLandscape;
    [self.player rotateToOrientation:UIInterfaceOrientationLandscapeRight animated:YES completion:nil];
}

- (IBAction)portraitClick {
    self.controlView.fullScreenMode = ZFFullScreenModePortrait;
    [self.player enterPortraitFullScreen:YES animated:YES];
}

#pragma mark - about keyboard orientation

/// 键盘支持横屏，这里必须设置支持多个方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
    }
    return _controlView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
    }
    return _containerView;
}

@end
