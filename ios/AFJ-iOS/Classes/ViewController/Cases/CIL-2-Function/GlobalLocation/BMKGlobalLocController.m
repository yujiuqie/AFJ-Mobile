//
//  BMKGlobalLocController.m
//  BMKGlobalLocOCDemo
//
//  Created by v_chiyuanwei on 2020/7/14.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKGlobalLocController.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>

#import "BMKGlobalLocTabView.h"
#import "BMKGlobalLocInfoView.h"

@interface BMKGlobalLocController () <BMKLocationManagerDelegate, BMKMapViewDelegate>
/// 地图
@property(nonatomic, strong) BMKMapView *mapView;
/// 单次/连续定位按钮
@property(nonatomic, strong) BMKGlobalLocTabView *locTabView;
/// 定位结果
@property(nonatomic, strong) BMKGlobalLocInfoView *locInfoView;
/// 单次定位管理类
@property(nonatomic, strong) BMKLocationManager *coldLocationManager;
/// 连续定位管理类
@property(nonatomic, strong) BMKLocationManager *hotLocationManager;
/// 单次定位Annotation
@property(nonatomic, strong) BMKPointAnnotation *coldAnnotation;
/// 连续定位Annotation
@property(nonatomic, strong) BMKPointAnnotation *hotAnnotation;
/// 连续定位次数
@property(nonatomic, assign) NSInteger hotLocCount;

@end

@implementation BMKGlobalLocController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"全球定位（单次/连续）";

    [self initialize];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 当mapView即将被显示的时候调用，恢复之前存储的mapView状态
    [self.mapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 当mapView即将被隐藏的时候调用，存储当前mapView的状态
    [self.mapView viewWillDisappear];
}

#pragma mark -

- (void)initialize {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:34.f / 255.f green:37.f / 255.f blue:61.f / 255.f alpha:1.f];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}

- (void)setupViews {
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.locTabView];
    [self.view addSubview:self.locInfoView];
}

#pragma mark -

/// 开始单次定位
- (void)startLocation {
    [self.coldLocationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation *_Nullable location, BMKLocationNetworkState state, NSError *_Nullable error) {
        if (error) {
            NSLog(@"locError:{%zd - %@};", error.code, error.localizedDescription);
            return;
        }
        if (location.location) {
            // 定位结果处理
            NSArray *locInfo = [self dataHandling:location flag:0];
            self.locInfoView.coldInfo = [locInfo componentsJoinedByString:@"\n"];
            // 定位结果展示
            [self showLocInfoView];
            // 更新我的位置数据
            [self updateColdUserLocation:location];
        }
    }];
}

/// 开始连续定位
- (void)startUpdatingLocation {
    [self.hotLocationManager startUpdatingLocation];
}

/// 停止连续定位
- (void)stopUpdatingLocation {
    self.hotLocCount = 0;
    [self.hotLocationManager stopUpdatingLocation];
}

/// 更新我的位置数据
/// 单次定位
- (void)updateColdUserLocation:(BMKLocation *)location {
    [[LocationManager shareManager] setLocation:location.location];
    // 设置Annotation位置
    self.coldAnnotation.coordinate = location.location.coordinate;
    // 添加Annotation
    if (![self.mapView.annotations containsObject:self.coldAnnotation]) {
        [self.mapView addAnnotation:self.coldAnnotation];
    }

    // 获取地图状态
    BMKMapStatus *mapStatus = [self.mapView getMapStatus];
    // 设置地图中心点
    mapStatus.targetGeoPt = location.location.coordinate;
    // 设置地图缩放级别
    mapStatus.fLevel = 18;
    // 设置地图状态
    [self.mapView setMapStatus:mapStatus withAnimation:YES withAnimationTime:1000];
}

/// 连续定位
- (void)updateHotUserLocation:(BMKLocation *)location {
    // 设置Annotation位置
    self.hotAnnotation.coordinate = location.location.coordinate;
    // 添加Annotation
    if (![self.mapView.annotations containsObject:self.hotAnnotation]) {
        [self.mapView addAnnotation:self.hotAnnotation];
    }

    // 获取地图状态
    BMKMapStatus *mapStatus = [self.mapView getMapStatus];
    // 设置地图中心点
    mapStatus.targetGeoPt = location.location.coordinate;
    // 设置地图缩放级别
    mapStatus.fLevel = 18;
    // 设置地图状态
    [self.mapView setMapStatus:mapStatus withAnimation:YES withAnimationTime:500];
}

#pragma mark - 定位数据处理

