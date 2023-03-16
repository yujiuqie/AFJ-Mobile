//
//  ViewController.m
//  BMKBikeRoutePlanDemo
//
//  Created by baidu on 2020/5/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKBikeRoutePlanViewController.h"
#import "BMKBikeRouteDetailViewController.h"
#import "BMKFootView.h"
#import "BMKCustomSelectedButton.h"
#import "BMKRoutePlanSearchView.h"
#import "BMKCustomSelectedButton.h"
#import "BMKBikeRouteDetailModel.h"

//复用annotationView的指定唯一标识
static NSString *annotationViewIdentifier = @"com.Baidu.BMKPointAnnotation";

@interface BMKBikeRoutePlanViewController () <BMKMapViewDelegate, BMKRouteSearchDelegate, BMKFootViewDelegate, BMKRoutePlanSearchViewDelegate, BMKCustomSelectedButtonDelegate>
/// 当前界面的mapView
@property(nonatomic, strong) BMKMapView *mapView;
@property(nonatomic, strong) BMKPointAnnotation *startAnnotation;
@property(nonatomic, strong) BMKPointAnnotation *endAnnotation;
@property(nonatomic, strong) BMKRoutePlanSearchView *searchView;
@property(nonatomic, strong) BMKFootView *footView;
@property(nonatomic, strong) BMKRouteSearch *bikeRouteSearch;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) BMKRidingRouteLine *routeLine;
@property(nonatomic, assign) NSInteger ridingType;
@property(nonatomic, strong) NSArray <BMKBikeRouteDetailModel *> *detailModels;
@end

@implementation BMKBikeRoutePlanViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self createMapView];
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
    self.title = @"骑行路线规划";
    self.view.backgroundColor = [UIColor whiteColor];

    _searchView = [[BMKRoutePlanSearchView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 143.5 * widthScale)];
    _searchView.delegate = self;
    [self.view addSubview:_searchView];

    BMKCustomSelectedButton *ridingTypeButton = [[BMKCustomSelectedButton alloc] initWithFrame:CGRectMake(20 * widthScale, 111 * widthScale, SCREENW - 40 * widthScale, 12.5 * widthScale)];
    ridingTypeButton.delegate = self;
    [_searchView addSubview:ridingTypeButton];

    _footView = [[BMKFootView alloc] initWithFrame:CGRectMake(19 * widthScale, SCREENH - 19 * widthScale - 143.5 * widthScale - (kViewTopHeight + KiPhoneXSafeAreaDValue), SCREENW - 19 * 2 * widthScale, 143.5 * widthScale)];
    _footView.delegate = self;
    _footView.hidden = YES;
    [self.view addSubview:_footView];
}

#pragma mark - BMKNavViewDelegate

- (void)didClickSearchButton {
    [self routePlan];
}

#pragma mark - BMKCustomSelectedButtonDelegate

- (void)didClickSelectButton:(UIButton *)sender {
    if (sender.selected) {
        _ridingType = 1;
    } else {
        _ridingType = 0;
    }
}

#pragma mark - BMKFootViewDelegate

- (void)didClickDetailButton {
    BMKBikeRouteDetailViewController *controller = [[BMKBikeRouteDetailViewController alloc] init];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    controller.routeLine = self.routeLine;
    controller.detailModels = self.detailModels;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)routePlan {
    if (_searchView.startTextField.text.length == 0 || _searchView.endTextField.text.length == 0) {
        [self alertMessage:@"起点终点不能为空！"];
        return;
    }
    //初始化BMKRouteSearch实例
    _bikeRouteSearch = [[BMKRouteSearch alloc] init];
    //设置骑行路径规划的代理
    _bikeRouteSearch.delegate = self;
    //初始化BMKPlanNode实例，检索起点
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    //起点名称
    start.name = _searchView.startTextField.text;
    //起点所在城市，注：cityName和cityID同时指定时，优先使用cityID
    start.cityName = @"北京";
    //初始化BMKPlanNode实例，检索终点
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    //终点名称
    end.name = _searchView.endTextField.text;
    //终点所在城市，注：cityName和cityID同时指定时，优先使用cityID
    end.cityName = @"北京";
    //初始化请求参数类BMKWalkingRoutePlanOption的实例
    BMKRidingRoutePlanOption *ridingRoutePlanOption = [[BMKRidingRoutePlanOption alloc] init];
    //检索的起点，可通过关键字、坐标两种方式指定。cityName和cityID同时指定时，优先使用cityID
    ridingRoutePlanOption.from = start;
    //检索的终点，可通过关键字、坐标两种方式指定。cityName和cityID同时指定时，优先使用cityID
    ridingRoutePlanOption.to = end;
    ridingRoutePlanOption.ridingType = self.ridingType;

    /**
     发起步行路线检索请求，异步函数，返回结果在BMKRouteSearchDelegate的onGetWalkingRouteResult中
     */
    BOOL flag = [_bikeRouteSearch ridingSearch:ridingRoutePlanOption];
    if (flag) {
        NSLog(@"骑行检索成功");
    } else {
        NSLog(@"骑行检索失败");
        [self alertMessage:@"骑行路线规划失败！"];
    }
}

