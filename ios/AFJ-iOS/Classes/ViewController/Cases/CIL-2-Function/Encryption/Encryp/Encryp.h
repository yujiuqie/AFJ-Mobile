//
//  Encryp.h
//  Frame
//
//  Created by 冯汉栩 on 2021/5/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Encryp : NSObject


/**
 *  MD5加密, 32位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 *  MD5加密, 32位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 *  MD5加密, 16位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *)MD5ForUpper16Bate:(NSString *)str;


/**
 *  base64加密
 *
 *  @param sourceData   二进制数据
 *
 *  @return 返回加密信息
 */
+ (NSString *)base64EncodingEncryptionWithData:(NSData *)sourceData;

/**
 *  base64解密
 *
 *  @param sourceData   二进制数据
 *
 *  @return 返回加密信息
 */
+ (id)base64EncodingWithDecryptWithData:(NSData *)sourceData;


/**
 *  SHA1加密
 *
 *  @param input 未加密嘻嘻
 *
 *  @return 返回加密信息
 */
+ (NSString *)SHA1:(NSString *)input;

/**
 *  AES128加密  补位
 *
 *  @param plainText 未加密信息     不够128  自动补位0x00(看代码原理就知道)   看后台需求
 *
 *  @return 返回加密信息
 */
+ (NSString *)AES128EncryptComplementWithPlainText:(NSString *)plainText;

/**
 *  AES128加密   不补位
 *
 *  @param plainText 未加密信息     不够128  不补位
 *
 *  @return 返回加密信息
 */
+ (NSString *)AES128EncryptNoComplementWithPlainText:(NSString *)plainText;

/**
 *  AES128加密
 *
 *  @param encryptText 加密信息
 *
 *  @return 返回加密信息
 */
+ (NSString *)AES128Decrypt:(NSString *)encryptText;

@end

NS_ASSUME_NONNULL_END
