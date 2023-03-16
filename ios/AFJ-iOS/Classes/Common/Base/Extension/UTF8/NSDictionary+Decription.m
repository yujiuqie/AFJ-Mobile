//
//  NSDictionary+Decription.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/4/29.
//  Copyright © 2019 fenghanxu.compang.cn. All rights reserved.
//

@implementation NSDictionary (Decription)

- (NSString *)descriptionWithLocale:(id)locale {
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value = self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n", key, value];
    }
    [str appendString:@"}"];

    return str;
}

@end
