//
//  FHXAppDelegate.m
//  FHXContainer
//
//  Created by 冯汉栩 on 2018/11/28.
//  Copyright © 2018 冯汉栩. All rights reserved.
//

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000

#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000

@interface FHXAppDelegate () <UNUserNotificationCenterDelegate>
#else
@interface FHXAppDelegate ()
#endif

@end


@implementation FHXAppDelegate

@synthesize window;

#pragma mark - Life Cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FHXModuleManager shareInstance] triggerEvent:kModInstallEvent];
    [[FHXModuleManager shareInstance] triggerEvent:kModInitEvent];

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
#endif

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[FHXModuleManager shareInstance] triggerEvent:kModWillResignActiveEvent];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[FHXModuleManager shareInstance] triggerEvent:kModDidBecomeActiveEvent];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[FHXModuleManager shareInstance] triggerEvent:kModWillEnterForegroundEvent];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[FHXModuleManager shareInstance] triggerEvent:kModDidEnterBackgroundEvent];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[FHXModuleManager shareInstance] triggerEvent:kModWillTerminateEvent];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[FHXModuleManager shareInstance] triggerEvent:kModDidReceiveMemoryWarningEvent];
}

#pragma mark - Push Notification

//注册推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[FHXContainer shareInstance].context.notificationItem setReigsterError:error];
    [[FHXModuleManager shareInstance] triggerEvent:kModDidFailToRegisterForRemoteNotificationEvent];
}

//注册推送获取deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[FHXContainer shareInstance].context.notificationItem setDeviceToken:deviceToken];
    [[FHXModuleManager shareInstance] triggerEvent:kModDidRegisterForRemoteNotificationEvent];
}

//iOS10以下远程推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[FHXContainer shareInstance].context.notificationItem setUserInfo:userInfo];
    [[FHXModuleManager shareInstance] triggerEvent:kModDidReceiveRemoteNotificationEvent];
}

//iOS10以下本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[FHXContainer shareInstance].context.notificationItem setLocalNotification:notification];
    [[FHXModuleManager shareInstance] triggerEvent:kModDidReceiveLocalNotificationEvent];
}

//iOS10以上推送
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    [[FHXContainer shareInstance].context.notificationItem setCenter:center];
    [[FHXContainer shareInstance].context.notificationItem setNotificationResponse:response];
    [[FHXContainer shareInstance].context.notificationItem setNotificationCompletionHandler:completionHandler];
    [[FHXModuleManager shareInstance] triggerEvent:kModDidReceiveNotificationResponseEvent];
}

#pragma mark - Open URL

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[FHXContainer shareInstance].context.openUrlItem setOpenURL:url];
    [[FHXModuleManager shareInstance] triggerEvent:kModOpenURLEvent];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    [[FHXContainer shareInstance].context.openUrlItem setOpenURL:url];
    [[FHXContainer shareInstance].context.openUrlItem setOptions:options];
    [[FHXModuleManager shareInstance] triggerEvent:kModOpenURLEvent];
    return YES;
}

#pragma mark - Shortcut Action
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80400

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    [[FHXContainer shareInstance].context.shortcutItem setShortcutItem:shortcutItem];
    [[FHXContainer shareInstance].context.shortcutItem setScompletionHandler:completionHandler];
    [[FHXModuleManager shareInstance] triggerEvent:kModShortcutActionEvent];
}

#endif

#pragma mark - User Activity
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        [[FHXContainer shareInstance].context.userActivityItem setUserActivity:userActivity];
        [[FHXModuleManager shareInstance] triggerEvent:kModDidUpdateUserActivityEvent];
    }
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        [[FHXContainer shareInstance].context.userActivityItem setUserActivityType:userActivityType];
        [[FHXContainer shareInstance].context.userActivityItem setUserActivityError:error];
        [[FHXModuleManager shareInstance] triggerEvent:kModDidFailToContinueUserActivityEvent];
    }
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *_Nullable))restorationHandler {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        [[FHXContainer shareInstance].context.userActivityItem setUserActivity:userActivity];
        [[FHXContainer shareInstance].context.userActivityItem setRestorationHandler:restorationHandler];
        [[FHXModuleManager shareInstance] triggerEvent:kModContinueUserActivityEvent];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        [[FHXContainer shareInstance].context.userActivityItem setUserActivityType:userActivityType];
        [[FHXModuleManager shareInstance] triggerEvent:kModWillContinueUserActivityEvent];
    }
    return YES;
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void (^)(NSDictionary *__nullable replyInfo))reply {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        [[FHXContainer shareInstance].context.watchItem setUserInfo:userInfo];
        [[FHXContainer shareInstance].context.watchItem setReplyHandler:reply];
        [[FHXModuleManager shareInstance] triggerEvent:kModHandleWatchKitExtensionRequestEvent];
    }
}

#endif

@end
