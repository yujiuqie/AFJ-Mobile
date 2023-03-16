//
//  BMKPickUpPointsViewController.m
//  BMKPickUpPointsDemo
//
//  Created by Baidu on 2020/5/18.
//  Copyright © 2020 Baidu. All rights reserved.
//
#define kHeight_BottomControlView  160

#import "BMKPickUpPointsViewController.h"
#import "BMKJumpingView.h"
#import "BMKPoiInfoCell.h"

// 开发者通过此delegate获取mapView的回调方法
@interface BMKPickUpPointsViewController () <BMKMapViewDelegate, BMKGeoCodeSearchDelegate, UITableViewDelegate, UITableViewDataSource> {

    NSIndexPath *_selectedIndexPath;
}
/// 当前界面的mapView
@property(nonatomic, strong) BMKMapView *mapView;

/// 当前界面的标注
@property(nonatomic, strong) BMKPointAnnotation *annotation;

/// 当前界面标注的view
@property(nonatomic, strong) BMKJumpingView *annotationView;

/// 展示poi的tableView
@property(nonatomic, strong) UITableView *poiTableView;

/// poiList
@property(nonatomic, copy) NSArray<BMKPoiInfo *> *poiList;

@end

@implementation BMKPickUpPointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"地图选点";
    // 将mapView添加到当前视图中
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.poiTableView];
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

/// 生成标注
- (void)createAnnotation {
    // 初始化标注类BMKPointAnnotation的实例
    _annotation = [[BMKPointAnnotation alloc] init];
    // 设置标注的经纬度坐标
    _annotation.coordinate = CLLocationCoordinate2DMake(40.009645, 116.333374);

    // 标注固定在指定屏幕位置,  必须与screenPointToLock一起使用。 注意：拖动Annotation isLockedToScreen会被设置为false。
    // 若isLockedToScreen为true，拖动地图时annotaion不会跟随移动；
    // 若isLockedToScreen为false，拖动地图时annotation会跟随移动。
    _annotation.isLockedToScreen = YES;

    // 标注锁定在屏幕上的位置，注意：地图初始化后才能设置screenPointToLock。可以在地图加载完成的回调方法：mapViewDidFinishLoading中使用此属性。
    _annotation.screenPointToLock = CGPointMake(CGRectGetWidth(_mapView.frame) * 0.5, CGRectGetHeight(_mapView.frame) * 0.5);
    // 地图添加标注
    [_mapView addAnnotation:_annotation];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf pickUpPointReverseGeoCode:weakSelf.annotation.coordinate];
    });

}

/// 地图拾取点后逆地理编码
- (void)pickUpPointReverseGeoCode:(CLLocationCoordinate2D)coordinate {
    // 初始化BMKGeoCodeSearch实例
    BMKGeoCodeSearch *geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    // 设置反地理编码检索的代理
    geoCodeSearch.delegate = self;
    // 初始化请求参数类BMKReverseGeoCodeOption的实例
    BMKReverseGeoCodeSearchOption *reverseGeoCodeOption = [[BMKReverseGeoCodeSearchOption alloc] init];
    // 待解析的经纬度坐标（必选）
    reverseGeoCodeOption.location = coordinate;
    // 是否访问最新版行政区划数据（仅对中国数据生效）
    reverseGeoCodeOption.isLatestAdmin = YES;
    BOOL flag = [geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    if (flag) {
        NSLog(@"反地理编码检索成功");
    } else {
        NSLog(@"反地理编码检索失败");
    }
}

#pragma mark - BMKMapViewDelegate

/// 根据anntation生成对应的annotationView
/// @param mapView 地图View
/// @param annotation 指定的标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isEqual:self.annotation]) {
        if (!_annotationView) {
            _annotationView = [[BMKJumpingView alloc] initWithAnnotation:annotation reuseIdentifier:@"com.Baidu.BMKJumpingView"];
        }
        return _annotationView;
    }
    return nil;
}

/// 地图区域即将改变时会调用此接口
/// @param mapView 地图View
/// @param animated 是否动画
/// @param reason 地区区域改变的原因
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated reason:(BMKRegionChangeReason)reason {
    // 手势触发导致地图区域变化，如双击、拖拽、滑动地图
    if (reason == BMKRegionChangeReasonGesture) {
        // 大头针跳起动画
        [self.annotationView jump];
    }
}

/// 地图区域改变完成后会调用此接口
/// @param mapView  地图View
/// @param animated 是否动画
/// @param reason 地区区域改变的原因
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated reason:(BMKRegionChangeReason)reason {
    // 手势触发导致地图区域变化，如双击、拖拽、滑动地图
    if (reason == BMKRegionChangeReasonGesture) {
        // 大头针落下动画
        [self.annotationView fall];
        // 选中点逆地理编码
        [self pickUpPointReverseGeoCode:_annotation.coordinate];
    }
}

#pragma mark - BMKGeoCodeSearchDelegate

/// 逆地理编码检索结果回调
/// @param searcher 检索对象
/// @param result 逆地理编码检索结果
/// @param error 错误码，@see BMKCloudErrorCode
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    NSLog(@" 逆地理编码检索结果 = %@", result.address);
    BMKPoiInfo *cur = [BMKPoiInfo new];
    cur.name = result.address;
    cur.address = result.sematicDescription;
    cur.pt = _annotation.coordinate;
    NSMutableArray <BMKPoiInfo *> *poiList = [NSMutableArray array];
    [poiList addObject:cur];
    [poiList addObjectsFromArray:result.poiList];
    self.poiList = [poiList copy];
    _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.poiTableView reloadData];
    });
}

#pragma mark - tableView

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.poiList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"poiList.cell";
    BMKPoiInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[BMKPoiInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    BMKPoiInfo *poi = self.poiList[indexPath.row];
    if (indexPath.row == 0) {
        [cell configTitle:[NSString stringWithFormat:@"【%@】", poi.name ? poi.name : @"位置"] subTitle:poi.address];
    } else {

        [cell configTitle:poi.name subTitle:poi.address];
    }
    if (_selectedIndexPath.section == indexPath.section && _selectedIndexPath.row == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedIndexPath == indexPath) {
        return;
    }
    _selectedIndexPath = indexPath;
    [tableView reloadData];
    BMKPoiInfo *sel = self.poiList[indexPath.row];
    [self.mapView setCenterCoordinate:sel.pt animated:YES];
}

#pragma mark - UI

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH - kViewTopHeight - kHeight_BottomControlView - KiPhoneXSafeAreaDValue)];
        _mapView.delegate = self;
        _mapView.zoomLevel = 17;
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(40.009645, 116.333374)];
    }
    return _mapView;
}

- (UITableView *)poiTableView {
    if (!_poiTableView) {
        _poiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_mapView.frame), SCREENW, kHeight_BottomControlView) style:UITableViewStylePlain];
        _poiTableView.backgroundColor = [UIColor whiteColor];
        _poiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _poiTableView.delegate = self;
        _poiTableView.dataSource = self;
    }
    return _poiTableView;
}

@end
