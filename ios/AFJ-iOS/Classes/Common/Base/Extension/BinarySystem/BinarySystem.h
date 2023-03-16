//
//  BinarySystem.h
//  sharesChonse
//
//  Created by 冯汉栩 on 2019/2/4.
//  Copyright © 2019年 fenghanxuCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BinarySystem : NSObject

/**
 10进制数字转换为N进制字符串
 
 @param decimal 10进制数字
 
 @return N进制的字符串
 */
+ (NSString *)binarySystemTenStrTurnNBinarySystem:(unsigned long long)decimal binarySystemNum:(int)num;

/**
 将N进制的字符串转为10进制的数字
 @param str N进制的字符串
 @return 10进制的数字
 */
+ (unsigned long long)binarySystemNStrTurnTenBinarySystem:(NSString *)str binarySystemNum:(int)num;

@end

NS_ASSUME_NONNULL_END
