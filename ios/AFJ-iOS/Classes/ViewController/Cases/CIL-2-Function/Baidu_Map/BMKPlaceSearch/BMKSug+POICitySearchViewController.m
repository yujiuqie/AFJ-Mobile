//
//  BMKSug+POICitySearchViewController.m
//  BMKPlaceSearchDemo
//
//  Created by baidu on 2020/7/22.
//  Copyright © 2020 zhangbaojin. All rights reserved.
//

/**
 * 注意：BMKSuggestionSearchResult中tag，address，children字段需要额外申请权限，
 * 首先需要进行企业认证，之后需要提交工单(http://lbsyun.baidu.com/index.php?title=FAQ/tags) 申请这个权限， 并详细说明使用场景， 包括但不限于，
 * 使用开放平台哪些产品及服务， 应用在贵方哪些产品及应用上以及该产品或应用的相关介绍， 预估使用配额多少等。另外需附带AK信息。
 */

#import "BMKSug+POICitySearchViewController.h"
#import "BMKPoiAnnotation.h"
#import "UIImage+BMKImage.h"
#import "BMKSugInfoCell.h"

@interface BMKSug_POICitySearchViewController () <BMKMapViewDelegate, UISearchBarDelegate, BMKSuggestionSearchDelegate, BMKPoiSearchDelegate, UITableViewDataSource, UITableViewDelegate>

/// 当前界面的mapView
@property(nonatomic, strong) BMKMapView *mapView;

/// 地点提示tableView
@property(nonatomic, strong) UITableView *tableView;

/// suglist
@property(nonatomic, copy) NSArray<BMKSuggestionInfo *> *sugInfoList;

@property(nonatomic, copy) NSArray<BMKPoiInfo *> *poiInfoList;

/// 自定义检索View
@property(nonatomic, strong) UIView *searchView;

/// 检索框
@property(nonatomic, strong) UISearchBar *searchBar;

/// 当前界面选择的poi展示label
@property(nonatomic, strong) UILabel *addressLabel;


@end

@implementation BMKSug_POICitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"地点检索";
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addressLabel];
    [self.view addSubview:self.searchView];

    // 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    // 监听键盘退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    // 当mapView即将被显示的时候调用，恢复之前存储的mapView状态
    [_mapView viewWillAppear];
    [self.searchView endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
    // 当mapView即将被隐藏的时候调用，存储当前mapView的状态
    [_mapView viewWillDisappear];
    [self.searchView endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/// 配置addressLabel
- (void)configAddressLabel:(NSString *)name address:(NSString *)address {

    NSMutableAttributedString *poi = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", name, address]];
    NSRange nRange = NSMakeRange(0, [name length]);
    NSRange aRange = NSMakeRange([name length], [address length] + 1);
    [poi addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Semibold" size:24] range:nRange];
    [poi addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:16] range:aRange];
    // 底部label展示poi信息
    _addressLabel.attributedText = poi;
    _addressLabel.hidden = NO;
}

- (void)keyboardDidShow:(NSNotification *)notification {
    self.tableView.hidden = NO;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.addressLabel.hidden = YES;
}

// 根据输入发送sug检索
- (void)searchSugInfoWithKey:(NSString *)key {
    if (key.length == 0) {
        self.sugInfoList = [NSMutableArray array];
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        return;
    }

    BMKSuggestionSearchOption *option = [BMKSuggestionSearchOption new];
    option.keyword = key;
    option.cityname = @"北京";
    option.cityLimit = YES;

    BMKSuggestionSearch *sugSearch = [BMKSuggestionSearch new];
    sugSearch.delegate = self;
    [sugSearch suggestionSearch:option];

}

/// 根据联想词或关键词进行POI检索
- (void)searchPOIInfoWithKey:(NSString *)key {
    if (!key) {
        return;
    }
    BMKPOICitySearchOption *option = [BMKPOICitySearchOption new];
    option.keyword = key;
    option.city = @"北京";
    option.isCityLimit = YES;

    BMKPoiSearch *search = [BMKPoiSearch new];
    search.delegate = self;
    [search poiSearchInCity:option];
}

/// 搜索按钮点击
- (void)searchBtnClicked:(UIButton *)sender {
    [self searchPOIInfoWithKey:_searchBar.text];
}

/// 标注适配屏幕
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
        // 如果是固定在屏幕上的，则不进行计算，会影响展示效果。
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
        // 为了更好的展示效果且不影响地图其他控件的位置在这里+90
        CGFloat scale = 90 * widthScale;
        UIEdgeInsets padding = UIEdgeInsetsMake(self.mapView.mapPadding.top + scale, self.mapView.mapPadding.left + scale, self.mapView.mapPadding.bottom + scale, self.mapView.mapPadding.right + scale);
        [self.mapView fitVisibleMapRect:newRect edgePadding:padding withAnimated:YES];
    }
}

