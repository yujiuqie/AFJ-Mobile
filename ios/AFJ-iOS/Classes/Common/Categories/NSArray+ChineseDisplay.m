//
//  NSArray+ChineseDisplay.m
//  Day02 - NSURLConnection_JSON解析
//
//  Created by Joya Wang on 2020/1/12.
//  Copyright © 2020 Joya Wang. All rights reserved.
//


@implementation NSArray (ChineseDisplay)


/*
 数组和字典中汉字中文的控制台输出显示问题
 */

- (NSString *)description {
    /*
     原理:
     数组中的字符串数据从数组直接打印时无法正常显示，但是以字符串对象打印时可以
     所以将数组中的字符串对象拼接成一个字符串，然后打印
     拼接的时候，按照控制台输出数组的格式拼接
     */

    NSMutableString *dscp = [NSMutableString string];// 创建可变字符串对象

    [dscp appendString:@"(\r\n"]; // 先拼接上面的左括号和回车

    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [dscp appendFormat:@"\t%@,\r\n", obj]; // 把数组中的每个元素拼接进去，添加制表符、逗号和回车
    }];

    [dscp appendString:@")"]; // 最后拼接右括号
    return dscp.copy;
}


@end
