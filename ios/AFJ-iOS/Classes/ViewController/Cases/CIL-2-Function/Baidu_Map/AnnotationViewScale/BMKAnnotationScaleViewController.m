//
//  ViewController.m
//  BMKAnnotationViewScaleDemo
//
//  Created by baidu on 2020/5/18.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKAnnotationScaleViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "BMKPinAnnotationScaleView.h"

//复用annotationView的指定唯一标识
static NSString *annotationViewIdentifier = @"com.Baidu.BMKPointAnnotation";

@interface BMKAnnotationScaleViewController () <BMKMapViewDelegate>
/// 当前界面的mapView
@property(nonatomic, strong) BMKMapView *mapView;
/// 当前界面的标注
@property(nonatomic, strong) BMKPointAnnotation *annotation;
@property(nonatomic, strong) BMKPinAnnotationScaleView *annotationView;
@property(nonatomic, strong) UIButton *addButton;
@property(nonatomic, strong) UIButton *startButton;
@end

@implementation BMKAnnotationScaleViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点标记缩放动画";
    self.navigationController.navigationBar.translucent = NO;
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

#pragma mark - BMKNavViewDelegate

- (void)didClickBackButton {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Config UI

- (void)configUI {
    [self createMapView];
    [self createAnnotation];

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 64 * widthScale)];
    [bgView setBackgroundColor:[COLOR(0x22253D) colorWithAlphaComponent:0.9]];
    [self.view addSubview:bgView];
    //添加/移除动画按钮
    _addButton = [[UIButton alloc] initWithFrame:CGRectMake(19 * widthScale, 15 * widthScale, 160 * widthScale, 34.5 * widthScale)];
    [_addButton setBackgroundColor:COLOR(0x292B3C)];
    [_addButton setTitle:@"添加动画" forState:UIControlStateNormal];
    [_addButton setTitle:@"移除动画" forState:UIControlStateSelected];
    [_addButton setImage:[UIImage imageNamed:@"添加动画"] forState:UIControlStateNormal];
    [_addButton setImage:[UIImage imageNamed:@"删除动画"] forState:UIControlStateSelected];
    [_addButton.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:15 * widthScale]];
    [_addButton setImageEdgeInsets:UIEdgeInsetsMake(6 * widthScale, 0, 6 * widthScale, 0)];
    _addButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _addButton.layer.cornerRadius = 17.25 * widthScale;
    _addButton.layer.masksToBounds = YES;
    [self.view addSubview:_addButton];

    _startButton = [[UIButton alloc] initWithFrame:CGRectMake((19 + 160 + 14.5) * widthScale, 15 * widthScale, 160 * widthScale, 34.5 * widthScale)];
    [_startButton setBackgroundColor:COLOR(0x292B3C)];
    [_startButton setTitle:@"暂停动画" forState:UIControlStateNormal];
    [_startButton setTitle:@"恢复动画" forState:UIControlStateSelected];
    [_startButton setImage:[UIImage imageNamed:@"暂停动画"] forState:UIControlStateNormal];
    [_startButton setImage:[UIImage imageNamed:@"播放动画"] forState:UIControlStateSelected];
    [_startButton.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:15 * widthScale]];
    _startButton.layer.cornerRadius = 17.25 * widthScale;
    [_startButton setImageEdgeInsets:UIEdgeInsetsMake(6 * widthScale, 0, 6 * widthScale, 0)];
    _startButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _startButton.layer.masksToBounds = YES;
    [self.view addSubview:_startButton];

    //绑定添加/移除动画按钮事件
    [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [_startButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
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
    //设置标注的经纬度坐标116.433612,39.911127
    _annotation.coordinate = CLLocationCoordinate2DMake(39.911127, 116.433607);
    //设置标注的标题
    _annotation.title = @"地铁-北京站";
    /**
     
     当前地图添加标注，需要实现BMKMapViewDelegate的-mapView:viewForAnnotation:方法
     来生成标注对应的View
     @param annotation 要添加的标注
     */
    [_mapView addAnnotation:_annotation];
}

#pragma mark - 动画相关

//添加移除动画事件
- (void)addAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.annotationView addAnimation];
        [sender setTitle:@"移除动画" forState:UIControlStateNormal];
    } else {
        [self.annotationView removeAnimation];
        [sender setTitle:@"添加动画" forState:UIControlStateNormal];
    }
}

//暂停恢复动画事件
- (void)startAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.annotationView pauseAnimation];
        [sender setTitle:@"恢复动画" forState:UIControlStateNormal];
    } else {
        [self.annotationView resumeAnimation];
        [sender setTitle:@"暂停动画" forState:UIControlStateNormal];
    }
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
        BMKPinAnnotationScaleView *annotationView = (BMKPinAnnotationScaleView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
        if (!annotationView) {
            /**
             初始化并返回一个annotationView
             
             @param annotation 关联的annotation对象
             @param reuseIdentifier 如果要重用view，传入一个字符串，否则设为nil，建议重用view
             @return 初始化成功则返回annotationView，否则返回nil
             */
            annotationView = [[BMKPinAnnotationScaleView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier];
        }
        //annotationView显示的图片
        annotationView.image = [UIImage imageNamed:@"水滴"];
        //在这里设置annotationView的锚点，避免设置anchorPoint造成annotationView偏移
        //锚点设置为（0.5, 1.0），默认（0.5, 0.5）
        annotationView.layer.anchorPoint = CGPointMake(0.5, 1.0);
        _annotationView = annotationView;
        return annotationView;
    }
    return nil;
}

#pragma mark - Lazy loading

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, CGRectGetHeight(self.view.frame) - kViewTopHeight)];
        _mapView.zoomLevel = 21;
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.911129, 116.433607);
    }
    return _mapView;
}

@end
