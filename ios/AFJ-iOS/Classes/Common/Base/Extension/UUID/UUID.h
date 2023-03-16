//
//  UUID.h
//  SDBank_iOS
//
//  Created by sdebank on 2021/8/31.
//  Copyright © 2021 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyChainStore.h"

NS_ASSUME_NONNULL_BEGIN

@interface UUID : NSObject

+ (NSString *)getUUID;

@end

NS_ASSUME_NONNULL_END
