//
//  BMKOverlayClickedViewController.m
//  BMKOverlayClickedDemo
//
//  Created by baidu on 2020/7/29.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKOverlayClickedViewController.h"

@interface BMKOverlayClickedViewController () <BMKMapViewDelegate> {
    BMKMapPoint *_points; // overlay 坐标点
    NSInteger _pointCount; // overlay 坐标点数量
    BOOL _isSelected; // 是否选中overlay
}

/// 地图
@property(nonatomic, strong) BMKMapView *mapView;

/// 多边形view
@property(nonatomic, strong) BMKPolygonView *polygonView;
@end

@implementation BMKOverlayClickedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Overlay点击选中";

    [self loadData];
    // 将mapView添加到当前视图中
    [self.view addSubview:self.mapView];

    [self customMap];
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

#pragma mark - private

/// 个性化地图
- (void)customMap {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chatian" ofType:@"sty"];

    BMKCustomMapStyleOption *option = [[BMKCustomMapStyleOption alloc] init];
    option.customMapStyleFilePath = filePath;

    [self.mapView setCustomMapStyleWithOption:option preLoad:nil success:nil failure:nil];
}

/// 加载overlay坐标点
- (void)loadData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"haidian" ofType:@"json"];
    NSString *pointsStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *pointsStrArr = [pointsStr componentsSeparatedByString:@";"];
    _pointCount = pointsStrArr.count;

    _points = new BMKMapPoint[_pointCount];

    for (int i = 0; i < _pointCount; i++) {
        NSString *pointStr = pointsStrArr[i];
        NSArray *pointStrArr = [pointStr componentsSeparatedByString:@","];
        _points[i] = BMKMapPointMake([pointStrArr[0] doubleValue], [pointStrArr[1] doubleValue]);
    }
}

/// 添加行政区域多边形
- (void)addDistrictPolygon {
    BMKPolygon *polygon = [BMKPolygon polygonWithPoints:_points count:_pointCount];
    [self.mapView addOverlay:polygon];
}

/// 添加标注
- (void)addAnnotationWith:(CLLocationCoordinate2D)coord {
    [_mapView removeAnnotations:_mapView.annotations];

    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = coord;
    [_mapView addAnnotation:annotation];

}

/// 点击地图空白或标注事件处理
- (void)onClickMap:(CLLocationCoordinate2D)coordinate {
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        // 经纬度转BMKMapPoint
        BMKMapPoint point = BMKMapPointForCoordinate(coordinate);
        // 判断点击是否在多边形overlay范围内
        _isSelected = BMKPolygonContainsPoint(point, _points, _pointCount);
        _polygonView.fillColor = _isSelected ? [COLOR(0x008B00) colorWithAlphaComponent:0.6] : [COLOR(0x90EE90) colorWithAlphaComponent:0.5];
    }
}

#pragma mark - BMKMapViewDelegate

/// 地图初始化完毕时会调用此接口
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    [self addDistrictPolygon];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"com.baidu.BMKPinAnnotationView"];
        if (!annotationView) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"com.baidu.BMKPinAnnotationView"];
        }
        annotationView.pinColor = BMKPinAnnotationColorRed;
        return annotationView;
    }
    return nil;
}

/// 根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolygon class]]) {
        BMKPolygonView *polygonView = [[BMKPolygonView alloc] initWithPolygon:overlay];
        polygonView.fillColor = [COLOR(0x90EE90) colorWithAlphaComponent:0.5];
        polygonView.strokeColor = [COLOR(0x00CD00) colorWithAlphaComponent:0.5];
        polygonView.lineWidth = 1.0;

        _polygonView = polygonView;

        return polygonView;
    }
    return nil;
}

/// 点中底图空白处会回调此接口
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    [self addAnnotationWith:coordinate];
    [self onClickMap:coordinate];
}

/// 点中底图标注后会回调此接口
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi {
    [self addAnnotationWith:mapPoi.pt];
    [self onClickMap:mapPoi.pt];
}

#pragma mark - UI

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kViewTopHeight)];
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(40.01851014680792, 116.22943142263398);
        _mapView.zoomLevel = 12;
        _mapView.delegate = self;
    }
    return _mapView;
}
@end