- (NSMutableArray *)dataHandling:(BMKLocation *)location flag:(int)flag {
    NSMutableArray *locInfo = [NSMutableArray array];
    // 连续定位次数
    NSString *locCount = [NSString stringWithFormat:@"%@%zd", @"定位次数：", _hotLocCount];
    // 定位时间
    NSString *startTime = [NSString stringWithFormat:@"%@%@", @"定位时间：", [self stringFromDate:[NSDate date]]];
    // 回调时间
    NSString *endTime = [NSString stringWithFormat:@"%@%@", @"回调时间：", [self stringFromDate:location.location.timestamp]];
    // 纬度
    NSString *lat = [NSString stringWithFormat:@"%@%f", @"纬度：", location.location.coordinate.latitude];
    // 经度
    NSString *lon = [NSString stringWithFormat:@"%@%f", @"经度：", location.location.coordinate.longitude];
    // 精度 (这里取的水平精度）
    NSString *horizontalAccuracy = [NSString stringWithFormat:@"%@%.f", @"精度：", location.location.horizontalAccuracy];
    // 方向
    NSString *course = [NSString stringWithFormat:@"%@%.f", @"方向：", location.location.course];
    // 国家编码
    NSString *countryCode = [NSString stringWithFormat:@"%@%@", @"国家编码：", location.rgcData.countryCode];
    // 国家
    NSString *country = [NSString stringWithFormat:@"%@%@", @"国家：", location.rgcData.country];
    // 省份
    NSString *province = [NSString stringWithFormat:@"%@%@", @"省份：", location.rgcData.province];
    // 城市编码
    NSString *cityCode = [NSString stringWithFormat:@"%@%@", @"城市编码：", location.rgcData.cityCode];
    // 城市
    NSString *city = [NSString stringWithFormat:@"%@%@", @"城市：", location.rgcData.city];
    // 县区
    NSString *district = [NSString stringWithFormat:@"%@%@", @"县区：", location.rgcData.district];
    // 乡镇街道
    NSString *town = [NSString stringWithFormat:@"%@%@", @"乡镇街道：", location.rgcData.town];
    // 附近街道
    NSString *street = [NSString stringWithFormat:@"%@%@", @"附近街道：", location.rgcData.street];
    // 地址
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", @"地址：", location.rgcData.country, location.rgcData.province, location.rgcData.city, location.rgcData.district, location.rgcData.town, location.rgcData.street];
    // 位置语义化
    NSString *poiRegion = [NSString stringWithFormat:@"%@%@", @"位置语义化：", location.rgcData.locationDescribe];
    // POI兴趣点
    NSString *poiCount = [NSString stringWithFormat:@"%@%zd", @"POI兴趣点：", location.rgcData.poiList.count];
    // SDK版本
    NSString *sdkv = [NSString stringWithFormat:@"%@%@", @"SDK版本：", BMKLocationKitVersion()];

    [locInfo removeAllObjects];
    if (flag) [locInfo addObject:locCount];
    [locInfo addObject:startTime];
    [locInfo addObject:endTime];
    [locInfo addObject:lon];
    [locInfo addObject:lat];
    [locInfo addObject:horizontalAccuracy];
    [locInfo addObject:course];
    [locInfo addObject:countryCode];
    [locInfo addObject:country];
    [locInfo addObject:province];
    [locInfo addObject:cityCode];
    [locInfo addObject:city];
    [locInfo addObject:district];
    [locInfo addObject:town];
    [locInfo addObject:street];
    [locInfo addObject:address];
    [locInfo addObject:poiRegion];
    [locInfo addObject:poiCount];
    [locInfo addObject:sdkv];

    return locInfo;
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];;
}

#pragma mark -

/// 显示定位结果View
- (void)showLocInfoView {
    self.locInfoView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.locInfoView.frame;
        frame.origin.y = CONTENT_HEIGHT - 300;
        self.locInfoView.frame = frame;
    }];
}

/// 隐藏定位结果View
- (void)hideLocInfoView {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.locInfoView.frame;
        frame.origin.y = CONTENT_HEIGHT;
        self.locInfoView.frame = frame;
    }                completion:^(BOOL finished) {
        self.locInfoView.hidden = YES;
    }];
}


#pragma mark - <BMKLocationManagerDelegate>

/// 连续定位回调函数
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    // 记录连续定位次数
    _hotLocCount += 1;

    // 定位错误信息
    if (error) {
        NSLog(@"locError:{%zd - %@};", error.code, error.localizedDescription);
        return;
    }

    // 定位结果
    if (location) {
        // 定位结果处理
        NSArray *locInfo = [self dataHandling:location flag:1];
        self.locInfoView.hotInfo = [locInfo componentsJoinedByString:@"\n"];
        // 定位结果展示
        [self showLocInfoView];
        // 更新我的位置数据
        [self updateHotUserLocation:location];
    }
}

