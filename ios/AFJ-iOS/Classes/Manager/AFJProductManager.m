//
//  AFJProductManager.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/11.
//

#import "AFJProductManager.h"

@implementation AFJProductManager

+ (instancetype)sharedInstance {
    static AFJProductManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[AFJProductManager alloc] init];
    });

    return shared;
}

- (NSArray *)fullItemList {
    if (!_fullItemList) {
        NSMutableArray *dataArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"product-list" ofType:@"json"];
        NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

        NSError *error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

        if (error) {
            NSLog(@"product list parse error : %@", error);
        }

        if ([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *results = object;
            NSLog(@"product list parse success");
            NSArray *titles = [[results allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                return [obj1 intValue] - [obj2 intValue];
            }];
            for (NSString *title in titles) {
                NSDictionary *dic = [results objectForKey:title];
                AFJCaseItemData *item = [AFJCaseItemData new];
                item.type = [dic objectForKey:@"type"];
                item.title = [dic objectForKey:@"name"];
                item.list = [dic objectForKey:@"list"];
                [dataArray addObject:item];
            }
        } else {
            NSLog(@"product list parse error : %@", object);
        }

        _fullItemList = [dataArray copy];
    }

    return _fullItemList;
}

- (NSArray *)fullProductList {
    if (!_fullProductList) {
        NSMutableArray *fullList = [NSMutableArray array];

        for (AFJCaseItemData *item in [self fullItemList]) {
            [fullList addObjectsFromArray:item.list];
        }

        _fullProductList = [fullList copy];
    }
    return _fullProductList;
}

@end
