//
//  BMKTabsSwitchViewController.m
//  BaiduMapSDKDemo
//
//  Created by baidu on 2020/7/20.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKTabsSwitchViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "UIImage+BMKImage.h"

@interface BMKTabsSwitchViewController () <BMKMapViewDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate>
@property(nonatomic, strong) UISegmentedControl *segmentedControl;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) BMKMapView *standardMapView;
@property(nonatomic, strong) BMKMapView *satelliteMapView;
@property(nonatomic, strong) BMKMapView *noneMapView;
@property(nonatomic, assign) NSInteger currentIndex;

@end

@implementation BMKTabsSwitchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势冲突";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.standardMapView];
    [self.scrollView addSubview:self.satelliteMapView];
    [self.scrollView addSubview:self.noneMapView];

    [self.view addSubview:self.segmentedControl];

    // 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    pan.delegate = self;
    [self.scrollView addGestureRecognizer:pan];

    self.currentIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.standardMapView viewWillAppear];
    [self.satelliteMapView viewWillAppear];
    [self.noneMapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.standardMapView viewWillDisappear];
    [self.satelliteMapView viewWillDisappear];
    [self.noneMapView viewWillDisappear];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;

    NSInteger index = round(offsetX / scrollView.bounds.size.width);

    if (index != self.currentIndex) {
        self.currentIndex = index;
        [self.segmentedControl setSelectedSegmentIndex:_currentIndex];
    }
}

#pragma mark - UIGestureRecognizerDelegate

//多手势同时识别
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Event

- (void)panHandler:(UIPanGestureRecognizer *)gesture {
    // 当速度大于某个值时触发page切换
    if (fabs([gesture velocityInView:self.scrollView].x) > 2300) {
        // -1：左滑，1：右滑
        NSInteger direction = fabs([gesture velocityInView:self.scrollView].x) / [gesture velocityInView:self.scrollView].x;
        NSInteger index = self.currentIndex - direction;

        if (index >= 0 && index <= 2 && !self.scrollView.isDecelerating) {
            CGFloat width = self.scrollView.frame.size.width * index;
            [self.scrollView setContentOffset:CGPointMake(width, 0) animated:YES];
        }
    }
}

- (void)segmentedAction:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    CGFloat width = self.scrollView.frame.size.width * index;
    [self.scrollView setContentOffset:CGPointMake(width, 0) animated:YES];
}

#pragma mark - UI

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor darkGrayColor];
        _scrollView.center = self.view.center;
        _scrollView.contentSize = CGSizeMake(SCREENW * 3, SCREENH);
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.bounces = NO;
        _scrollView.bouncesZoom = NO;
        _scrollView.delaysContentTouches = NO;
        _scrollView.clipsToBounds = YES;
    }
    return _scrollView;
}

- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        NSArray *segmentedArray = [NSArray arrayWithObjects:@"标准地图", @"卫星图", @"空白地图", nil];
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
        _segmentedControl.frame = CGRectMake(40.0, 10.0, self.view.frame.size.width - 80, 40.0);
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(segmentedAction:)
                    forControlEvents:UIControlEventValueChanged];
        _segmentedControl.backgroundColor = [COLOR(0x22253D) colorWithAlphaComponent:0.8];
        _segmentedControl.layer.masksToBounds = YES;
        _segmentedControl.layer.cornerRadius = 5;
        _segmentedControl.layer.borderWidth = 1.5;
        _segmentedControl.layer.borderColor = [UIColor blackColor].CGColor;
        _segmentedControl.selectedSegmentIndex = 0;

        _segmentedControl.tintColor = COLOR(0x22253D);

        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];

        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f]} forState:UIControlStateNormal];

        if (@available(iOS 13, *)) {
            UIColor *tintColor = COLOR(0x22253D);
            UIImage *tintColorImage = [UIImage bmk_getImageWithColor:tintColor];
            UIImage *tintColorAlphaImage = [UIImage bmk_getImageWithColor:[tintColor colorWithAlphaComponent:0.2]];
            [_segmentedControl setBackgroundImage:tintColorAlphaImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [_segmentedControl setBackgroundImage:tintColorAlphaImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
            [_segmentedControl setBackgroundImage:tintColorImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
            [_segmentedControl setBackgroundImage:tintColorImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
            [_segmentedControl setDividerImage:tintColorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        }
    }
    return _segmentedControl;
}

- (BMKMapView *)standardMapView {
    if (!_standardMapView) {
        //标准地图
        _standardMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH - kViewTopHeight)];
    }
    return _standardMapView;
}

- (BMKMapView *)satelliteMapView {
    if (!_satelliteMapView) {
        //卫星图
        _satelliteMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(SCREENW, 0, SCREENW, SCREENH - kViewTopHeight)];
        _satelliteMapView.mapType = BMKMapTypeSatellite;
    }
    return _satelliteMapView;
}

- (BMKMapView *)noneMapView {
    if (!_noneMapView) {
        //空白地图
        _noneMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(SCREENW * 2, 0, SCREENW, SCREENH - kViewTopHeight)];
        _noneMapView.mapType = BMKMapTypeNone;
    }
    return _noneMapView;
}

@end
