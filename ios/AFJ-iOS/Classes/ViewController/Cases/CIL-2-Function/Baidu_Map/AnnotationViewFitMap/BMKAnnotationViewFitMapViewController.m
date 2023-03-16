//
//  BMKAnnotationViewFitMapViewController.m
//  BaiduMapSDKDemo
//
//  Created by baidu on 2020/7/16.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKAnnotationViewFitMapViewController.h"
#import "UIImage+BMKImage.h"

@interface BMKAnnotationViewFitMapViewController () <BMKMapViewDelegate, UISearchBarDelegate, BMKPoiSearchDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

/// 当前界面的mapView
@property(nonatomic, strong) BMKMapView *mapView;

/// poilist
@property(nonatomic, copy) NSArray<BMKPoiInfo *> *poiList;

/// 自定义检索View
@property(nonatomic, strong) UIView *searchView;

/// 当前界面选择的poi展示label
@property(nonatomic, strong) UILabel *addressLabel;

/// 展示poi的tableView
@property(nonatomic, strong) UITableView *poiTableView;

@property(nonatomic, strong) UIButton *showButton;

@end

@implementation BMKAnnotationViewFitMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"点标记适配屏幕";
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.poiTableView];

    [self addAnnotationViews:self.poiList];
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

- (void)showAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self showIn];
    } else {
        [self showOut];
    }
    [self.poiTableView reloadData];
}

- (void)showIn {
    [UIView animateWithDuration:0.2 animations:^{
        self.poiTableView.frame = CGRectMake(0, SCREENH - 30 * widthScale - kViewTopHeight - KiPhoneXSafeAreaDValue, SCREENW, 30 * widthScale + KiPhoneXSafeAreaDValue);
    }];
    [self fitAnnotationViews];
}

- (void)showOut {
    [UIView animateWithDuration:0.2 animations:^{
        self.poiTableView.frame = CGRectMake(0, SCREENH - 375 * widthScale - kViewTopHeight - KiPhoneXSafeAreaDValue, SCREENW, 375 * widthScale + KiPhoneXSafeAreaDValue);
    }];
    [self fitAnnotationViews];
}

- (void)addAnnotationViews:(NSArray *)poiList {
    NSMutableArray *annotations = [NSMutableArray array];
    for (BMKPoiInfo *info in poiList) {
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
        annotation.coordinate = info.pt;
        annotation.title = info.name;
        [annotations addObject:annotation];
    }
    [self.mapView addAnnotations:[annotations copy]];
    [self fitAnnotationViews];
}

- (void)fitAnnotationViews {
    self.mapView.mapPadding = UIEdgeInsetsMake(80, 0, self.poiTableView.frame.size.height, 0);
    [self showAnnotations:self.mapView.annotations animated:YES];
}

- (void)showAnnotations:(NSArray *)annotations animated:(BOOL)animated {
    if (!annotations || annotations.count == 0) {
        return;
    }
    //只有一个则直接设置地图中心为annotation的位置
    if (annotations.count == 1) {
        id <BMKAnnotation> annotation = [annotations firstObject];
        [_mapView setCenterCoordinate:annotation.coordinate animated:animated];
        return;
    }

    double left = DBL_MAX;
    double right = DBL_MIN;
    double top = DBL_MAX;
    double bottom = DBL_MIN;
    for (id <BMKAnnotation> annotation in annotations) {
        //如果是固定在屏幕上的，则不进行计算，会影响展示效果。
        if ([annotation isKindOfClass:[BMKPointAnnotation class]] && ((BMKPointAnnotation *) annotation).isLockedToScreen) {
            continue;
        }
        BMKMapPoint point = BMKMapPointForCoordinate([annotation coordinate]);
        left = fmin(left, point.x);
        right = fmax(right, point.x);
        top = fmin(top, point.y);
        bottom = fmax(bottom, point.y);
    }

    double x = left;
    double y = top;
    double width = right - left;
    double height = bottom - top;
    if (width > 0 && height > 0) {
        BMKMapRect newRect = BMKMapRectMake(x, y, width, height);
        if (newRect.size.width == 0) {
            newRect.size.width = 1;
        }
        if (newRect.size.height == 0) {
            newRect.size.height = 1;
        }
        //为了更好的展示效果且不影响地图其他控件的位置在这里+50
        CGFloat scale = 50 * widthScale;
        UIEdgeInsets padding = UIEdgeInsetsMake(self.mapView.mapPadding.top + scale, self.mapView.mapPadding.left + scale, self.mapView.mapPadding.bottom + scale, self.mapView.mapPadding.right + scale);
        [self.mapView fitVisibleMapRect:newRect edgePadding:padding withAnimated:YES];
    }
}

#pragma mark - BMKMapViewDelegate

/// 根据anntation生成对应的annotationView
/// @param mapView 地图View
/// @param annotation 指定的标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"com.Baidu.BMKPointAnnotation"];
        if (!annotationView) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"com.Baidu.BMKPointAnnotation"];
        }
        annotationView.pinColor = BMKPinAnnotationColorRed;
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
}


#pragma mark - tableView

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.showButton.selected) {
        return 0;
    }
    return [self.poiList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 75 * widthScale;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"poiList.cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:19];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:139.f / 255.f green:126.f / 255.f blue:102.f / 255.f alpha:1.f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    BMKPoiInfo *poi = self.poiList[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.showButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGRectGetHeight(self.showButton.frame);
}

#pragma mark - UI

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, CGRectGetHeight(self.view.frame) - kViewTopHeight)];
        _mapView.delegate = self;
        _mapView.zoomLevel = 16;
    }
    return _mapView;
}

- (UITableView *)poiTableView {
    if (!_poiTableView) {
        _poiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREENH - 375 * widthScale - kViewTopHeight - KiPhoneXSafeAreaDValue, SCREENW, 375 * widthScale + KiPhoneXSafeAreaDValue) style:UITableViewStylePlain];
        _poiTableView.backgroundColor = [UIColor whiteColor];
        _poiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _poiTableView.delegate = self;
        _poiTableView.dataSource = self;
    }
    return _poiTableView;
}

- (UIButton *)showButton {
    if (!_showButton) {
        _showButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 30 * widthScale)];
        [_showButton setBackgroundColor:[UIColor whiteColor]];
        [_showButton setImage:[UIImage imageNamed:@"showin"] forState:UIControlStateNormal];
        [_showButton setImage:[UIImage imageNamed:@"showout"] forState:UIControlStateSelected];
        [_showButton addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
        _showButton.imageView.contentMode = UIViewContentModeScaleAspectFit;

    }
    return _showButton;
}

#pragma mark - 临时数据

- (NSArray<BMKPoiInfo *> *)poiList {
    if (!_poiList) {
        _poiList = [[NSArray alloc] init];
        NSMutableArray *dataArray = [NSMutableArray array];
        NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"poiInfo" ofType:@"json"]];
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        for (NSDictionary *dictionary in array) {
            BMKPoiInfo *info = [[BMKPoiInfo alloc] init];
            info.pt = CLLocationCoordinate2DMake([dictionary[@"lat"] doubleValue], [dictionary[@"lng"] doubleValue]);
            info.name = dictionary[@"name"];
            info.address = dictionary[@"address"];
            [dataArray addObject:info];
        }
        _poiList = [dataArray copy];

    }
    return _poiList;
}

@end
