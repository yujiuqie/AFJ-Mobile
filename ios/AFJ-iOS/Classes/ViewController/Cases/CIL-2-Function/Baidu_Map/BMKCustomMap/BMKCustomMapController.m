//
//  BMKCustomMapController.m
//  BMKCustomMapDemo
//
//  Created by baidu on 2020/7/20.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKCustomMapController.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "BMKSegmentView.h"

@interface BMKCustomMapController ()
/// 地图
@property(nonatomic, strong) BMKMapView *mapView;
@property(nonatomic, strong) BMKSegmentView *segmentView;

@end

@implementation BMKCustomMapController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个性化地图";

    [self initialize];
    [self setupViews];
    // 默认选中夜样式
    [self changeMapStyle:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //当mapView即将被显示的时候调用，恢复之前存储的mapView状态
    [_mapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //当mapView即将被隐藏的时候调用，存储当前mapView的状态
    [_mapView viewWillDisappear];
}

#pragma mark -

- (void)initialize {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)setupViews {
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.segmentView];
}

- (void)changeMapStyle:(NSInteger)idx {
    NSString *filePath = nil;
    if (idx == 0) { // 昼
        filePath = [[NSBundle mainBundle] pathForResource:@"chuxing" ofType:@"sty"];
    } else if (idx == 1) { // 夜
        filePath = [[NSBundle mainBundle] pathForResource:@"yanmou" ofType:@"sty"];
    } else if (idx == 2) { // 关闭个性化
        [self.mapView setCustomMapStyleEnable:NO];
        return;
    }

    BMKCustomMapStyleOption *option = [[BMKCustomMapStyleOption alloc] init];
    // 个性化地图文件路径
    option.customMapStyleFilePath = filePath;

    // 加载个性化地图
    [self.mapView setCustomMapStyleWithOption:option preLoad:^(NSString *path) {

    }                                 success:^(NSString *path) {

    }                                 failure:^(NSError *error, NSString *path) {

    }];
}

#pragma mark -

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kViewTopHeight)];
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(40.004864064521996, 116.27874926050964);
        _mapView.zoomLevel = 13.7;
    }
    return _mapView;
}

- (BMKSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[BMKSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        __weak typeof(self) weakSelf = self;
        _segmentView.didClickSegmentBlock = ^(NSInteger idx) {
            [weakSelf changeMapStyle:idx];
        };
    }
    return _segmentView;
}

@end
