//
//  ViewController.m
//  BMKAnnotationViewMovingDemo
//
//  Created by baidu on 2020/5/18.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKAnnotationMovingViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

//复用annotationView的指定唯一标识
static NSString *annotationViewIdentifier = @"com.Baidu.BMKPointAnnotation";

@interface BMKAnnotationMovingViewController () <BMKMapViewDelegate>
/// 当前界面的mapView
@property(nonatomic, strong) BMKMapView *mapView;
/// 当前界面的标注
@property(nonatomic, strong) BMKPointAnnotation *annotation;
@property(nonatomic, strong) BMKPinAnnotationView *annotationView;
@end

@implementation BMKAnnotationMovingViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"点标记平移动画";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
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

#pragma mark - Config UI

- (void)configUI {
    [self createMapView];
    [self createAnnotation];
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 40 * widthScale)];
    tip.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13 * widthScale];
    tip.textColor = [UIColor whiteColor];
    tip.textAlignment = NSTextAlignmentCenter;
    tip.backgroundColor = [COLOR(0x22253D) colorWithAlphaComponent:0.8];
    tip.text = @"提示：点击地图，点标记平移";
    [self.view addSubview:tip];
}

- (void)createMapView {
    //将mapView添加到当前视图中
    [self.view addSubview:self.mapView];
    //设置mapView的代理
    _mapView.delegate = self;
}

- (void)createAnnotation {
    //初始化标注类BMKPointAnnotation的实例
    _annotation = [[BMKPointAnnotation alloc] init];
    //设置标注的经纬度坐标
    _annotation.coordinate = self.mapView.centerCoordinate;
    //设置标注的标题
    _annotation.title = @"平移动画";
    /**
     
     当前地图添加标注，需要实现BMKMapViewDelegate的-mapView:viewForAnnotation:方法
     来生成标注对应的View
     @param annotation 要添加的标注
     */
    [_mapView addAnnotation:_annotation];
}

#pragma mark - BMKNavViewDelegate

- (void)didClickBackButton {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

#pragma mark - 动画相关

//添加平移动画
- (void)addAnimationWithLocation:(CLLocationCoordinate2D)location {
    [UIView animateWithDuration:2.0
                          delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^(void) {
                self.annotation.coordinate = location;
            }        completion:nil];
}

#pragma mark - BMKMapViewDelegate

/**
 根据anntation生成对应的annotationView
 
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        /**
         根据指定标识查找一个可被复用的标注，用此方法来代替新创建一个标注，返回可被复用的标注
         */
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
        if (!annotationView) {
            /**
             初始化并返回一个annotationView
             
             @param annotation 关联的annotation对象
             @param reuseIdentifier 如果要重用view，传入一个字符串，否则设为nil，建议重用view
             @return 初始化成功则返回annotationView，否则返回nil
             */
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier];
        }
        //annotationView显示的图片
        annotationView.image = [UIImage imageNamed:@"水滴"];
        _annotationView = annotationView;
        return annotationView;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    [self addAnimationWithLocation:coordinate];
}

- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi {
    [self addAnimationWithLocation:mapPoi.pt];
}

#pragma mark - Lazy loading

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, CGRectGetHeight(self.view.frame) - kViewTopHeight)];
    }
    return _mapView;
}

@end
