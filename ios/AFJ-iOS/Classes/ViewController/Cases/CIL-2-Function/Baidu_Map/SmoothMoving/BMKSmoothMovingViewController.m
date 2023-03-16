//
//  BMKSmoothMovingViewController.m
//  BMKSmoothMovingDemo
//
//  Created by baidu on 2020/5/19.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKSmoothMovingViewController.h"

//复用annotationView的指定唯一标识
static NSString *annotationViewIdentifier = @"com.Baidu.BMKPointAnnotation";

@interface BMKSmoothMovingViewController () <BMKMapViewDelegate>
/// 当前界面的mapView
@property(nonatomic, strong) BMKMapView *mapView;
/// 当前界面的多边形（运动轨迹）
@property(nonatomic, strong) BMKPolygon *pathPolygon;
/// 当前界面的标注
@property(nonatomic, strong) BMKPointAnnotation *annotation;
@property(nonatomic, strong) BMKAnnotationView *annotationView;
@property(nonatomic, assign) double sumDistance;
@property(nonatomic, assign) NSUInteger currentIndex;
@property(nonatomic, strong) NSMutableArray *sportNodes;
@property(nonatomic, strong) NSMutableArray<BMKSportNode *> *animationSportNodes;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, assign) NSUInteger sportNodeNum;
@property(nonatomic, assign) BOOL stopAnimation;

@end

@implementation BMKSmoothMovingViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"平滑移动";
    [self configUI];
    [self calcAnimationCoord];
    [self startAnimation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //当mapView即将被显示的时候调用，恢复之前存储的mapView状态
    [_mapView viewWillAppear];
    self.stopAnimation = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //当mapView即将被隐藏的时候调用，存储当前mapView的状态
    [_mapView viewWillDisappear];
    self.stopAnimation = YES;
}

#pragma mark - Config UI

- (void)configUI {
    [self createMapView];
    [self fetchSportNodes];
    [self createAnnotation];
    /**
    根据多个经纬点生成多边形

    @param coords 经纬度坐标点数组
    @param count 点的个数
    @return 新生成的BMKPolygon实例
    */
    CLLocationCoordinate2D paths[_sportNodeNum];
    for (NSUInteger i = 0; i < _sportNodeNum; i++) {
        BMKSportNode *node = _sportNodes[i];
        paths[i] = node.coordinate;
    }
    _pathPolygon = [BMKPolygon polygonWithCoordinates:paths count:_sportNodeNum];
    /**
    向地图View添加Overlay，需要实现BMKMapViewDelegate的-mapView:viewForOverlay:
    方法来生成标注对应的View

    @param overlay 要添加的overlay
    */
    [_mapView addOverlay:_pathPolygon];
    [self mapViewFitPolygon:_pathPolygon];
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
    [_annotation setCoordinate:((BMKSportNode *) self.sportNodes[0]).coordinate];
    //设置标注的标题
    _annotation.title = @"小车";
    /**
     
     当前地图添加标注，需要实现BMKMapViewDelegate的-mapView:viewForAnnotation:方法
     来生成标注对应的View
     @param annotation 要添加的标注
     */
    [_mapView addAnnotation:_annotation];
}

#pragma mark - 动画相关

- (void)startAnimation {
    BMKSportNode *node = self.animationSportNodes[self.currentIndex];
    CGFloat angle = self.mapView.rotation / 180.0 * M_PI;
    self.imageView.transform = CGAffineTransformMakeRotation(node.direction - angle);

    [UIView animateWithDuration:node.duration
                          delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^(void) {
                [self.annotation setCoordinate:((BMKSportNode *) self.animationSportNodes[(self.currentIndex + 1) % self.animationSportNodes.count]).coordinate];
            }        completion:^(BOOL finished) {
                if (!self.stopAnimation) {
                    self.currentIndex++;
                    self.currentIndex %= self.animationSportNodes.count;
                    __weak id weakSelf = self;
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [weakSelf startAnimation];
                    }];
                }
            }];
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
        BMKAnnotationView *annotationView = (BMKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
        if (!annotationView) {
            /**
             初始化并返回一个annotationView
             
             @param annotation 关联的annotation对象
             @param reuseIdentifier 如果要重用view，传入一个字符串，否则设为nil，建议重用view
             @return 初始化成功则返回annotationView，否则返回nil
             */
            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier];
        }
        annotationView.frame = CGRectMake(0, 0, 40, 40);
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        BMKSportNode *node = self.animationSportNodes[self.currentIndex];
        _imageView.transform = CGAffineTransformMakeRotation(node.direction);
        _imageView.image = [UIImage imageNamed:@"icon_car"];
        [annotationView addSubview:_imageView];
        _annotationView = annotationView;
        return annotationView;
    }
    return nil;
}

