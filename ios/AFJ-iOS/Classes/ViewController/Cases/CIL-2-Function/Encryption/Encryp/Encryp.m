//
//  Encryp.m
//  Frame
//
//  Created by 冯汉栩 on 2021/5/14.
//

#import "Encryp.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

#define gkey @"EQwRjg3NEU5RDA3Q" // 16位长度的字符串 自行修改  公司提供  如果用到公司的东西可以抽取出去另外建一个类方法
#define gIv @"APs6$^*(&(5sd1#^"  //16位长度的字符串 自行修改  公司提供   如果用到公司的东西可以抽取出去另外建一个类方法

@implementation Encryp


#pragma mark - 32位 小写

+ (NSString *)MD5ForLower32Bate:(NSString *)str {

    //要进行UTF8的转码
    const char *input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG) strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }

    return digest;
}

#pragma mark - 32位 大写

+ (NSString *)MD5ForUpper32Bate:(NSString *)str {

    //要进行UTF8的转码
    const char *input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG) strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }

    return digest;
}

#pragma mark - 16位 大写

+ (NSString *)MD5ForUpper16Bate:(NSString *)str {

    NSString *md5Str = [self MD5ForUpper32Bate:str];

    NSString *string;
    for (int i = 0; i < 24; i++) {
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写

+ (NSString *)MD5ForLower16Bate:(NSString *)str {

    NSString *md5Str = [self MD5ForLower32Bate:str];

    NSString *string;
    for (int i = 0; i < 24; i++) {
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


/**
 *  base64加密
 *
 *  @param sourceData    二进制数据
 *
 *  @return 返回加密信息
 */
+ (NSString *)base64EncodingEncryptionWithData:(NSData *)sourceData {
    if (!sourceData) {
        return nil;
    }
    NSString *resultString = [sourceData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return resultString;
}

/**
 *  base64解密
 *
 *  @param sourceData   二进制数据
 *
 *  @return 返回加密信息
 */
+ (id)base64EncodingWithDecryptWithData:(NSData *)sourceData {
    if (!sourceData) {
        return nil;
    }
    NSData *resultData = [[NSData alloc] initWithBase64EncodedData:sourceData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    //NSData *resultData = [[NSData alloc]initWithBase64EncodedString:sourceString options:NSDataBase64DecodingIgnoreUnknownCharacters];//接收字符串也可以的
    return resultData;
}

/**
 *  SHA1加密
 *
 *  @param input
 *
 *  @return 返回加密信息
 */
+ (NSString *)SHA1:(NSString *)input {

    //⚠️注意中文处理

    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int) data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

/**
 *  AES128加密  补位
 *
 *  @param plainText 未加密信息     不够128  自动补位0x00(看代码原理就知道)   看后台需求
 *
 *  @return 返回加密信息
 */
+ (NSString *)AES128EncryptComplementWithPlainText:(NSString *)plainText {
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];

    NSData *data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];

    //补位需要把注释的代码打开  2021.5.14
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    //补位需要把注释的代码打开    2021.5.14
    if (diff > 0) {
        newSize = dataLength + diff;
    }

    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);

    //补位需要把注释的代码打开     2021.5.14
    for (int i = 0; i < diff; i++) {
        dataPtr[i + dataLength] = 0x00;
    }

    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);

    size_t numBytesCrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
            kCCAlgorithmAES128,
            0x0000 | kCCOptionPKCS7Padding, // | kCCOptionECBMode 这里添加ECB模式，如果需要PKCS7Padding，那么后面再加上 | kCCOptionPKCS7Padding即可
            keyPtr,
            kCCKeySizeAES128,
            ivPtr,
            dataPtr,
            sizeof(dataPtr),
            buffer,
            bufferSize,
            &numBytesCrypted);

    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [GTMBase64 stringByEncodingData:resultData];
    }
    free(buffer);
    return nil;
}

/**
 *  AES128加密   不补位
 *
 *  @param plainText 未加密信息     不够128  不补位
 *
 *  @return 返回加密信息
 */
+ (NSString *)AES128EncryptNoComplementWithPlainText:(NSString *)plainText {
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];

    NSData *data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];

    int newSize = 0;

    newSize = dataLength;

    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);

    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);

    size_t numBytesCrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
            kCCAlgorithmAES128,
            0x0000 | kCCOptionPKCS7Padding, // | kCCOptionECBMode 这里添加ECB模式，如果需要PKCS7Padding，那么后面再加上 | kCCOptionPKCS7Padding即可
            keyPtr,
            kCCKeySizeAES128,
            ivPtr,
            dataPtr,
            sizeof(dataPtr),
            buffer,
            bufferSize,
            &numBytesCrypted);

    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [GTMBase64 stringByEncodingData:resultData];
    }
    free(buffer);
    return nil;
}

/**
 *  AES128加密
 *
 *  @param encryptText 加密信息
 *
 *  @return 返回加密信息
 */
+ (NSString *)AES128Decrypt:(NSString *)encryptText {
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];

    NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
            kCCAlgorithmAES128,
            0x0000 | kCCOptionPKCS7Padding, // | kCCOptionECBMode 这里添加ECB模式，如果需要PKCS7Padding，那么后面再加上 | kCCOptionPKCS7Padding即可
            keyPtr,
            kCCBlockSizeAES128,
            ivPtr,
            [data bytes],
            dataLength,
            buffer,
            bufferSize,
            &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}

@end
