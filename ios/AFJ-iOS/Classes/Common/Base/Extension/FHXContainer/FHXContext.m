//
//  FHXContext.m
//  FHXContainer
//
//  Created by 冯汉栩 on 2019/1/10.
//  Copyright © 2018 冯汉栩. All rights reserved.
//

@interface FHXContext ()
@property(nonatomic, strong) NSMutableDictionary *servicesByModule;
@end

@implementation FHXContext

+ (instancetype)shareInstance {
    static FHXContext *context;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        context = [[self alloc] init];
    });

    return context;
}

- (instancetype)init {
    if (self = [super init]) {
        self.openUrlItem = [[FHXOpenUrlItem alloc] init];
        self.notificationItem = [[FHXNotificationItem alloc] init];
        self.shortcutItem = [[FHXShortcutItem alloc] init];
        self.userActivityItem = [[FHXUserActivityItem alloc] init];
        self.watchItem = [[FHXWatchItem alloc] init];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    FHXContext *context = [[self.class allocWithZone:zone] init];
    context.env = self.env;
    context.application = self.application;
    context.launchOptions = self.launchOptions;
    context.customEvent = self.customEvent;
    context.customParam = self.customParam;
    context.openUrlItem = self.openUrlItem;
    context.notificationItem = self.notificationItem;
    context.shortcutItem = self.shortcutItem;
    context.userActivityItem = self.userActivityItem;
    context.watchItem = self.watchItem;
    return context;
}

- (void)addModuleServiceInstance:(id)instance serviceName:(NSString *)serviceName {
    [[FHXContext shareInstance].servicesByModule setObject:instance forKey:serviceName];
}

- (id)getModuleServiceInstanceWithServiceName:(NSString *)serviceName {
    return [[FHXContext shareInstance].servicesByModule objectForKey:serviceName];
}

- (void)removeModuleServiceInstanceWithServiceName:(NSString *)serviceName {
    [[FHXContext shareInstance].servicesByModule removeObjectForKey:serviceName];
}

#pragma mark - property getter

- (NSMutableDictionary *)servicesByModule {
    if (!_servicesByModule) {
        _servicesByModule = [NSMutableDictionary dictionary];
    }
    return _servicesByModule;
}
@end


#pragma mark - FHXOpenUrlItem

@implementation FHXOpenUrlItem

@end


#pragma mark - FHXNotificationItem

@implementation FHXNotificationItem

@end

#pragma mark - FHXShortcutItem

@implementation FHXShortcutItem

@end

#pragma mark - FHXUserActivityItem

@implementation FHXUserActivityItem

@end

#pragma mark - FHXWatchItem

@implementation FHXWatchItem

@end