- (void)alertMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)createMapView {
    //将mapView添加到当前视图中
    [self.view addSubview:self.mapView];
    //设置mapView的代理
    _mapView.delegate = self;
}

#pragma mark - BMKRouteSearchDelegate

/**
 返回骑行路线检索结果

 @param searcher 检索对象
 @param result 检索结果，类型为BMKRidingRouteResult
 @param error 错误码，@see BMKSearchErrorCode
 */
- (void)onGetRidingRouteResult:(BMKRouteSearch *)searcher result:(BMKRidingRouteResult *)result errorCode:(BMKSearchErrorCode)error {

    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeAnnotations:_mapView.annotations];

    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *tempArray = [NSMutableArray array];
        //+polylineWithPoints: count:坐标点的个数
        __block NSUInteger pointCount = 0;
        //获取所有骑行路线中第一条路线
        BMKRidingRouteLine *routeline = (BMKRidingRouteLine *) result.routes.firstObject;
        _routeLine = routeline;
        //遍历骑行路线中的所有路段
        [routeline.steps enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            //获取骑行路线中的每条路段
            BMKRidingStep *step = routeline.steps[idx];
            BMKBikeRouteDetailModel *model = [[BMKBikeRouteDetailModel alloc] init];
            model.instruction = step.instruction;
            NSString *instruction = step.instruction;
            NSDictionary *attrs = @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:16 * widthScale]};
            CGSize size = CGSizeMake(SCREENW - 86 * widthScale, MAXFLOAT);
            CGSize actualsize = [instruction boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
            model.cellHeight = actualsize.height + 48 * widthScale;
            [tempArray addObject:model];
            //统计路段所经过的地理坐标集合内点的个数
            pointCount += step.pointsCount;
        }];
        _detailModels = [tempArray copy];
        //+polylineWithPoints: count:指定的直角坐标点数组
        BMKMapPoint *points = new BMKMapPoint[pointCount];
        __block NSUInteger j = 0;
        //遍历骑行路线中的所有路段
        [routeline.steps enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            //获取骑行路线中的每条路段
            BMKRidingStep *step = routeline.steps[idx];
            for (NSUInteger i = 0; i < step.pointsCount; i++) {
                //将每条路段所经过的地理坐标点赋值给points
                points[j].x = step.points[i].x;
                points[j].y = step.points[i].y;
                j++;
            }
        }];
        //设置起点
        CLLocationCoordinate2D start = BMKCoordinateForMapPoint(points[0]);
        _startAnnotation = [[BMKPointAnnotation alloc] init];
        _startAnnotation.coordinate = start;
        [self.mapView addAnnotation:_startAnnotation];
        //设置终点
        CLLocationCoordinate2D end = BMKCoordinateForMapPoint(points[pointCount - 1]);
        _endAnnotation = [[BMKPointAnnotation alloc] init];
        _endAnnotation.coordinate = end;
        [self.mapView addAnnotation:_endAnnotation];
        //根据指定直角坐标点生成一段折线
        BMKPolyline *polyline = [BMKPolyline polylineWithPoints:points count:pointCount];
        /**
         向地图View添加Overlay，需要实现BMKMapViewDelegate的-mapView:viewForOverlay:方法
         来生成标注对应的View
         
         @param overlay 要添加的overlay
         */
        [_mapView addOverlay:polyline];
        //根据polyline设置地图范围
        [self mapViewFitPolyline:polyline];

        [_footView updateData:self.routeLine];
        _footView.hidden = NO;
    } else {
        _footView.hidden = YES;
        [self alertMessage:@"路线规划失败,请确认起终点信息！"];
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
        if (annotation == self.startAnnotation) {
            annotationView.image = [UIImage imageNamed:@"icon_start"];
        } else if (annotation == self.endAnnotation) {
            annotationView.image = [UIImage imageNamed:@"icon_end"];
        }
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
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        //初始化一个overlay并返回相应的BMKPolylineView的实例
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithPolyline:overlay];
        polylineView.lineWidth = 8.f;
        [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"traffic_texture_unknown"]];
        return polylineView;
    }
    return nil;
}

//根据polyline设置地图范围
- (void)mapViewFitPolyline:(BMKPolyline *)polyline {
    double leftTop_x, leftTop_y, rightBottom_x, rightBottom_y;
    if (polyline.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyline.points[0];
    leftTop_x = pt.x;
    leftTop_y = pt.y;
    //左上方的点lefttop坐标（leftTop_x，leftTop_y）
    rightBottom_x = pt.x;
    rightBottom_y = pt.y;
    //右底部的点rightbottom坐标（rightBottom_x，rightBottom_y）
    for (int i = 1; i < polyline.pointCount; i++) {
        BMKMapPoint point = polyline.points[i];
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
    UIEdgeInsets padding = UIEdgeInsetsMake(180 * widthScale, 20 * widthScale, 160 * widthScale, 20 * widthScale);
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


@end
