//
//  NSDictionary+ChineseDisplay.m
//  Day02 - NSURLConnection_JSON解析
//
//  Created by Joya Wang on 2020/1/12.
//  Copyright © 2020 Joya Wang. All rights reserved.
//


@implementation NSDictionary (ChineseDisplay)


- (NSString *)description {
    NSMutableString *dscp = [NSMutableString string];
    [dscp appendString:@"{\r\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {
        [dscp appendFormat:@"\t%@ = %@;\r\n", key, obj];
    }];
    [dscp appendString:@"}"];
    return dscp.copy;
}

@end
