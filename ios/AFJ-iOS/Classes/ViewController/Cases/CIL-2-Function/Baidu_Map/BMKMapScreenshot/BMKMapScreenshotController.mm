//
//  BMKMapScreenshotController.m
//  BMKMapScreenshot
//
//  Created by baidu on 2020/7/20.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKMapScreenshotController.h"
#import "BMKShotView.h"

@interface BMKMapScreenshotController () <BMKMapViewDelegate>

/// 当前界面的mapView
@property(nonatomic, strong) BMKMapView *mapView;

/// 截图btn
@property(nonatomic, strong) UIButton *shotBtn;

/// 保存btn
//@property (nonatomic, strong) UIButton *saveBtn;

/// 原生View
@property(nonatomic, strong) BMKShotView *shotView;

/// 截图View
@property(nonatomic, strong) UIImageView *imageView;

/// 截图
@property(nonatomic, strong) UIImage *resultImage;

@end

@implementation BMKMapScreenshotController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"地图截图";
    // 将mapView添加到当前视图中
    [self.view addSubview:self.mapView];

    [self.view addSubview:self.shotBtn];

    [self.view addSubview:self.shotView];

    [self fetchSportNodes];
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

#pragma mark - Private

- (void)fetchSportNodes {
//    _sportNodes = [NSMutableArray array];
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sport_path_shot" ofType:@"json"]];
    NSError *error;
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    NSUInteger count = dataArray.count;
    // +polylineWithPoints: count:指定的直角坐标点数组
    BMKMapPoint *points = new BMKMapPoint[count];
    for (size_t i = 0; i < count; i++) {
        NSDictionary *data = dataArray[i];
        points[i].x = [data[@"x"] floatValue];
        points[i].y = [data[@"y"] floatValue];
    }
    // 根据指定直角坐标点生成一段折线
    BMKPolyline *polyline = [BMKPolyline polylineWithPoints:points count:count];

    [_mapView addOverlay:polyline];
    // 根据polyline设置地图范围
    [self mapViewFitPolyline:polyline];

}

// 根据polyline设置地图范围
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
    UIEdgeInsets padding = UIEdgeInsetsMake(170 * widthScale, 20 * widthScale, 170 * widthScale, 20 * widthScale);
    [_mapView fitVisibleMapRect:rect edgePadding:padding withAnimated:YES];
}

/// 截图btn点击
- (void)shotBtnClicked:(UIButton *)sender {
    // 获取合成截图
    _resultImage = [self syntheticScreenshots];
    // 截图imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_resultImage];
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth = 5.f;
    imageView.layer.cornerRadius = 3.f;
    [self.view addSubview:imageView];
    _imageView = imageView;
    // 蒙版view
    UIView *maskView = [UIView new];
    maskView.backgroundColor = [UIColor whiteColor];
    UIView *rootView = [[UIApplication sharedApplication] keyWindow].rootViewController.view;
    maskView.frame = rootView.bounds;
    imageView.frame = rootView.bounds;
    [rootView addSubview:maskView];
    // 动画展示
    [UIView animateWithDuration:0.5f delay:0.05f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn animations:^{
        maskView.backgroundColor = [UIColor clearColor];
        maskView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) * 0.25, CGRectGetHeight(self.view.bounds) * 0.25);
        imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) * 0.25, CGRectGetHeight(self.view.bounds) * 0.25);
        maskView.center = self.mapView.center;
        imageView.center = self.mapView.center;
    }                completion:^(BOOL finished) {
        [maskView removeFromSuperview];

        [self saveBtnClicked:nil];
    }];

}

/// 保存按钮点击
- (void)saveBtnClicked:(UIButton *)sender {
    if (!_resultImage || !_imageView || ![self.view.subviews containsObject:_imageView]) {
        return;
    }
    [UIView animateWithDuration:0.25f delay:0.05f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut animations:^{
        self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) * 0.1, CGRectGetHeight(self.view.bounds) * 0.1);
        self.imageView.center = self.mapView.center;
    }                completion:^(BOOL finished) {
        [self.imageView removeFromSuperview];
        // 截图保存至相册
        [self saveImageToPhotosAlbum:self.resultImage];
    }];

}

/// 原生View截图与地图截图合成的截图
- (UIImage *)syntheticScreenshots {
    // 地图截图
    UIImage *mapImage = [self.mapView takeSnapshot];
    // 原生View截图
    UIImage *snapshotImage = [self.shotView snapshot];
    // 合成截图
    UIGraphicsBeginImageContextWithOptions(self.mapView.bounds.size, NO, [UIScreen mainScreen].scale);
    [mapImage drawInRect:self.mapView.bounds];
    [snapshotImage drawInRect:self.shotView.frame];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

/// 保存图片至相册
- (void)saveImageToPhotosAlbum:(UIImage *)image {
    // 保存完后调用的方法
    SEL selector = @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:);
    // 保存
    UIImageWriteToSavedPhotosAlbum(image, self, selector, NULL);
}

/// 图片保存完后调用的方法
- (void)onCompleteCapture:(UIImage *)screenImage didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    if (error) {
        // 保存失败
        [self alertMessage:@"保存相册失败"];
    } else {
        // 保存成功
        [self alertMessage:@"保存相册成功"];
    }
}

/// 提示框
- (void)alertMessage:(NSString *)message {
    NSAssert(message && message.length > 0, @"提示信息不能为空");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - BMKMapViewDelegate

/// 根据overlay生成对应的BMKOverlayView
/// @param mapView  地图View
/// @param overlay 指定的overlay
/// @return 生成的覆盖物View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        // 初始化一个overlay并返回相应的BMKPolylineView的实例
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithPolyline:overlay];
        // 设置polylineView的画笔宽度为6
        polylineView.lineWidth = 6.f;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        // lineCapType,默认是kBMKLineCapButt (不支持虚线)
        polylineView.lineCapType = kBMKLineCapRound;
        return polylineView;
    }
    return nil;
}

#pragma mark - UI

- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kViewTopHeight)];
        _mapView.delegate = self;
        _mapView.zoomLevel = 13;
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.955, 116.494)];
    }
    return _mapView;
}

- (UIButton *)shotBtn {
    if (!_shotBtn) {
        _shotBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 70, 40)];
        [_shotBtn setTitle:@"截图" forState:UIControlStateNormal];
        _shotBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_shotBtn setBackgroundColor:[COLOR(0x22253D) colorWithAlphaComponent:0.9f]];
        [_shotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_shotBtn setTitleColor:COLOR(0x22253D) forState:UIControlStateHighlighted];
        [_shotBtn addTarget:self action:@selector(shotBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _shotBtn.layer.cornerRadius = 4.f;
    }
    return _shotBtn;
}

- (BMKShotView *)shotView {
    if (!_shotView) {
        _shotView = [[BMKShotView alloc] initWithFrame:CGRectMake(19 * widthScale, 0, SCREENW - 19 * 2 * widthScale, 143.5 * widthScale)];
        _shotView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) - 143.5 * widthScale - 50);
    }
    return _shotView;
}

@end
