//
//  BMKRouteDetailViewController.h
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/21.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKBikeRouteDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMKBikeRouteDetailViewController : UIViewController
/// 路线数据
@property(nonatomic, strong) BMKRidingRouteLine *routeLine;
@property(nonatomic, strong) NSArray <BMKBikeRouteDetailModel *> *detailModels;
@end

NS_ASSUME_NONNULL_END
