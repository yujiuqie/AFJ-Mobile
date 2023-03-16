//
//  ZFKeyboardViewController.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2018/5/25.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFKeyboardViewController.h"
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFIJKPlayerManager.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/ZFPlayerConst.h>

@interface ZFKeyboardViewController ()
@property(nonatomic, strong) ZFPlayerController *player;
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) ZFPlayerControlView *controlView;
@property(nonatomic, strong) UITextField *textField;

@end

@implementation ZFKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    [self.controlView addSubview:self.textField];

    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [[ZFPlayerController alloc] initWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    @zf_weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController *_Nonnull player, BOOL isFullScreen) {
        @zf_strongify(self)
        [self.textField resignFirstResponder];
        kAppDelegate.allowOrentitaionRotation = isFullScreen;
    };

    self.player.orientationDidChanged = ^(ZFPlayerController *_Nonnull player, BOOL isFullScreen) {
        @zf_strongify(self)
        [self updateTextFieldLayout];
    };

    NSString *URLString = [@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    playerManager.assetURL = [NSURL URLWithString:URLString];

    [self.controlView showTitle:@"视频标题" coverURLString:@"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" fullScreenMode:ZFFullScreenModeLandscape];

    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (self.player.isFullScreen) {
        [UIView animateWithDuration:duration animations:^{
            self.textField.zf_bottom = self.controlView.zf_height - CGRectGetHeight(frame);
        }];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w * 9 / 16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    [self updateTextFieldLayout];
}

- (void)updateTextFieldLayout {
    CGFloat w = 200;
    CGFloat h = 35;
    CGFloat x = (self.controlView.zf_width - w) / 2;
    CGFloat y = self.controlView.zf_height - h - 60;
    self.textField.frame = CGRectMake(x, y, w, h);
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.prepareShowControlView = YES;
        _controlView.prepareShowLoading = YES;
    }
    return _controlView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = @"Click on the input";
    }
    return _textField;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
    }
    return _containerView;
}

@end
