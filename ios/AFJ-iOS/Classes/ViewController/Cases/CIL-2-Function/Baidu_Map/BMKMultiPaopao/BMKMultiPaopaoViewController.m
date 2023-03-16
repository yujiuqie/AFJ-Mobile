//
//  BMKMultiPaopaoViewController.m
//  BMKMultiPaopaoDemo
//
//  Created by baidu on 2020/7/29.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKMultiPaopaoViewController.h"

@interface BMKMultiPaopaoViewController () <BMKMapViewDelegate>

/// 地图
@property(nonatomic, strong) BMKMapView *mapView;

@end

@implementation BMKMultiPaopaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"多信息窗展示";
    [self.view addSubview:self.mapView];
    [_mapView addAnnotations:[self createAnnotations]];

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

#pragma mark - private

/// 生成标注
- (NSArray<BMKPointAnnotation *> *)createAnnotations {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"poiInfo_multi" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    NSMutableArray<BMKPointAnnotation *> *annotations = [NSMutableArray array];
    [dataArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([obj[@"lat"] doubleValue], [obj[@"lng"] doubleValue]);
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
        annotation.coordinate = coord;
        annotation.title = obj[@"name"];
        annotation.subtitle = obj[@"address"];
        [annotations addObject:annotation];
    }];

    return annotations;
}

#pragma mark - BMKMapViewDelegate
//- (void)mapViewDidFinishRendering:(BMKMapView *)mapView {
//     [_mapView addAnnotations:[self createAnnotations]];
//}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"com.baidu.BMKPinAnnotationView"];
        if (!annotationView) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"com.baidu.BMKPinAnnotationView"];
        }
        annotationView.selected = YES;
        // 当拖拽当前的annotation时，当前annotation的泡泡是否隐藏，默认值为NO，V4.2.1以后支持
        annotationView.hidePaopaoWhenDrag = NO;
        // 当拖拽其他annotation时，当前annotation的泡泡是否隐藏，默认值为NO，V4.2.1以后支持
        annotationView.hidePaopaoWhenDragOthers = NO;
        // 当选中其他annotation时，当前annotation的泡泡是否隐藏，默认值为YES，V4.2.1以后支持
        annotationView.hidePaopaoWhenSelectOthers = NO;
        // 当发生双击地图事件时，当前的annotation的泡泡是否隐藏，默认值为NO，V4.2.1以后支持
        annotationView.hidePaopaoWhenDoubleTapOnMap = NO;
        // 当发生单击地图事件时，当前的annotation的泡泡是否隐藏，默认值为YES，V4.2.1以后支持
        annotationView.hidePaopaoWhenSingleTapOnMap = NO;
        // 当发生两个手指点击地图（缩小地图）事件时，当前的annotation的泡泡是否隐藏，默认值为NO，V4.2.1以后支持
        annotationView.hidePaopaoWhenTwoFingersTapOnMap = NO;

        return annotationView;
    }

    return nil;
}

#pragma mark - UI

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kViewTopHeight)];
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.966854, 116.306761);
        _mapView.zoomLevel = 12;
        _mapView.delegate = self;
    }
    return _mapView;
}
@end
