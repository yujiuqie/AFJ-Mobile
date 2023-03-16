//
//  NetworkMonitor.h
//  SDBank_iOS
//
//  Created by sdebank on 2021/8/20.
//  Copyright © 2021 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkMonitor : NSObject

// AFN监听网络方法(二次封装)  wifi  蜂窝  无网络  飞行模式  未知网络
+ (void)networkMonitorStatus;

@end

NS_ASSUME_NONNULL_END
