//
//  BMKPinAnnotationScaleView.h
//  BMKAnnotationViewScaleDemo
//
//  Created by baidu on 2020/5/18.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMKPinAnnotationScaleView : BMKPinAnnotationView
//添加动画
- (void)addAnimation;

//移除动画
- (void)removeAnimation;

//暂停动画
- (void)pauseAnimation;

//恢复动画
- (void)resumeAnimation;
@end

NS_ASSUME_NONNULL_END
