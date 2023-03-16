//
//  Sandbox.m
//  demols
//
//  Created by sdbank on 2021/10/10.
//

#import "Sandbox.h"

@implementation Sandbox

+ (NSString *)sandboxGetDocumentsPathWithName:(NSString *)name {
    //获取Documents文件路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [NSString new];
    if (name != nil) {
        //Documents文件路径 拼接 文件名
        filePath = [documentsPath stringByAppendingPathComponent:name];
    } else {
        filePath = documentsPath;
    }
    NSLog(@"filePath: %@", filePath);
    return filePath;
}

//获取沙盒Caches路径
+ (NSString *)sandboxGetCachesPathWithName:(NSString *)name {
    //获取Caches文件路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [NSString new];
    if (name != nil) {
        //Documents文件路径 拼接 文件名
        filePath = [cachePath stringByAppendingPathComponent:name];
    } else {
        filePath = cachePath;
    }
    NSLog(@"filePath: %@", filePath);
    return filePath;
}

//获取沙盒Tmp路径
+ (NSString *)sandboxGetTmpPathWithName:(NSString *)name {
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *filePath = [NSString new];
    if (name != nil) {
        //Documents文件路径 拼接 文件名
        filePath = [tmpPath stringByAppendingPathComponent:name];
    } else {
        filePath = tmpPath;
    }
    NSLog(@"filePath: %@", filePath);
    return filePath;
}

@end
