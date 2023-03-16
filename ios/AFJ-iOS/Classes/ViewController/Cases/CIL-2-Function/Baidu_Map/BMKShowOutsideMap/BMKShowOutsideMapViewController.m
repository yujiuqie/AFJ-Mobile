//
//  BMKShowOutsideMapViewController.m
//  BMKShowOutsideMapDemo
//
//  Created by Baidu on 2020/5/25.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import "BMKShowOutsideMapViewController.h"

@interface BMKShowOutsideMapViewController () <BMKMapViewDelegate>

/// 当前界面的mapView
@property(nonatomic, strong) BMKMapView *mapView;

@end

@implementation BMKShowOutsideMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"境外地图";
    // 将mapView添加到当前视图中
    [self.view addSubview:self.mapView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    // 当mapView即将被显示的时候调用，恢复之前存储的mapView状态
    [_mapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
    // 当mapView即将被隐藏的时候调用，存储当前mapView的状态
    [_mapView viewWillDisappear];
}

#pragma mark - UI

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, CGRectGetHeight(self.view.frame) - kViewTopHeight)];
        _mapView.delegate = self;
        // 设置地图比例尺
        _mapView.zoomLevel = 8;
        // 设置地图中心点
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(51.50015277777778, 0.1262361111111111)];
    }
    return _mapView;
}
@end
