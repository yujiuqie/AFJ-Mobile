//
//  NSString+FHXExtension.h
//  Frame
//
//  Created by 冯汉栩 on 2021/2/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FHXExtension)

//字符串倒序
+ (NSString *)reverseWordsInString:(NSString *)oldStr;

//字符串转json
+ (NSString *)stringToJSONString:(NSString *)string;

//JSON转字典
+ (NSDictionary *)convertToDictionary:(NSString *)jsonString;

// 字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

/**
 *  返回文字的size
 *
 *  @param font 文字大小
 *
 *  @param maxSize 限制的宽高
 *
 *  @return 返回Size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


/**
 *  类名返回控制器对应的类
 *
 *  @param str 类型
 *
 *  @return 返回一个实类
 */
+ (UIViewController *)stringChangeToClass:(NSString *)str;

/**
 *  生成随机数
 *
 *  @param len 长度
 *
 *  @return 返回随机生成字符串
 */
+ (NSString *)randomStringWithLength:(NSInteger)len;

/**
 *  指定字符串随机生成指定长度的新字符串
 *
 *  @param len 长度
 *
 *  @param letters    指定内容
 *
 *  @return 返回随机生成字符串
 */
+ (NSString *)randomStringWithLength:(NSInteger)len String:(NSString *)letters;


@end

NS_ASSUME_NONNULL_END
