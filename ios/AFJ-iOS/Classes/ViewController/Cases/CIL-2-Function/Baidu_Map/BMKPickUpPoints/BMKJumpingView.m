//
//  BMKJumpingView.m
//  BMKPickUpPointsDemo
//
//  Created by Baidu on 2020/5/18.
//  Copyright © 2020 Baidu. All rights reserved.
//

#define kWidth 20
#define kHeight  45

#import "BMKJumpingView.h"

@interface BMKJumpingView () {
    /// 标记headView初始frame
    CGRect kHeadFrame;
    /// 标记innerView初始frame
    CGRect kInnerFrame;
    /// 标记footView初始frame
    CGRect kFootFrame;
    /// 视图缩放系数
    CGFloat _zoomFactor;
}
/// 头部view
@property(nonatomic, strong) UIView *headView;

/// 内部view
@property(nonatomic, strong) UIView *headInnerView;

/// 尾部view
@property(nonatomic, strong) UIView *footView;

/// circle动画layer
@property(nonatomic, strong) CAShapeLayer *circleLayer;

/// 缩小贝塞尔曲线
@property(nonatomic, strong) UIBezierPath *zoomInBezierPath;

/// 放大贝塞尔曲线
@property(nonatomic, strong) UIBezierPath *zoomOutBezierPath;

/// 是否正在动画
@property(nonatomic, assign) BOOL isAnimating;

@end

@implementation BMKJumpingView

- (UIBezierPath *)zoomInBezierPath {
    if (!_zoomInBezierPath) {
        CGPoint center = CGPointMake(kWidth * 0.5, CGRectGetMaxY(_footView.frame) + 1.5);
        _zoomInBezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:0.1 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    }
    return _zoomInBezierPath;
}

- (UIBezierPath *)zoomOutBezierPath {
    if (!_zoomOutBezierPath) {
        CGFloat width = kWidth * 1.2;
        CGPoint center = CGPointMake(kWidth * 0.5, CGRectGetMaxY(_footView.frame) + 1.5);
        _zoomOutBezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:width startAngle:0 endAngle:2 * M_PI clockwise:YES];
    }
    return _zoomOutBezierPath;
}

- (id)initWithAnnotation:(id <BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, kWidth, kHeight);
        kHeadFrame = CGRectMake(0, 0, kWidth, kWidth);
        _headView = [[UIView alloc] initWithFrame:kHeadFrame];
        _headView.backgroundColor = [UIColor colorWithRed:0.26 green:0.29 blue:0.38 alpha:1.f];
//        _headView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1.f];
        _headView.layer.cornerRadius = CGRectGetWidth(_headView.frame) * 0.5;
        [self addSubview:_headView];

        kFootFrame = CGRectMake(CGRectGetMidX(_headView.frame) - 1, CGRectGetHeight(_headView.frame), 2, kHeight - kWidth);
        _footView = [[UIView alloc] initWithFrame:kFootFrame];
        _footView.backgroundColor = [UIColor colorWithRed:0.43 green:0.45 blue:0.51 alpha:1];
//        _footView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        [self addSubview:_footView];

        kInnerFrame = CGRectMake(kWidth * 0.25, kWidth * 0.25, kWidth * 0.5, kWidth * 0.5);
        _headInnerView = [[UIView alloc] initWithFrame:kInnerFrame];
        _headInnerView.backgroundColor = [UIColor colorWithRed:0.31 green:0.45 blue:0.51 alpha:1.f];
//        _headInnerView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1.f];
        _headInnerView.layer.cornerRadius = CGRectGetWidth(_headInnerView.frame) * 0.5;
        [self addSubview:_headInnerView];

        _circleLayer = [CAShapeLayer new];
        _circleLayer.frame = self.bounds;
        _circleLayer.fillColor = [UIColor colorWithRed:0.26 green:0.29 blue:0.38 alpha:1.f].CGColor;
        [self.layer addSublayer:_circleLayer];

        _isAnimating = NO;
        _zoomFactor = 0.8;
    }
    return self;
}

/// 底部圆圈动画
- (void)circleAnimate {
    CGFloat duration = 0.75;
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable) (self.zoomInBezierPath.CGPath);
    animation1.toValue = (__bridge id _Nullable) (self.zoomOutBezierPath.CGPath);
    animation1.duration = duration;
    animation1.fillMode = kCAFillModeForwards;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation1.removedOnCompletion = YES;

    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.fromValue = @(1);
    animation2.toValue = @(0.01);
    animation2.duration = duration;
    animation2.fillMode = kCAFillModeForwards;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation2.removedOnCompletion = YES;
    [_circleLayer addAnimation:animation1 forKey:@"circleAnimate.path"];
    [_circleLayer addAnimation:animation2 forKey:@"circleAnimate.opacity"];
}

