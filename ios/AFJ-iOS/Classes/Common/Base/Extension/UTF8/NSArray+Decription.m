//
//  NSArray+Decription.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/4/29.
//  Copyright © 2019 fenghanxu.compang.cn. All rights reserved.
//

@implementation NSArray (Decription)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long) self.count];

    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }

    [str appendString:@")"];

    return str;

}
@end
