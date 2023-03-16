//
//  FHXContext.h
//  FHXContainer
//
//  Created by 冯汉栩 on 2018/11/28.
//  Copyright © 2018 冯汉栩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000

#import <UserNotifications/UserNotifications.h>

#endif
@class FHXOpenUrlItem;
@class FHXNotificationItem;
@class FHXShortcutItem;
@class FHXUserActivityItem;
@class FHXWatchItem;

typedef NS_ENUM(NSUInteger, EnvironmentType) {
    EnvironmentTypeDev,       //开发
    EnvironmentTypeTest,      //测试
    EnvironmentTypeSandbox,   //沙箱
    EnvironmentTypeProd       //线上
};

@interface FHXContext : NSObject

///环境
@property(nonatomic, assign) EnvironmentType env;
///应用启动时的application
@property(nonatomic, strong) UIApplication *application;
///应用启动时的launchOptions
@property(nonatomic, strong) NSDictionary *launchOptions;
///自定义事件名称
@property(nonatomic, assign) NSString *customEvent;
///跟随事件传递的参数
@property(nonatomic, assign) NSDictionary *customParam;
///openURL事件的参数
@property(nonatomic, strong) FHXOpenUrlItem *openUrlItem;
///通知事件的参数
@property(nonatomic, strong) FHXNotificationItem *notificationItem;
///3D-Touch参数
@property(nonatomic, strong) FHXShortcutItem *shortcutItem;
///用户活动参数
@property(nonatomic, strong) FHXUserActivityItem *userActivityItem;
///手表参数
@property(nonatomic, strong) FHXWatchItem *watchItem;

#pragma mark - 访问入口

+ (instancetype)shareInstance;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - 添加模块的服务

/**
 添加模块服务

 @param instance 模块对应的控制器
 @param serviceName 唯一标识符，建议使用模块名称
 */
- (void)addModuleServiceInstance:(id)instance serviceName:(NSString *)serviceName;

- (id)getModuleServiceInstanceWithServiceName:(NSString *)serviceName;

- (void)removeModuleServiceInstanceWithServiceName:(NSString *)serviceName;

@end


#pragma mark - FHXOpenUrlItem

@interface FHXOpenUrlItem : NSObject
@property(nonatomic, strong) NSURL *openURL;
@property(nonatomic, copy) NSDictionary *options;
@end

#pragma mark - FHXNotificationItem
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000

typedef void(^FHXNotificationCompletionHandler)(void);

#endif

@interface FHXNotificationItem : NSObject
@property(nonatomic, strong) NSData *deviceToken;
@property(nonatomic, strong) NSError *reigsterError;
@property(nonatomic, strong) UILocalNotification *localNotification;
@property(nonatomic, strong) NSDictionary *userInfo;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
@property(nonatomic, strong) UNUserNotificationCenter *center;
@property(nonatomic, strong) UNNotificationResponse *notificationResponse;
@property(nonatomic, copy) FHXNotificationCompletionHandler notificationCompletionHandler;
#endif
@end

#pragma mark - Shortcut Item

typedef void (^FHXShortcutCompletionHandler)(BOOL);

@interface FHXShortcutItem : NSObject

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
@property(nonatomic, strong) UIApplicationShortcutItem *shortcutItem;
@property(nonatomic, copy) FHXShortcutCompletionHandler scompletionHandler;
#endif

@end

#pragma mark - User Activity

typedef void (^FHXUserActivityRestorationHandler)(NSArray *);

@interface FHXUserActivityItem : NSObject

@property(nonatomic, copy) NSString *userActivityType;
@property(nonatomic, strong) NSUserActivity *userActivity;
@property(nonatomic, strong) NSError *userActivityError;
@property(nonatomic, copy) FHXUserActivityRestorationHandler restorationHandler;

@end

#pragma mark - Watch Item

typedef void (^FHXWatchReplyHandler)(NSDictionary *replyInfo);

@interface FHXWatchItem : NSObject

@property(nonatomic, strong) NSDictionary *userInfo;
@property(nonatomic, copy) FHXWatchReplyHandler replyHandler;

@end
