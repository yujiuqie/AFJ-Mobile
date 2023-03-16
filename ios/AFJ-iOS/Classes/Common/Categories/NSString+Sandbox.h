//
//  NSString+Sandbox.h
//  封装获取沙盒目录分类
//
//  Created by Joya Wang on 2019/12/27.
//  Copyright © 2019 Joya Wang. All rights reserved.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Sandbox)
/*
 结合沙盒相应目录路径和要存储的文件的字符串名称，返回此文件在沙盒相关目录存储的路径
 */

- (instancetype)documentPath;

- (instancetype)tempPath;

- (instancetype)cachePath;


@end

NS_ASSUME_NONNULL_END
