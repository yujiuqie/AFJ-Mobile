//
//  NSString+CN.h
//  CrispyNews
//
//  Created by xuewu.long on 16/8/18.
//  Copyright © 2016年 fmylove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (CN)

/// 计算文本适配尺寸 ，默认当行文字， 变宽！
//- (CGSize)sizeWithFont:(UIFont *)font;

- (NSString *)urlCoding;

- (NSString *)URLEncoded;

- (NSString *)URLDecoded;


/**
 缓存文件编码命名方法
 这个方法源自SDImageCache， 注意在更新SDWebImage 库的时候，保持方法编码方式的统一。
 @param key 原文件名

 @return 编码后的文件名
 */
+ (NSString *)cachedFileNameForKey:(NSString *)key;

/**
 判断是否是一个图片文件的路径,使用排除法，如果不是json，也不是一个目录文件，则即判断为是一个图片路径，是有问题的！

 @return isImagePath ？ YES ： NO
 */
- (BOOL)CNISImagePath;

- (void)fileSize:(void (^)(NSString *size))thisBlock;


@end
