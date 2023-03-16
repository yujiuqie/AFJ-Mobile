//
//  Single.h
//  (OC)AFNetworking
//
//  Created by 冯汉栩 on 2019/3/19.
//  Copyright © 2019年 com.fenghanxu.demol. All rights reserved.
//  应该移动到 Extension(工具类)  单例宏定义

#import <Foundation/Foundation.h>

#define Single_interface(class) \
+ (instancetype)sharedInstance;

#define Single_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
\
+ (instancetype)sharedInstance \
{ \
if (_instance == nil) { \
_instance = [[class alloc] init]; \
} \
\
return _instance; \
}\
\
-(id)copyWithZone:(NSZone *)zone{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone{\
return _instance;\
}

NS_ASSUME_NONNULL_BEGIN

@interface Single : NSObject

@end

NS_ASSUME_NONNULL_END
