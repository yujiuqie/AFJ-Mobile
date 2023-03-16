//
//  NSString+Sandbox.m
//  封装获取沙盒目录分类
//
//  Created by Joya Wang on 2019/12/27.
//  Copyright © 2019 Joya Wang. All rights reserved.
//


@implementation NSString (Sandbox)

/*
结合沙盒相应目录路径和要存储的文件的字符串名称，返回此文件在沙盒相关目录存储的路径
*/


- (instancetype)documentPath {
    // 获取当前path中文件的名字
    NSString *fileName = [self lastPathComponent];
    // 获取沙盒中document文件夹的路径
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接成当前文件在沙盒中document文件夹的路径
    return [document stringByAppendingPathComponent:fileName];
}

- (instancetype)tempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)cachePath {
    // 获取当前path中文件的名字
    NSString *fileName = [self lastPathComponent];
    // 获取沙盒中document文件夹的路径
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接成当前文件在沙盒cache文件夹的路径
    return [cache stringByAppendingPathComponent:fileName];
}

@end
