//
//  FHXModuleProtocol.h
//  FHXContainer
//
//  Created by 冯汉栩 on 2019/1/10.
//  Copyright © 2018 冯汉栩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHXContext.h"

#define container_module_register \
+ (void)load { [FHXContainer registerModule:[self class]]; } \
- (BOOL)async { return YES; }

//模块注册宏,isAsync=YES时效果同上面那个宏,模块的init事件会异步执行;isAsync=NO时,模块的init事件会同步执行.
#define container_module_register_async(isAsync) \
+ (void)load { [FHXContainer registerModule:[self class]]; } \
- (BOOL)async { return [[NSString stringWithUTF8String:#isAsync] boolValue]; }

typedef NS_ENUM(NSUInteger, FHXModulePriority) {
    FHXModulePriorityDefault,
    FHXModulePriorityNormal,
    FHXModulePriorityHigh,
    FHXModulePriorityHighest
};

@protocol FHXModuleProtocol <NSObject>

#pragma mark - App生命周期事件
@optional
///App启动
- (void)modDidFinishLaunchingEvent:(FHXContext *)context;

///App被挂起
- (void)modWillResignActiveEvent:(FHXContext *)context;

///App被挂起后复原
- (void)modDidBecomeActiveEvent:(FHXContext *)context;

///App进入后台
- (void)modDidEnterBackgroundEvent:(FHXContext *)context;

///App进入前台
- (void)modWillEnterForegroundEvent:(FHXContext *)context;

///App终止
- (void)modWillTerminateEvent:(FHXContext *)context;

///App收到内存警告
- (void)modDidReceiveMemoryWarningEvent:(FHXContext *)context;

#pragma mark - App推送事件

///注册远程推送失败
- (void)modDidFailToRegisterForRemoteNotificationEvent:(FHXContext *)context;

///注册远程推送获取deviceToken
- (void)modDidRegisterForRemoteNotificationEvent:(FHXContext *)context;

///iOS10以下接收到远程推送消息
- (void)modDidReceiveRemoteNotificationEvent:(FHXContext *)context;

///iOS10以下接收到本地推送消息
- (void)modDidReceiveLocalNotificationEvent:(FHXContext *)context;

///iOS10以上接收到推送
- (void)modDidReceiveNotificationResponseEvent:(FHXContext *)context;

#pragma mark - 快捷事件

- (void)modShortcutActionEvent:(FHXContext *)context;

#pragma mark - Apple Watch

- (void)modHandleWatchKitExtensionRequestEvent:(FHXContext *)context;

#pragma mark - User Activity

- (void)modDidUpdateUserActivityEvent:(FHXContext *)context;

- (void)modDidFailToContinueUserActivityEvent:(FHXContext *)context;

- (void)modContinueUserActivityEvent:(FHXContext *)context;

- (void)modWillContinueUserActivityEvent:(FHXContext *)context;

#pragma mark - 其他系统事件

///模块内自定义处理URL
- (void)modOpenURLEvent:(FHXContext *)context;

- (void)modCustomEvent:(FHXContext *)context;

- (void)modSystemEvent:(FHXContext *)context;

#pragma mark - Module生命周期事件

///优先级,取值范围0-3,值越高优先级越高
- (FHXModulePriority)priority;

///安装模块
- (void)modInstallEvent:(FHXContext *)context;

///初始化模块
- (void)modInitEvent:(FHXContext *)context;

///初始化模块工作异步派发到主队列执行（优先级不高的工作这里可以返回YES）
- (BOOL)async;

///卸载模块
- (void)modUninstallEvent:(FHXContext *)context;

#pragma mark - User生命周期事件

///用户登录成功
- (void)modUserLoginSuccessEvent:(FHXContext *)context;

///用户登录失败
- (void)modUserLoginFailEvent:(FHXContext *)context;

///用户退出成功
- (void)modUserLogoutSuccessEvent:(FHXContext *)context;

///用户退出失败
- (void)modUserLogoutFailEvent:(FHXContext *)context;

///用户异常登出
- (void)modUserAbnormalSignoutEvent:(FHXContext *)context;

///用户活跃状态
- (void)modUserActiveEvent:(FHXContext *)context;

@end