#pragma mark - BMKSuggestionSearchDelegate

/// 返回suggestion搜索结果
/// @param searcher 搜索对象
/// @param result  搜索结果
/// @param error BMKSearchErrorCode
- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        self.sugInfoList = [result.suggestionList copy];
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }
}

#pragma mark - BMKPoiSearchDelegate

/// 返回POI搜索结果
/// @param searcher 搜索对象
/// @param poiResult 搜索结果列表
/// @param errorCode BMKSearchErrorCode
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPOISearchResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    [self.searchView endEditing:YES];
    self.tableView.hidden = YES;
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        if (!poiResult.poiInfoList || poiResult.poiInfoList.count == 0) {
            return;
        }
        // 移除标注
        [_mapView removeAnnotations:_mapView.annotations];

        _poiInfoList = [poiResult.poiInfoList copy];

        NSMutableArray<BMKPoiAnnotation *> *annotions = [NSMutableArray array];
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo *info = poiResult.poiInfoList[i];
            BMKPoiAnnotation *annotaion = [[BMKPoiAnnotation alloc] init];
            annotaion.coordinate = info.pt;
            annotaion.title = info.name;
            annotaion.index = i;
            [annotions addObject:annotaion];
        }

        // 添加标注
        [_mapView addAnnotations:annotions];
        // 标注适配屏幕
        [self showAnnotations:annotions animated:YES];

    }
}

#pragma mark - BMKMapViewDelegate

/// 根据anntation生成对应的annotationView
/// @param mapView 地图View
/// @param annotation 指定的标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isMemberOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"com.Baidu.BMKPointAnnotation"];
        if (!annotationView) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"com.Baidu.BMKPointAnnotation"];
            annotationView.image = [UIImage imageNamed:@"icon_marker"];
        }
        return annotationView;
    } else if ([annotation isMemberOfClass:[BMKPoiAnnotation class]]) {
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"com.Baidu.BMKPoiAnnotation"];
        if (!annotationView) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"com.Baidu.BMKPoiAnnotation"];
        }
        annotationView.pinColor = BMKPinAnnotationColorRed;
        return annotationView;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    for (id view in views) {
        if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
            BMKPinAnnotationView *annotionView = (BMKPinAnnotationView *) view;
            BMKPoiAnnotation *annotion = (BMKPoiAnnotation *) annotionView.annotation;
            if ([annotion respondsToSelector:@selector(index)] && annotion.index == 0) {
                annotionView.selected = YES;
            }
        }
    }
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    BMKPinAnnotationView *selView = (BMKPinAnnotationView *) view;
    selView.pinColor = BMKPinAnnotationColorGreen;
    BMKPoiAnnotation *annotion = (BMKPoiAnnotation *) selView.annotation;
    BMKPoiInfo *info = _poiInfoList[annotion.index];
    NSString *name = info.name ? info.name : @"";
    NSString *address = info.address ? info.address : @"";
    [self configAddressLabel:name address:address];
    [mapView mapForceRefresh];
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view {
    BMKPinAnnotationView *selView = (BMKPinAnnotationView *) view;
    selView.pinColor = BMKPinAnnotationColorRed;
    [mapView mapForceRefresh];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sugInfoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tipCellIdentifier = @"sugInfoList.cell";
    BMKSugInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    if (cell == nil) {
        cell = [[BMKSugInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:tipCellIdentifier];
    }
    BMKSuggestionInfo *info = self.sugInfoList[indexPath.row];
    // 注意tag、address、children 默认不召回，需要申请sug权限才会有返回值。
    [cell configTitle:info.key subTitle:info.address];
    return cell;
}

#pragma mark - UITableViewDelegate

// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.searchView endEditing:YES];
    BMKSuggestionInfo *info = self.sugInfoList[indexPath.row];
    if (info.uid != nil && CLLocationCoordinate2DIsValid(info.location)) {
        BMKPointAnnotation *annotaion = [[BMKPointAnnotation alloc] init];
        annotaion.coordinate = info.location;
        // 添加标注
        [_mapView addAnnotation:annotaion];
        // 设置地图中心点
        [_mapView setCenterCoordinate:info.location];
        NSString *name = info.key ? info.key : @"";
        NSString *address = info.address ? info.address : @"";

        [self configAddressLabel:name address:address];
    } else {
        // 无数据，再POI检索一次
        [self searchPOIInfoWithKey:info.key];
    }
    self.tableView.hidden = YES;
    // 检索框与选中文本保持一致
    _searchBar.text = info.key;

}

