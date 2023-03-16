//
//  ZFDouYinViewController.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2018/6/4.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFDouYinViewController.h"
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFIJKPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFPlayerConst.h>
#import "ZFTableViewCellLayout.h"
#import "ZFTableData.h"
#import "ZFDouYinCell.h"
#import "ZFDouYinControlView.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import <MJRefresh/MJRefresh.h>
#import "ZFCustomControlView.h"

static NSString *kIdentifier = @"kIdentifier";

@interface ZFDouYinViewController () <UITableViewDelegate, UITableViewDataSource, ZFDouYinCellDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ZFPlayerController *player;
@property(nonatomic, strong) ZFDouYinControlView *controlView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) UIButton *backBtn;
@property(nonatomic, strong) ZFCustomControlView *fullControlView;

@end

@implementation ZFDouYinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.backBtn];
//    self.fd_prefersNavigationBarHidden = YES;
    [self requestData];

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header = header;

    /// playerManager
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
//    ZFIJKPlayerManager *playerManager = [[ZFIJKPlayerManager alloc] init];

    /// player,tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:playerManager containerViewTag:kPlayerViewTag];
    self.player.disableGestureTypes = ZFPlayerDisableGestureTypesPan | ZFPlayerDisableGestureTypesPinch;
    self.player.controlView = self.controlView;

    self.player.allowOrentitaionRotation = NO;
    self.player.WWANAutoPlay = YES;
    /// 1.0是完全消失时候
    self.player.playerDisapperaPercent = 1.0;

    @zf_weakify(self)
    self.player.playerDidToEnd = ^(id _Nonnull asset) {
        @zf_strongify(self)
        [self.player.currentPlayerManager replay];
    };

    self.player.orientationWillChange = ^(ZFPlayerController *_Nonnull player, BOOL isFullScreen) {
        kAppDelegate.allowOrentitaionRotation = isFullScreen;
        @zf_strongify(self)
        self.player.controlView.hidden = YES;
    };

    self.player.orientationDidChanged = ^(ZFPlayerController *_Nonnull player, BOOL isFullScreen) {
        @zf_strongify(self)
        self.player.controlView.hidden = NO;
        if (isFullScreen) {
            self.player.controlView = self.fullControlView;
        } else {
            self.player.controlView = self.controlView;
        }
    };

    /// 更新另一个控制层的时间
    self.player.playerPlayTimeChanged = ^(id <ZFPlayerMediaPlayback> _Nonnull asset, NSTimeInterval currentTime, NSTimeInterval duration) {
        @zf_strongify(self)
        if ([self.player.controlView isEqual:self.fullControlView]) {
            [self.controlView videoPlayer:self.player currentTime:currentTime totalTime:duration];
        } else if ([self.player.controlView isEqual:self.controlView]) {
            [self.fullControlView videoPlayer:self.player currentTime:currentTime totalTime:duration];
        }
    };

    /// 更新另一个控制层的缓冲时间
    self.player.playerBufferTimeChanged = ^(id <ZFPlayerMediaPlayback> _Nonnull asset, NSTimeInterval bufferTime) {
        @zf_strongify(self)
        if ([self.player.controlView isEqual:self.fullControlView]) {
            [self.controlView videoPlayer:self.player bufferTime:bufferTime];
        } else if ([self.player.controlView isEqual:self.controlView]) {
            [self.fullControlView videoPlayer:self.player bufferTime:bufferTime];
        }
    };

    /// 停止的时候找出最合适的播放
    self.player.zf_scrollViewDidEndScrollingCallback = ^(NSIndexPath *_Nonnull indexPath) {
        @zf_strongify(self)
        if (self.player.playingIndexPath) return;
        if (indexPath.row == self.dataSource.count - 1) {
            /// 加载下一页数据
            [self requestData];
            [self.tableView reloadData];
        }
        [self playTheVideoAtIndexPath:indexPath];
    };
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.backBtn.frame = CGRectMake(15, CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame), 36, 36);
}

- (void)loadNewData {
    [self.dataSource removeAllObjects];
    @zf_weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        /// 下拉时候一定要停止当前播放，不然有新数据，播放位置会错位。
        [self.player stopCurrentPlayingCell];
        [self requestData];
        [self.tableView reloadData];
        /// 找到可以播放的视频并播放
        [self.player zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
            @zf_strongify(self)
            [self playTheVideoAtIndexPath:indexPath];
        }];
    });
}

- (void)requestData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    NSArray *videoList = [rootDict objectForKey:@"list"];
    for (NSDictionary *dataDic in videoList) {
        ZFTableData *data = [[ZFTableData alloc] init];
        [data setValuesForKeysWithDictionary:dataDic];
        [self.dataSource addObject:data];
    }
    [self.tableView.mj_header endRefreshing];
}

- (void)playTheIndex:(NSInteger)index {
    @zf_weakify(self)
    /// 指定到某一行播放
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
    [self.player zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
        @zf_strongify(self)
        [self playTheVideoAtIndexPath:indexPath];
    }];
    /// 如果是最后一行，去请求新数据
    if (index == self.dataSource.count - 1) {
        /// 加载下一页数据
        [self requestData];
        [self.tableView reloadData];
    }
}


- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - UIScrollViewDelegate  列表播放必须实现

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScrollToTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewWillBeginDragging];
}

#pragma mark - ZFDouYinCellDelegate

- (void)zf_douyinRotation {
    UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
    if (self.player.isFullScreen) {
        orientation = UIInterfaceOrientationPortrait;
    } else {
        orientation = UIInterfaceOrientationLandscapeRight;
    }
    [self.player rotateToOrientation:orientation animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFDouYinCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    cell.delegate = self;
    cell.data = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath];
}

#pragma mark - ZFTableViewCellDelegate

- (void)zf_playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath];
}

#pragma mark - private method

- (void)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/// play the video
- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    ZFTableData *data = self.dataSource[indexPath.row];
    [self.player playTheIndexPath:indexPath assetURL:[NSURL URLWithString:data.video_url]];
    [self.controlView resetControlView];
    [self.controlView showCoverViewWithUrl:data.thumbnail_url];
    [self.fullControlView showTitle:@"custom landscape controlView" coverURLString:data.thumbnail_url fullScreenMode:ZFFullScreenModeLandscape];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.pagingEnabled = YES;
        [_tableView registerClass:[ZFDouYinCell class] forCellReuseIdentifier:kIdentifier];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.frame = self.view.bounds;
        _tableView.rowHeight = _tableView.frame.size.height;
        _tableView.scrollsToTop = NO;
    }
    return _tableView;
}

- (ZFDouYinControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFDouYinControlView new];
    }
    return _controlView;
}

- (ZFCustomControlView *)fullControlView {
    if (!_fullControlView) {
        _fullControlView = [[ZFCustomControlView alloc] init];
    }
    return _fullControlView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"icon_titlebar_whiteback"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