#pragma mark - <BMKMapViewDelegate>

/// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        if (annotation == self.coldAnnotation) { // 单次定位
            BMKAnnotationView *coldAnnotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"coldAnnotationView"];
            if (!coldAnnotationView) {
                coldAnnotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"coldAnnotationView"];
                coldAnnotationView.image = [UIImage imageNamed:@"blue_annotation_icon"];
            }

            return coldAnnotationView;
        } else if (annotation == self.hotAnnotation) { // 连续定位
            BMKAnnotationView *hotAnnotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"hotAnnotationView"];
            if (!hotAnnotationView) {
                hotAnnotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"hotAnnotationView"];
                hotAnnotationView.image = [UIImage imageNamed:@"red_annotation_icon"];
            }

            return hotAnnotationView;
        }
    }

    return nil;
}

/// 点中底图空白处会回调此接口
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    // 点击地图空白隐藏定位结果view
    [self hideLocInfoView];
}

#pragma mark - getter

/// 地图
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT)];
        // 设置delegate
        _mapView.delegate = self;
    }
    return _mapView;
}

/// 单次定位管理类
- (BMKLocationManager *)coldLocationManager {
    if (!_coldLocationManager) {
        _coldLocationManager = [[BMKLocationManager alloc] init];
        // 设置返回位置的坐标系类型
        _coldLocationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        // 设置距离过滤参数
        _coldLocationManager.distanceFilter = kCLDistanceFilterNone;
        // 设置预期精度参数
        _coldLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 设置应用位置类型
        _coldLocationManager.activityType = CLActivityTypeAutomotiveNavigation;
        // 设置是否自动停止位置更新
        _coldLocationManager.pausesLocationUpdatesAutomatically = NO;
        // 设置位置获取超时时间
        _coldLocationManager.locationTimeout = 10;
        // 设置获取地址信息超时时间
        _coldLocationManager.reGeocodeTimeout = 10;
        // 设置delegate
        _coldLocationManager.delegate = self;
    }
    return _coldLocationManager;
}

/// 连续定位管理类
- (BMKLocationManager *)hotLocationManager {
    if (!_hotLocationManager) {
        _hotLocationManager = [[BMKLocationManager alloc] init];
        // 设置返回位置的坐标系类型
        _hotLocationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        // 设置距离过滤参数
        _hotLocationManager.distanceFilter = kCLDistanceFilterNone;
        // 设置预期精度参数
        _hotLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 设置应用位置类型
        _hotLocationManager.activityType = CLActivityTypeAutomotiveNavigation;
        // 设置是否自动停止位置更新
        _hotLocationManager.pausesLocationUpdatesAutomatically = NO;
        // 设置位置获取超时时间
        _hotLocationManager.locationTimeout = 10;
        // 设置获取地址信息超时时间
        _hotLocationManager.reGeocodeTimeout = 10;
        // 设置delegate
        _hotLocationManager.delegate = self;
    }
    return _hotLocationManager;
}

/// 单次/连续定位
- (BMKGlobalLocTabView *)locTabView {
    if (!_locTabView) {
        __weak typeof(self) weakSelf = self;
        _locTabView = [[BMKGlobalLocTabView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _locTabView.didClickTabBlock = ^(NSInteger idx, BOOL isSelected) {
            if (idx == 0) { // 开始单次定位
                [weakSelf startLocation];
            } else if (idx == 1) {
                if (isSelected) { // 开始连续定位
                    [weakSelf startUpdatingLocation];
                } else { // 停止连续定位
                    [weakSelf stopUpdatingLocation];
                }
            }
        };
    }
    return _locTabView;
}

/// 定位结果回调信息显示
- (BMKGlobalLocInfoView *)locInfoView {
    if (!_locInfoView) {
        _locInfoView = [[BMKGlobalLocInfoView alloc] initWithFrame:CGRectMake(10, CONTENT_HEIGHT, SCREEN_WIDTH - 20, 300)];
        _locInfoView.hidden = YES;
    }
    return _locInfoView;
}

- (BMKPointAnnotation *)coldAnnotation {
    if (!_coldAnnotation) {
        _coldAnnotation = [[BMKPointAnnotation alloc] init];
    }
    return _coldAnnotation;
}

- (BMKPointAnnotation *)hotAnnotation {
    if (!_hotAnnotation) {
        _hotAnnotation = [[BMKPointAnnotation alloc] init];
    }
    return _hotAnnotation;
}

@end
