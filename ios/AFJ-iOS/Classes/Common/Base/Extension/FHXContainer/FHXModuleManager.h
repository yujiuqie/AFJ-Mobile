//
//  FHXModuleManager.h
//  FHXContainer
//
//  Created by 冯汉栩 on 2019/1/10.
//  Copyright © 2018 冯汉栩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FHXModuleProtocol.h"

extern NSString *const kModDidFinishLaunchingEvent;
extern NSString *const kModWillResignActiveEvent;
extern NSString *const kModDidBecomeActiveEvent;
extern NSString *const kModWillEnterForegroundEvent;
extern NSString *const kModDidEnterBackgroundEvent;
extern NSString *const kModWillTerminateEvent;
extern NSString *const kModDidReceiveMemoryWarningEvent;
extern NSString *const kModDidRegisterForRemoteNotificationEvent;
extern NSString *const kModDidFailToRegisterForRemoteNotificationEvent;
extern NSString *const kModDidReceiveRemoteNotificationEvent;
extern NSString *const kModDidReceiveNotificationResponseEvent;
extern NSString *const kModDidReceiveLocalNotificationEvent;
extern NSString *const kModCustomEvent;
extern NSString *const kModSystemEvent;
extern NSString *const kModOpenURLEvent;
extern NSString *const kModInstallEvent;
extern NSString *const kModInitEvent;
extern NSString *const kModUninstallEvent;
extern NSString *const kModUserLoginSuccessEvent;
extern NSString *const kModUserLoginFailEvent;
extern NSString *const kModUserLogoutSuccessEvent;
extern NSString *const kModUserLogoutFailEvent;
extern NSString *const kModUserAbnormalSignoutEvent;
extern NSString *const kModUserActiveEvent;
extern NSString *const kModShortcutActionEvent;
extern NSString *const kModDidUpdateUserActivityEvent;
extern NSString *const kModDidFailToContinueUserActivityEvent;
extern NSString *const kModContinueUserActivityEvent;
extern NSString *const kModWillContinueUserActivityEvent;
extern NSString *const kModHandleWatchKitExtensionRequestEvent;

@interface FHXModuleManager : NSObject

+ (instancetype)shareInstance;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

- (void)registerModule:(Class)moduleClass;

- (void)unregisterModuleWithModule:(Class)moduleClass;

- (void)registerCustomEvent:(NSString *)event withModuleInstance:(id <FHXModuleProtocol>)moduleInstance;

- (void)triggerEvent:(NSString *)eventType;

- (void)triggerEvent:(NSString *)eventType customParam:(NSDictionary *)customParam;

@end
