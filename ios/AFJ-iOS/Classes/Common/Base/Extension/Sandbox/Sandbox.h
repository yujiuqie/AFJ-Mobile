//
//  Sandbox.h
//  demols
//
//  Created by sdbank on 2021/10/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sandbox : NSObject

//获取沙盒Documents路径
+ (NSString *)sandboxGetDocumentsPathWithName:(NSString *)name;

//获取沙盒Caches路径
+ (NSString *)sandboxGetCachesPathWithName:(NSString *)name;

//获取沙盒Tmp路径
+ (NSString *)sandboxGetTmpPathWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
