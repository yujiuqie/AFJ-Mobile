//
//  BinarySystem.m
//  sharesChonse
//
//  Created by 冯汉栩 on 2019/2/4.
//  Copyright © 2019年 fenghanxuCompany. All rights reserved.
//

@implementation BinarySystem

/**
 10进制数字转换为N进制字符串
 
 @param decimal 10进制数字
 
 @return N进制的字符串
 */
+ (NSString *)binarySystemTenStrTurnNBinarySystem:(unsigned long long)decimal binarySystemNum:(int)num {

    NSMutableString *dd = @"".mutableCopy;
    NSString *parma = @"0123456789abcdefghijklmnopqrstuvwxyz";
    unsigned long long i = decimal;
    while (i > 0) {
        int c = i % num;
        i = i / num;
        char cc = [parma characterAtIndex:c];
        [dd insertString:[NSString stringWithFormat:@"%c", cc] atIndex:0];
    }
    return dd;

}

/**
 将N进制的字符串转为10进制的数字
 @param str N进制的字符串
 @return 10进制的数字
 */
+ (unsigned long long)binarySystemNStrTurnTenBinarySystem:(NSString *)str binarySystemNum:(int)num {

    NSString *str36 = str.lowercaseString.copy;
    NSString *param = @"0123456789abcdefghijklmnopqrstuvwxyz";
    unsigned long long numner = 0;

    for (unsigned long long i = 0; i < str36.length; i++) {
        char iChar = [str36 characterAtIndex:i];
        for (NSInteger j = 0; j < param.length; j++) {
            char jChar = [param characterAtIndex:j];
            if (iChar == jChar) {
                unsigned long long n = j * pow(num, str36.length - i - 1);
                numner += n;
                break;
            }
        }
    }
    return numner;
}

@end
