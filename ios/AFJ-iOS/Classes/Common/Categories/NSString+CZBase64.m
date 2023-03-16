//
//  NSString+CZBase64.m
//
//  Created by 刘凡 on 16/6/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

@implementation NSString (CZBase64)

- (NSString *)cz_base64Encode {
    // base64“加密”密码 无论是编码解码还是加密解密 都是直接操作的二进制数据
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];

    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)cz_base64Decode {

    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];

    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
