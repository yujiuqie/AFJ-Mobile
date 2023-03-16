//
//  BMKTransitRouteTableViewCell.h
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKTransitRouteLineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMKTransitRouteTableViewCell : UITableViewCell

@property(nonatomic, strong) BMKTransitRouteLineModel *model;
@end

NS_ASSUME_NONNULL_END
