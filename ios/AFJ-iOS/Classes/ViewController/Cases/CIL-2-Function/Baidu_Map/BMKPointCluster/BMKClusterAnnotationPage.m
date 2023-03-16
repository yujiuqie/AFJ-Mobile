//
//  BMKClusterAnnotationPage.m
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/6.
//  Copyright © 2018年 Baidu. All rights reserved.
//

#import "BMKClusterAnnotationPage.h"
#import "BMKClusterManager.h"

// 复用annotationView的指定唯一标识
static NSString *annotationViewIdentifier = @"com.Baidu.BMKClusterAnnotation";

#pragma mark - ClusterAnnotation

// 自定义标注
@interface ClusterAnnotation : BMKPointAnnotation

@property(nonatomic, assign) NSInteger size;

@end

@implementation ClusterAnnotation

@end

#pragma mark - BMKClusterAnnotationPage

@interface BMKClusterAnnotationPage ()

@property(nonatomic, strong) BMKMapView *mapView; //当前界面的mapView

@property(nonatomic, strong) BMKClusterManager *clusterManager;

@property(nonatomic, assign) NSUInteger clusterZoom;

@end

@implementation BMKClusterAnnotationPage

#pragma mark - Initialization method

- (instancetype)init {
    self = [super init];
    if (self) {
        //点聚合管理类
        _clusterManager = [[BMKClusterManager alloc] init];
    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self createMapView];
}

- (void)viewWillAppear:(BOOL)animated {
    //当mapView即将被显示的时候调用，恢复之前存储的mapView状态
    [_mapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    //当mapView即将被隐藏的时候调用，存储当前mapView的状态
    [_mapView viewWillDisappear];
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"点聚合";
}

- (void)createMapView {
    // 将mapView添加到当前视图中
    [self.view addSubview:self.mapView];
    // 设置mapView的代理
    _mapView.delegate = self;
}

#pragma mark - Clusters

- (void)updateClusters {
    _clusterZoom = (NSInteger) _mapView.zoomLevel;
    @synchronized (_clusterManager.clusterCaches) {
        NSMutableArray *clusters = [_clusterManager.clusterCaches objectAtIndex:(_clusterZoom - 3)];
        if (clusters.count > 0) {

            // 移除一组标注
            [_mapView removeAnnotations:_mapView.annotations];
            //将一组标注添加到当前地图View中
            [_mapView addAnnotations:clusters];
        } else {
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // 获取聚合后的标注
                __block NSArray *array = [weakSelf.clusterManager getClusters:weakSelf.clusterZoom];
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (BMKCluster *item in array) {
                        ClusterAnnotation *annotation = [[ClusterAnnotation alloc] init];
                        // 设置标注的经纬度坐标
                        annotation.coordinate = item.coordinate;
                        annotation.size = item.size;
                        // 设置标注的标题
                        annotation.title = [NSString stringWithFormat:@"我是%lu个", (unsigned long) item.size];
                        [clusters addObject:annotation];
                    }
                    // 移除一组标注
                    [weakSelf.mapView removeAnnotations:weakSelf.mapView.annotations];
                    // 将一组标注添加到当前地图View中
                    [weakSelf.mapView addAnnotations:clusters];
                });
            });
        }
    }
}

#pragma mark - BMKMapViewDelegate

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    ClusterAnnotation *cluster = (ClusterAnnotation *) annotation;
    BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier];
    UILabel *annotationLabel = [[UILabel alloc] init];
    annotationLabel.textColor = [UIColor whiteColor];
    annotationLabel.font = [UIFont systemFontOfSize:11];
    annotationLabel.textAlignment = NSTextAlignmentCenter;
    annotationLabel.hidden = NO;
    annotationLabel.text = [NSString stringWithFormat:@"%ld", (long) cluster.size];
    annotationLabel.backgroundColor = [UIColor greenColor];
    annotationView.alpha = 0.8;
    [annotationView addSubview:annotationLabel];
    // 此处为了方便展示使用了简易的大头针标注，开发者可以根据自身需求来自定义标注，圆角设置建议使用圆形图片
    if (cluster.size == 1) {
        annotationLabel.hidden = YES;
        annotationView.pinColor = BMKPinAnnotationColorRed;
    }
    if (cluster.size >= 500) {
        annotationLabel.frame = CGRectMake(0, 0, 100, 100);
        annotationLabel.layer.cornerRadius = 50;
        annotationLabel.layer.masksToBounds = YES;
        annotationLabel.backgroundColor = [UIColor redColor];
        [annotationView setBounds:CGRectMake(0, 0, 100, 100)];
    } else if (cluster.size >= 200 && cluster.size < 500) {
        annotationLabel.frame = CGRectMake(0, 0, 80, 80);
        annotationLabel.layer.cornerRadius = 40;
        annotationLabel.layer.masksToBounds = YES;
        annotationLabel.backgroundColor = [UIColor purpleColor];
        [annotationView setBounds:CGRectMake(0, 0, 80, 80)];
    } else if (cluster.size > 50) {
        annotationLabel.frame = CGRectMake(0, 0, 60, 60);
        annotationLabel.layer.cornerRadius = 30;
        annotationLabel.layer.masksToBounds = YES;
        annotationLabel.backgroundColor = [UIColor orangeColor];
        [annotationView setBounds:CGRectMake(0, 0, 60, 60)];
    } else if (cluster.size > 20) {
        annotationLabel.frame = CGRectMake(0, 0, 40, 40);
        annotationLabel.layer.cornerRadius = 20;
        annotationLabel.layer.masksToBounds = YES;
        annotationLabel.backgroundColor = [UIColor blueColor];
        [annotationView setBounds:CGRectMake(0, 0, 40, 40)];
    } else {
        annotationLabel.frame = CGRectMake(0, 0, 20, 20);
        annotationLabel.layer.cornerRadius = 10;
        annotationLabel.layer.masksToBounds = YES;
        annotationLabel.backgroundColor = [UIColor greenColor];
        [annotationView setBounds:CGRectMake(0, 0, 20, 20)];
    }
    annotationView.draggable = YES;
    annotationView.annotation = annotation;
    return annotationView;
}

/**
 当点击annotationView弹出的泡泡时，回调此方法
 
 @param mapView 地图View
 @param view 泡泡所属的annotationView
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
    if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
        ClusterAnnotation *clusterAnnotation = (ClusterAnnotation *) view.annotation;
        if (clusterAnnotation.size > 1) {
            /**
             设定地图中心点坐标
             @param coordinate 要设定的地图中心点坐标，用经纬度表示
             @param animated 是否采用动画效果
             */
            [mapView setCenterCoordinate:view.annotation.coordinate];
            /**
             放大一级比例尺
             
             @return 是否成功
             */
            [mapView zoomIn];
        }
    }
}

/**
 地图加载完成时会调用此方法
 
 @param mapView 当前地图View
 */
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    [self updateClusters];
}

/**
 地图渲染每一帧画面过程中，以及每次需要重新绘制地图时(例如添加覆盖物)都会调用此方法
 
 @param mapView 地图View
 @param status 地图状态
 */
- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus *)status {
    if (_clusterZoom != 0 && _clusterZoom != (NSInteger) mapView.zoomLevel) {
        [self updateClusters];
    }
}

#pragma mark - Lazy loading

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, CGRectGetHeight(self.view.frame) - kViewTopHeight)];
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(40.155, 116.894)];
        _mapView.zoomLevel = 10;
    }
    return _mapView;
}

@end
