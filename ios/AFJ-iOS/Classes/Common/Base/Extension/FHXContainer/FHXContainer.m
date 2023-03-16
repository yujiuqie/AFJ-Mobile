//
//  FHXContainer.m
//  FHXContainer
//
//  Created by 冯汉栩 on 2019/1/10.
//  Copyright © 2018 冯汉栩. All rights reserved.
//

@implementation FHXContainer

+ (instancetype)shareInstance {
    static FHXContainer *container;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        container = [[self alloc] init];
    });

    return container;
}

+ (void)registerModule:(Class)moduleClass {
    [[FHXModuleManager shareInstance] registerModule:moduleClass];
}

+ (void)triggerEvent:(NSString *)eventType {
    [[FHXModuleManager shareInstance] triggerEvent:eventType];
}

+ (void)triggerEvent:(NSString *)eventType customParam:(NSDictionary *)param {
    [[FHXModuleManager shareInstance] triggerEvent:eventType customParam:param];
}

+ (void)addModuleServiceInstance:(id)instance serviceName:(NSString *)serviceName {
    [[FHXContext shareInstance] addModuleServiceInstance:instance serviceName:serviceName];
}

+ (id)getModuleServiceInstanceWithServiceName:(NSString *)serviceName {
    return [[FHXContext shareInstance] getModuleServiceInstanceWithServiceName:serviceName];
}

+ (void)removeModuleServiceInstanceWithServiceName:(NSString *)serviceName {
    [[FHXContext shareInstance] removeModuleServiceInstanceWithServiceName:serviceName];
}

@end