#pragma mark - UISearchBarDelegate

// 输入回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    // sug检索
    [self searchSugInfoWithKey:searchText];
}

// 确认检索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // POI检索
    [self searchPOIInfoWithKey:searchBar.text];
}

#pragma mark - UI

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kViewTopHeight)];
        _mapView.delegate = self;
        _mapView.zoomLevel = 16;
        _mapView.trafficEnabled = YES;
    }
    return _mapView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.searchView.frame)) style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (UIView *)searchView {
    if (!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 80)];
        _searchView.backgroundColor = [UIColor colorWithRed:68.f / 255.f green:70.f / 255.f blue:86.f / 255.f alpha:1.f];
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, SCREENW - 10 * 2 - 50, 40)];
        containerView.backgroundColor = [UIColor colorWithRed:41.f / 255.f green:43.f / 255.f blue:59.f / 255.f alpha:1.f];
        containerView.layer.cornerRadius = 5;
        [_searchView addSubview:containerView];
        UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(containerView.frame) + 10, CGRectGetMinY(containerView.frame), 40, 40)];
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [searchBtn setTitleColor:[UIColor colorWithRed:68.f / 255.f green:70.f / 255.f blue:86.f / 255.f alpha:1.f] forState:UIControlStateHighlighted];
        [searchBtn addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_searchView addSubview:searchBtn];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 120, 40)];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithRed:111.f / 255.f green:112.f / 255.f blue:123.f / 255.f alpha:1.f];
        NSMutableAttributedString *tipStr = [[NSMutableAttributedString alloc] initWithString:@"在 北京 市内找 "];
        NSRange tipRangre = NSMakeRange(2, 2);
        [tipStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:tipRangre];
        [tipStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:tipRangre];
        label.attributedText = tipStr;
        [containerView addSubview:label];
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMinY(label.frame), CGRectGetWidth(containerView.frame) - CGRectGetWidth(label.frame) - 20, 40)];
        searchBar.delegate = self;
        searchBar.searchBarStyle = UISearchBarStyleMinimal;
        searchBar.returnKeyType = UIReturnKeySearch;
        // 取消搜索图片
        [searchBar setImage:[UIImage bmk_getImageWithColor:[UIColor clearColor] height:40] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        searchBar.backgroundImage = [UIImage bmk_getImageWithColor:[UIColor clearColor] height:40];
        [searchBar setSearchFieldBackgroundImage:[UIImage bmk_getImageWithColor:[UIColor clearColor] height:40] forState:UIControlStateNormal];
        [searchBar setTintColor:[UIColor whiteColor]];
        [searchBar setBarTintColor:[UIColor whiteColor]];
        searchBar.placeholder = @"请输入关键字";
        // 文本颜色
        if (@available(iOS 9.0, *)) {
            [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = [UIColor whiteColor];
        } else {
            [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
        }

        [containerView addSubview:searchBar];
        _searchBar = searchBar;
    }
    return _searchView;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_mapView.frame) - 80 - 15 - 25, SCREENW - 10 * 2, 80)];
        _addressLabel.textAlignment = NSTextAlignmentCenter;
        _addressLabel.numberOfLines = 0;
        _addressLabel.backgroundColor = [UIColor whiteColor];
        _addressLabel.textColor = [UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f];
        _addressLabel.layer.cornerRadius = 5;
        _addressLabel.layer.masksToBounds = YES;
        _addressLabel.hidden = YES;
    }
    return _addressLabel;
}
@end
