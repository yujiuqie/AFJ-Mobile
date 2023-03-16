//
//  AFJColorManager.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/15.
//

#import "AFJColorManager.h"

@implementation AFJColorManager

+ (instancetype)sharedInstance {
    static AFJColorManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[AFJColorManager alloc] init];
    });

    return shared;
}

- (void)reset {

}

- (NSArray *)fullColorList {
    return @[];
}

- (NSArray *)currentColorList {
    return @[];
}

- (void)add:(AFJColor *)color {

}

- (void)remove:(AFJColor *)color {

}

@end
