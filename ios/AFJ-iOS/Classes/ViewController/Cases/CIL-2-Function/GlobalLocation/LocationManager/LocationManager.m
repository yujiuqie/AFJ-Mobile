//
//  LocationManager.m
//  Frame
//
//  Created by sdebank on 2021/8/27.
//

#import "LocationManager.h"

@implementation LocationManager

static LocationManager *manager = nil;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
        //已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）的功能来帮助出处理底层内存分配的杂物
    });
    return manager;
}

///用alloc返回也是唯一实例
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

///对对象使用copy也是返回唯一实例
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return manager;
}

///对对象使用mutablecopy也是返回唯一实例
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return manager;
}

#pragma mark 判断是否打开定位

+ (BOOL)determineWhetherTheAPPOpensTheLocation {
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
        return YES;
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else {
        return NO;
    }
}

@end
