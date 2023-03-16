//
//  BMKTransitRouteLineModel.h
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMKTransitRouteLineModel : NSObject
@property(nonatomic, assign) CGFloat cellHeight;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *distance;
@property(nonatomic, copy) NSString *detail;
@property(nonatomic, assign) NSInteger detailRow;
@property(nonatomic, strong) NSArray<UIView *> *tips;

- (instancetype)initWith:(BMKTransitRouteLine *)routeLine;

@end

NS_ASSUME_NONNULL_END
