//
//  NSObject+FHXNSObject.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/11/8.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

@implementation NSObject (FHXNSObject)

#pragma mark - 判断一个对象是否为空

- (BOOL)isNull {
    if ([self isEqual:[NSNull null]]) {
        return YES;

    } else if ([self isEqual:[NSNull class]]) {
        return YES;
    } else {
        if (self == nil) {
            return YES;
        }
    }

    if ([self isKindOfClass:[NSString class]]) {
        if ([((NSString *) self) isEqualToString:@"(null)"]) {
            return YES;
        }
    }

    return NO;
}

@end
