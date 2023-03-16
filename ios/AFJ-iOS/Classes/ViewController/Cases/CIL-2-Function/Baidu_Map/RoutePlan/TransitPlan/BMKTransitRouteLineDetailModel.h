//
//  BMKTransitRouteLineDetailModel.h
//  BMKTransitRoutePlanDemo
//
//  Created by baidu on 2020/5/25.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMKTransitRouteLineDetailModel : NSObject
@property(nonatomic, assign) CGFloat cellHeight;
@property(nonatomic, copy) NSString *instruction;
@property(nonatomic, assign) BMKTransitStepType stepType;
@end

NS_ASSUME_NONNULL_END
