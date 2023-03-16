//
//  BMKRouteDetailViewController.h
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/21.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKTransitRouteLineModel.h"
#import "BMKTransitRouteLineDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMKTransitRouteDetailViewController : UIViewController
/// 路线详情数据
@property(nonatomic, strong) BMKTransitRouteLine *routeLine;
@property(nonatomic, strong) NSArray <BMKTransitRouteLineDetailModel *> *detailModels;
//@property (nonatomic, strong)BMKTransitRouteLineModel *model;
@end

NS_ASSUME_NONNULL_END
