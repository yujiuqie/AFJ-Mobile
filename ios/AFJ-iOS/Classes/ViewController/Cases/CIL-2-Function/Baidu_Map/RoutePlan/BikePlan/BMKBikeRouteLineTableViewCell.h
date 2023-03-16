//
//  BMKRouteLineTableViewCell.h
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/22.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKBikeRouteDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMKBikeRouteLineTableViewCell : UITableViewCell
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UILabel *rightLabel;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) BMKBikeRouteDetailModel *detailModel;
@end

NS_ASSUME_NONNULL_END
