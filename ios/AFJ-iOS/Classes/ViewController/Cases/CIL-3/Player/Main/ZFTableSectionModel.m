//
//  ZFTableSectionModel.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2019/6/4.
//  Copyright © 2019 紫枫. All rights reserved.
//

#import "ZFTableSectionModel.h"

@implementation ZFTableItem

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle viewControllerName:(NSString *)name {
    ZFTableItem *model = [[self alloc] init];
    model.title = title;
    model.subTitle = subTitle;
    model.viewControllerName = name;
    return model;
}

@end

@implementation ZFTableSectionModel

+ (instancetype)sectionModeWithTitle:(NSString *)title items:(NSArray <ZFTableItem *> *)items {
    ZFTableSectionModel *sectionModel = [[self alloc] init];
    sectionModel.title = title;
    sectionModel.items = items;
    return sectionModel;
}

@end