/**
 根据overlay生成对应的BMKOverlayView
 
 @param mapView 地图View
 @param overlay 指定的overlay
 @return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolygon class]]) {
        //初始化一个overlay并返回相应的BMKPolygonView的实例
        BMKPolygonView *polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        //设置polylineView的画笔（边框）颜色
        polygonView.strokeColor = [[UIColor alloc] initWithRed:0 green:0.5 blue:0 alpha:0.6];
        //设置polylineView的线宽度
        polygonView.lineWidth = 6.0;
        return polygonView;
    }
    return nil;
}

//根据polygon设置地图范围
- (void)mapViewFitPolygon:(BMKPolygon *)polygon {
    double leftTop_x, leftTop_y, rightBottom_x, rightBottom_y;
    if (polygon.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polygon.points[0];
    leftTop_x = pt.x;
    leftTop_y = pt.y;
    //左上方的点lefttop坐标（leftTop_x，leftTop_y）
    rightBottom_x = pt.x;
    rightBottom_y = pt.y;
    //右底部的点rightbottom坐标（rightBottom_x，rightBottom_y）
    for (int i = 1; i < polygon.pointCount; i++) {
        BMKMapPoint point = polygon.points[i];
        if (point.x < leftTop_x) {
            leftTop_x = point.x;
        }
        if (point.x > rightBottom_x) {
            rightBottom_x = point.x;
        }
        if (point.y < leftTop_y) {
            leftTop_y = point.y;
        }
        if (point.y > rightBottom_y) {
            rightBottom_y = point.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(leftTop_x, leftTop_y);
    rect.size = BMKMapSizeMake(rightBottom_x - leftTop_x, rightBottom_y - leftTop_y);
    UIEdgeInsets padding = UIEdgeInsetsMake(KStatuesBarHeight + 80 * widthScale, 20, KStatuesBarHeight + 80 * widthScale, 20);
    [_mapView fitVisibleMapRect:rect edgePadding:padding withAnimated:YES];
}

#pragma mark - Lazy loading

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, CGRectGetHeight(self.view.frame) - kViewTopHeight)];
        _mapView.zoomLevel = 18;
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.977652209132174, 116.34821304891533);
    }
    return _mapView;
}

#pragma mark - SportPath

- (void)fetchSportNodes {
    self.sumDistance = 0;
    _sportNodes = [NSMutableArray array];
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sport_path" ofType:@"json"]];
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    for (int i = 0; i < array.count; i++) {
        NSDictionary *current = array[i];
        CLLocationCoordinate2D startCoor = CLLocationCoordinate2DMake([current[@"lat"] doubleValue], [current[@"lon"] doubleValue]);
        NSDictionary *next = array[(i + 1) % array.count];
        CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake([next[@"lat"] doubleValue], [next[@"lon"] doubleValue]);
        CLLocation *begin = [[CLLocation alloc] initWithLatitude:startCoor.latitude longitude:startCoor.longitude];
        CLLocation *end = [[CLLocation alloc] initWithLatitude:endCoor.latitude longitude:endCoor.longitude];
        CLLocationDistance distance = [end distanceFromLocation:begin];
        CLLocationDirection direction = BMKGetDirectionFromCoords(begin.coordinate, end.coordinate);
        self.sumDistance += distance;

        BMKSportNode *sportNode = [[BMKSportNode alloc] init];
        sportNode.coordinate = startCoor;
        sportNode.distance = distance;
        sportNode.direction = direction / 180 * M_PI;
        [_sportNodes addObject:sportNode];
    }
    _sportNodeNum = _sportNodes.count;
}

/// 计算动画坐标点
- (void)calcAnimationCoord {
    NSMutableArray *animationSportNodes = [NSMutableArray array];
    [_sportNodes enumerateObjectsUsingBlock:^(BMKSportNode *obj, NSUInteger idx, BOOL *_Nonnull stop) {
        BMKSportNode *curNode = obj;
        BMKSportNode *nextNode = _sportNodes[(idx + 1) % _sportNodes.count];

        // 经纬度 -> 墨卡托
        CGPoint curPoint = BMKConvertToBaiduMercatorFromBD09LL(curNode.coordinate);
        CGPoint nextPoint = BMKConvertToBaiduMercatorFromBD09LL(nextNode.coordinate);
        // 计算俩个坐标点之间的距离
        CGFloat distanceX = nextPoint.x - curPoint.x;
        CGFloat distanceY = nextPoint.y - curPoint.y;
        CGFloat distance = hypot(distanceX, distanceY);
        // 计算距离拆分数量 eg. distance = 61.2 分成ceil(61.2 / 5) = 13段 （地图最小比例尺=5）
        NSInteger count = ceil(distance / 5);
        // 拆分后每段长<=5
        CGFloat perDx = distanceX / count;
        CGFloat perDy = distanceY / count;
        // 动画时间 （0.04s/m）
        CGFloat dur = distance / count * 0.035;

        for (int i = 0; i < count; i++) {
            BMKSportNode *node = [[BMKSportNode alloc] init];
            node.duration = dur;
            node.direction = curNode.direction;

            // 计算每段对应的墨卡托坐标
            double lat = curPoint.y + perDy * i;
            double lon = curPoint.x + perDx * i;
            // 墨卡托坐标 -> 经纬度坐标
            node.coordinate = BMKConvertToBD09LLFromBaiduMercator(CGPointMake(lon, lat));
            [animationSportNodes addObject:node];
        }
    }];

    self.animationSportNodes = animationSportNodes;
}

@end

@implementation BMKSportNode

@end
