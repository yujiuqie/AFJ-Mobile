//
//  NSString+CN.m
//  CrispyNews
//
//  Created by xuewu.long on 16/8/18.
//  Copyright © 2016年 fmylove. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>


@implementation NSString (CN)

//- (CGSize)sizeWithFont:(UIFont *)font {
//    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:self];
//
//    //1
//    [attString addAttribute:NSFontAttributeName             //文字字体
//                      value:font ?: [UIFont systemFontOfSize:17]
//                      range:NSMakeRange(0, self.length)];
//
//    //2
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) attString);
//    //3
//    CFRange visibleRange;
//    CGSize constraint = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
//    CGSize newSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [self length]), nil, constraint, &visibleRange);
//
//    return newSize;
//}

- (NSString *)urlCoding {
    /// URLCodeing 添加 转译
    NSMutableString *muString = [NSMutableString stringWithString:self];
    [muString replaceOccurrencesOfString:@"/" withString:@"{1}" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muString.length)];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"!*'();:@+$,/[]"];
    return [muString stringByAddingPercentEncodingWithAllowedCharacters:set];
}

- (NSString *)URLEncoded {
    NSString *encodedString = (NSString *)
            CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                    (CFStringRef) self,
                    NULL,
                    (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                    kCFStringEncodingUTF8));

    return encodedString;
}

- (NSString *)URLDecoded {
    NSString *decodedString = (__bridge_transfer NSString *)
            CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                    (__bridge CFStringRef) self,
                    CFSTR(""),
                    CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

+ (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG) strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                                                    r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                                                    r[11], r[12], r[13], r[14], r[15], [[key pathExtension] isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", [key pathExtension]]];

    return filename;
}

- (BOOL)CNISImagePath {
    BOOL flag = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:self isDirectory:&flag]) {
        if (flag) {
            return NO;
        }
        if ([self containsString:@".json"]) {
            return NO;
        }
    } else {
        return NO;
    }
    if ([self containsString:@".jpg"] || [self containsString:@".jpeg"] || [self containsString:@".png"] || [self containsString:@"gif"]) {
        return YES;
    }
    return YES;
}


- (void)fileSize:(void (^)(NSString *size))thisBlock; {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 总大小
        unsigned long long size = 0;
        NSString *sizeText = nil;
        // 文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];

        // 文件属性
        NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
        // 如果这个文件或者文件夹不存在,或者路径不正确直接返回0;
        if (attrs == nil) {
            if (thisBlock) {
                thisBlock(@"0");
            }
            return;
        } else if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
            // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
            NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
            for (NSString *subpath in enumerator) {
                // 全路径
                NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
                // 累加文件大小
                size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;

                if (size >= pow(10, 9)) { // size >= 1GB
                    sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
                } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                    sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
                } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                    sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
                } else { // 1KB > size
                    sizeText = [NSString stringWithFormat:@"%zdB", size];
                }
            }
        } else { // 如果是文件
            size = attrs.fileSize;
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (thisBlock) {
                thisBlock(sizeText);
            }
        });
    });

}

+ (BOOL)empty:(NSObject *)o {
    if (o == nil) {
        return YES;
    }
    if (o == NULL) {
        return YES;
    }
    if (o == [NSNull new]) {
        return YES;
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [NSString isBlankString:(NSString *) o];
    }
    if ([o isKindOfClass:[NSData class]]) {
        return [((NSData *) o) length] <= 0;
    }
    if ([o isKindOfClass:[NSDictionary class]]) {
        return [((NSDictionary *) o) count] <= 0;
    }
    if ([o isKindOfClass:[NSArray class]]) {
        return [((NSArray *) o) count] <= 0;
    }
    if ([o isKindOfClass:[NSSet class]]) {
        return [((NSSet *) o) count] <= 0;
    }
    return NO;
}

+ (BOOL)isBlankString:(NSString *)string {

    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isEqual:nil]
            || [string isEqual:Nil]) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (0 == [string length]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }

    return NO;

}


@end
