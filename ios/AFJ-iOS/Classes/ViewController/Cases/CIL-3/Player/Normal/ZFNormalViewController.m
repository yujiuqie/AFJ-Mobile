//
//  ZFNormalViewController.m
//  ZFPlayer
//
//  Created by 紫枫 on 2018/3/21.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFNormalViewController.h"
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFIJKPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import "ZFNotAutoPlayViewController.h"
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/ZFPlayerConst.h>
#import "ZFUtilities.h"
@import AVKit;

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

@interface ZFNormalViewController ()
@property(nonatomic, strong) ZFPlayerController *player;
@property(nonatomic, strong) UIImageView *containerView;
@property(nonatomic, strong) ZFPlayerControlView *controlView;
@property(nonatomic, strong) UIButton *playBtn;
@property(nonatomic, strong) UIButton *changeBtn;
@property(nonatomic, strong) UIButton *nextBtn;
@property(nonatomic, strong) UIButton *pipBtn;
@property(nonatomic, strong) NSArray <NSURL *> *assetURLs;
@property(nonatomic, strong) AVPictureInPictureController *vc;
@end

@implementation ZFNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(pushNewVC)];
    [self.view addSubview:self.containerView];

    [self.containerView addSubview:self.playBtn];
    [self.view addSubview:self.changeBtn];
    [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.pipBtn];
    [self setupPlayer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w * 9 / 16;
    self.containerView.frame = CGRectMake(x, y, w, h);

    w = 44;
    h = w;
    x = (CGRectGetWidth(self.containerView.frame) - w) / 2;
    y = (CGRectGetHeight(self.containerView.frame) - h) / 2;
    self.playBtn.frame = CGRectMake(x, y, w, h);

    w = 100;
    h = 30;
    x = (CGRectGetWidth(self.view.frame) - w) / 2;
    y = CGRectGetMaxY(self.containerView.frame) + 50;
    self.changeBtn.frame = CGRectMake(x, y, w, h);

    w = 100;
    h = 30;
    x = (CGRectGetWidth(self.view.frame) - w) / 2;
    y = CGRectGetMaxY(self.changeBtn.frame) + 50;
    self.nextBtn.frame = CGRectMake(x, y, w, h);


    w = 100;
    h = 30;
    x = (CGRectGetWidth(self.view.frame) - w) / 2;
    y = CGRectGetMaxY(self.nextBtn.frame) + 50;
    self.pipBtn.frame = CGRectMake(x, y, w, h);
}

- (void)setupPlayer {
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
//    ZFIJKPlayerManager *playerManager = [[ZFIJKPlayerManager alloc] init];

    playerManager.shouldAutoPlay = YES;

    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
//    self.player.resumePlayRecord = YES;

    @zf_weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController *_Nonnull player, BOOL isFullScreen) {
        kAppDelegate.allowOrentitaionRotation = isFullScreen;
    };

    /// 播放完成
    self.player.playerDidToEnd = ^(id _Nonnull asset) {
        @zf_strongify(self)
        if (!self.player.isLastAssetURL) {
            [self.player playTheNext];
            NSString *title = [NSString stringWithFormat:@"视频标题%zd", self.player.currentPlayIndex];
            [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        } else {
            [self.player stop];
        }
    };

    self.player.assetURLs = self.assetURLs;
    [self.player playTheIndex:0];
    [self.controlView showTitle:@"iPhone X" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];


}

- (void)picBtnClick {
    /// 配置画中画
    ZFAVPlayerManager *manager = (ZFAVPlayerManager *) self.player.currentPlayerManager;
    AVPictureInPictureController *vc = [[AVPictureInPictureController alloc] initWithPlayerLayer:manager.avPlayerLayer];
    self.vc = vc;
    ///要有延迟 否则可能开启不成功
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.vc startPictureInPicture];
    });
}

- (void)changeVideo:(UIButton *)sender {
    NSString *URLString = @"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4";
    self.player.assetURL = [NSURL URLWithString:URLString];
    [self.controlView showTitle:@"Apple" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
}

- (void)playClick:(UIButton *)sender {
    [self.player playTheIndex:0];
    [self.controlView showTitle:@"视频标题" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
}

- (void)nextClick:(UIButton *)sender {
    if (!self.player.isLastAssetURL) {
        [self.player playTheNext];
        NSString *title = [NSString stringWithFormat:@"视频标题%zd", self.player.currentPlayIndex];
        [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
    } else {
        NSLog(@"最后一个视频了");
    }
}

- (void)pushNewVC {
    ZFNotAutoPlayViewController *vc = [[ZFNotAutoPlayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
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
        _controlView.prepareShowControlView = NO;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView setImageWithURLString:kVideoCover placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIButton *)changeBtn {
    if (!_changeBtn) {
        _changeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_changeBtn setTitle:@"Change video" forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(changeVideo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (UIButton *)pipBtn {
    if (!_pipBtn) {
        _pipBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_pipBtn setTitle:@"开启画中画" forState:UIControlStateNormal];
        [_pipBtn addTarget:self action:@selector(picBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pipBtn;
}

- (NSArray<NSURL *> *)assetURLs {
    if (!_assetURLs) {
        _assetURLs = @[[NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"],
                [NSURL URLWithString:@"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"],
                [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4"],
                [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4"],
                [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/H/9/EDJTRBEH9/SD/EDJTRBEH9-mobile.mp4"],
                [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/9/R/EDJTRAD9R/SD/EDJTRAD9R-mobile.mp4"],
                [NSURL URLWithString:@"http://www.flashls.org/playlists/test_001/stream_1000k_48k_640x360.m3u8"],
                [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-video/7_517c8948b166655ad5cfb563cc7fbd8e.mp4"],
                [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/68_20df3a646ab5357464cd819ea987763a.mp4"],
                [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/118_570ed13707b2ccee1057099185b115bf.mp4"],
                [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/15_ad895ac5fb21e5e7655556abee3775f8.mp4"],
                [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/12_cc75b3fb04b8a23546d62e3f56619e85.mp4"],
                [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/5_6d3243c354755b781f6cc80f60756ee5.mp4"],
                [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-movideo/11233547_ac127ce9e993877dce0eebceaa04d6c2_593d93a619b0.mp4"]];
    }
    return _assetURLs;
}

@end
