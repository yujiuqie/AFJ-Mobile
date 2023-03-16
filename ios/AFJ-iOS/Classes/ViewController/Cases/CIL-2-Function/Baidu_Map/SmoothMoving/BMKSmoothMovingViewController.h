//
//  BMKSmoothMovingViewController.h
//  BMKSmoothMovingDemo
//
//  Created by baidu on 2020/5/19.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMKSmoothMovingViewController : UIViewController

@end

/// 运动节点
@interface BMKSportNode : NSObject
/// 经纬度
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
/// 方向
@property(nonatomic, assign) CGFloat direction;
/// 距离
@property(nonatomic, assign) CGFloat distance;
/// 动画时间
@property(nonatomic, assign) CGFloat duration;

@end


