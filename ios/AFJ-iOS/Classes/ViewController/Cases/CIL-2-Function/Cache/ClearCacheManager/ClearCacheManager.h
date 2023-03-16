//
//  XPClearCacheManager.h
//  YouXiaShijie
//
//  Created by 冯汉栩 on 2017/9/1.
//  Copyright © 2017年 冯汉栩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClearCacheManager : NSObject

//单例
+ (instancetype)shareClearCacheManager;

//获取所有缓存大小
- (float)getCacheSize;

//清除缓存
- (void)removeCache;

@end
