//
//  BMKPinAnnotationScaleView.m
//  BMKAnnotationViewScaleDemo
//
//  Created by baidu on 2020/5/18.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKPinAnnotationScaleView.h"

@implementation BMKPinAnnotationScaleView

//添加动画
- (void)addAnimation {
    //缩放动画，按之前设置的锚点进行缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 1;
    scaleAnimation.repeatCount = HUGE_VALF;
    scaleAnimation.autoreverses = YES;
    //保证app切换到后台动画再切回来时动画依然执行
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fromValue = @(1.0);
    scaleAnimation.toValue = @(1.3);
    [self.layer addAnimation:scaleAnimation forKey:@"scale-layer"];
}

//移除动画
- (void)removeAnimation {
    [self.layer removeAllAnimations];
}

//暂停动画
- (void)pauseAnimation {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

//恢复动画
- (void)resumeAnimation {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

@end
