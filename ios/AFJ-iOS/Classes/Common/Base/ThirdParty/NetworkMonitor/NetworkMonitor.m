//
//  NetworkMonitor.m
//  SDBank_iOS
//
//  Created by sdebank on 2021/8/20.
//  Copyright © 2021 Alibaba. All rights reserved.
//

#import "NetworkMonitor.h"

@implementation NetworkMonitor

+ (void)networkMonitorStatus {
    //1:创建网络监听者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    //2:获取网络状态
    //开启网络监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                //未知网络
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetworkMonitorStatus" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"未知网络", @"state", nil]];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                //蜂窝数据
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetworkMonitorStatus" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"蜂窝数据", @"state", nil]];
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                //没有网络
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetworkMonitorStatus" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"没有网络", @"state", nil]];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                //无线网络
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetworkMonitorStatus" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"无线网络", @"state", nil]];
                break;
            }
            default: {
                //飞行模式
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetworkMonitorStatus" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"飞行模式", @"state", nil]];
                break;
            }
        }
    }];
}

@end
