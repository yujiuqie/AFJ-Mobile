//
//  BMKRouteDetailViewController.h
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/21.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKWalkRouteDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMKWalkRouteDetailViewController : UIViewController
/// 路线详情数据
@property(nonatomic, strong) BMKWalkingRouteLine *routeLine;
@property(nonatomic, strong) NSArray <BMKWalkRouteDetailModel *> *detailModels;
@end

NS_ASSUME_NONNULL_END
