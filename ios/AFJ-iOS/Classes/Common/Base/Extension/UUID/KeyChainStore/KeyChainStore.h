//
//  KeyChainStore.h
//  SDBank_iOS
//
//  Created by sdebank on 2021/8/31.
//  Copyright © 2021 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)deleteKeyData:(NSString *)service;
@end

NS_ASSUME_NONNULL_END
