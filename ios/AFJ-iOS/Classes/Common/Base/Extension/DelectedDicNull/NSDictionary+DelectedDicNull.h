//
//  NSDictionary+DelectedDicNull.h
//  OCDemol
//
//  Created by 冯汉栩 on 2019/6/19.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//  删除字典中的null 以便NSUserDefaults存储
//  https://blog.csdn.net/mscinsidious/article/details/51459991

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (DelectedDicNull)

- (NSDictionary *)deleteAllNullValue;

@end

NS_ASSUME_NONNULL_END
