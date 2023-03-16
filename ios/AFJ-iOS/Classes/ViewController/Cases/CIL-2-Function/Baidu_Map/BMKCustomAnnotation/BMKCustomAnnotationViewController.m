//
//  BMKCustomAnnotationViewController.m
//  BMKCustomAnnotationDemo
//
//  Created by Baidu on 2020/5/19.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import "BMKCustomAnnotationViewController.h"
#import "BMKCustomAnnotationView.h"

//复用annotationView的指定唯一标识
static NSString *annotationViewIdentifier = @"com.Baidu.BMKCustomAnnotationView";

@interface BMKCustomAnnotationViewController () <BMKMapViewDelegate>

/// 当前界面的mapView
@property(nonatomic, strong) BMKMapView *mapView;

@end

@implementation BMKCustomAnnotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"自定义标注图标";
    // 将mapView添加到当前视图中
    [self.view addSubview:self.mapView];
    [self createAnnotation];
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

/// 添加标注
- (void)createAnnotation {
    //初始化标注类BMKPointAnnotation的实例
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    //设置标注的经纬度坐标
    annotation.coordinate = CLLocationCoordinate2DMake(39.915, 116.404);
    /**
     向地图窗口添加标注，需要实现BMKMapViewDelegate的-mapView:viewForAnnotation:方法
     来生成标注对应的View
     
     @param annotation 要添加的标注
     */
    [_mapView addAnnotation:annotation];
}

#pragma mark - BMKMapViewDelegate

/// 根据anntation生成对应的annotationView
/// @param mapView 地图View
/// @param annotation 指定的标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    BMKCustomAnnotationView *annotationView = (BMKCustomAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
    if (!annotationView) {
        /**
         初始化并返回一个annotationView
         
         @param annotation 关联的annotation对象
         @param reuseIdentifier 如果要重用view，传入一个字符串，否则设为nil，建议重用view
         @return 初始化成功则返回annotationView，否则返回nil
         */
        annotationView = [[BMKCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier];
        return annotationView;
    }
    return nil;
}

#pragma mark - UI

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, CGRectGetHeight(self.view.frame) - kViewTopHeight)];
        _mapView.delegate = self;
    }
    return _mapView;
}

@end
