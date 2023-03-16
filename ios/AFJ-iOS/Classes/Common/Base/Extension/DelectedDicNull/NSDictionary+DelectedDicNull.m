//
//  NSDictionary+DelectedDicNull.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/6/19.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

@implementation NSDictionary (DelectedDicNull)

- (NSDictionary *)deleteAllNullValue {

    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];

    for (NSString *keyStr in self.allKeys) {
        if ([[self objectForKey:keyStr] isEqual:[NSNull null]]) {
            [mutableDic setObject:@"" forKey:keyStr];
        } else {
            [mutableDic setObject:[self objectForKey:keyStr] forKey:keyStr];
        }
    }

    return mutableDic;
}


@end