/// 大头针回复初始状态
- (void)restore {
    [_headView.layer removeAllAnimations];
    [_headInnerView.layer removeAllAnimations];
    [_footView.layer removeAllAnimations];
    _headView.frame = kHeadFrame;
    _headView.frame = kInnerFrame;
    _footView.frame = kFootFrame;
}

- (void)jump {
    if (_isAnimating) {
        [self restore];
    }
    _isAnimating = YES;

    CGFloat zoomHeight1 = CGRectGetHeight(kFootFrame) * _zoomFactor;
    CGFloat zoomHeight2 = CGRectGetHeight(kFootFrame) * (1 - _zoomFactor);

    CGRect hFrame1 = CGRectMake(CGRectGetMinX(kHeadFrame), CGRectGetMinY(kHeadFrame) - zoomHeight1, CGRectGetWidth(kHeadFrame), CGRectGetHeight(kHeadFrame));
    CGRect iFrame1 = CGRectMake(CGRectGetMinX(kInnerFrame), CGRectGetMinY(kInnerFrame) - zoomHeight1, CGRectGetWidth(kInnerFrame), CGRectGetHeight(kInnerFrame));
    CGRect fFrame1 = CGRectMake(CGRectGetMinX(kFootFrame), CGRectGetMinY(kFootFrame) - zoomHeight1, CGRectGetWidth(kFootFrame), CGRectGetHeight(kFootFrame) + zoomHeight1);

    CGRect hFrame2 = CGRectMake(CGRectGetMinX(kHeadFrame), CGRectGetMinY(kHeadFrame) - zoomHeight2, CGRectGetWidth(kHeadFrame), CGRectGetHeight(kHeadFrame));
    CGRect iFrame2 = CGRectMake(CGRectGetMinX(kInnerFrame), CGRectGetMinY(kInnerFrame) - zoomHeight2, CGRectGetWidth(kInnerFrame), CGRectGetHeight(kInnerFrame));
    CGRect fFrame2 = CGRectMake(CGRectGetMinX(kFootFrame), CGRectGetMinY(kFootFrame) - zoomHeight2, CGRectGetWidth(kFootFrame), zoomHeight2);


    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self->_headView.frame = hFrame1;
        self->_headInnerView.frame = iFrame1;
        self->_footView.frame = fFrame1;
    }                completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self->_headView.frame = hFrame2;
                self->_headInnerView.frame = iFrame2;
                self->_footView.frame = fFrame2;
            }                completion:^(BOOL finished) {
                if (finished) {
                    self->_isAnimating = false;
                }
            }];
        }
    }];
}

- (void)fall {
    if (_isAnimating) {
        [self restore];
    }
    _isAnimating = YES;

    CGFloat zoomHeight1 = CGRectGetHeight(kFootFrame) * _zoomFactor;
    CGFloat zoomHeight2 = CGRectGetHeight(kFootFrame) * (1 - _zoomFactor);


    CGRect hFrame3 = CGRectMake(CGRectGetMinX(kHeadFrame), CGRectGetMinY(kHeadFrame) + zoomHeight1, CGRectGetWidth(kHeadFrame), CGRectGetHeight(kHeadFrame));
    CGRect iFrame3 = CGRectMake(CGRectGetMinX(kInnerFrame), CGRectGetMinY(kInnerFrame) + zoomHeight1, CGRectGetWidth(kInnerFrame), CGRectGetHeight(kInnerFrame));
    CGRect fFrame3 = CGRectMake(CGRectGetMinX(kFootFrame), CGRectGetMinY(kFootFrame) + zoomHeight1, CGRectGetWidth(kFootFrame), zoomHeight2);

    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self->_headView.frame = hFrame3;
        self->_headInnerView.frame = iFrame3;
        self->_footView.frame = fFrame3;
    }                completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self->_headView.frame = self->kHeadFrame;
                self->_headInnerView.frame = self->kInnerFrame;
                self->_footView.frame = self->kFootFrame;
            }                completion:^(BOOL finished) {
                if (finished) {
                    self->_isAnimating = false;
                    [self circleAnimate];
                }
            }];
        }
    }];

}
@end
