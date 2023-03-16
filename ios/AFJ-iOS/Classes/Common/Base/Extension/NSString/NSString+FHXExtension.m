//
//  NSString+FHXExtension.m
//  Frame
//
//  Created by 冯汉栩 on 2021/2/8.
//

@implementation NSString (FHXExtension)

//字符串倒序
+ (NSString *)reverseWordsInString:(NSString *)oldStr {
    NSMutableString *newStr = [[NSMutableString alloc] initWithCapacity:oldStr.length];
    for (int i = (int) oldStr.length - 1; i >= 0; i--) {
        unichar character = [oldStr characterAtIndex:i];
        [newStr appendFormat:@"%c", character];
    }
    return newStr;
}

//字符串转json
+ (NSString *)stringToJSONString:(NSString *)string {
    /*
     "  (双引号)
     /  (正斜线)
     \n (换行符)
     \b (退格符)
     \f (换页符)
     \r (回车符)
     \t (制表符,一个tab或按8下空格)
     */
    NSMutableString *s = [NSMutableString stringWithString:string];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

//JSON转字典
+ (NSDictionary *)convertToDictionary:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSLog(@"%@", err);
        return nil;
    }
    return dic;
}

// 字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict {

    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

        NSLog(@"%@", error);

    } else {

        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0, jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0, mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}

//计算文字Size  输入文字大小  限制宽度或者高度
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//类名返回控制器对应的类
+ (UIViewController *)stringChangeToClass:(NSString *)str {
    id vc = [[NSClassFromString(str) alloc] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }
    return nil;
}

/**
 *  生成随机数
 *
 *  @param len 长度
 *
 *  @return 返回随机生成字符串
 */
+ (NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform([letters length])]];
    }
    return randomString;
}

/**
 *  指定字符串随机生成指定长度的新字符串
 *
 *  @param len 长度
 *
 *  @param letters    指定内容
 *
 *  @return 返回随机生成字符串
 */
+ (NSString *)randomStringWithLength:(NSInteger)len String:(NSString *)letters {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform([letters length])]];
    }
    return randomString;
}

@end
