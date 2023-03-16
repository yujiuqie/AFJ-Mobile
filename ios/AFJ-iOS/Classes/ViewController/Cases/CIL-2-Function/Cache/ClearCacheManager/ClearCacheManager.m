//
//  ClearCacheManager.m
//  YouXiaShijie
//
//  Created by 冯汉栩 on 2017/9/1.
//  Copyright © 2017年 冯汉栩. All rights reserved.
//

#import "ClearCacheManager.h"

@implementation ClearCacheManager

+ (instancetype)shareClearCacheManager {
    static dispatch_once_t onceToken;
    static ClearCacheManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[ClearCacheManager alloc] init];
    });
    return manager;
}

//获取所有缓存大小
- (float)getCacheSize {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float foldersize = 0;
    if ([fileManager fileExistsAtPath:path]) {
        //拿到有文件的数据
        NSArray *childerFile = [fileManager subpathsAtPath:path];
        for (NSString *filename in childerFile) {
            NSString *fulpath = [path stringByAppendingPathComponent:filename];
            foldersize += [self fileSizePath:fulpath];
        }
    }
    return foldersize;
}

//根据路径获取大小
- (float)fileSizePath:(NSString *)path {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:path]) {
        long long size = [filemanager attributesOfItemAtPath:path error:nil].fileSize;
        return size / 1024.f / 1024.f;
    }
    return 0;
}

//清除缓存
- (void)removeCache {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        //拿到有文件的数据
        NSArray *childerFile = [fileManager subpathsAtPath:path];
        for (NSString *filename in childerFile) {
            NSString *fulpath = [path stringByAppendingPathComponent:filename];
            [fileManager removeItemAtPath:fulpath error:nil];
        }
    }
}
@end
