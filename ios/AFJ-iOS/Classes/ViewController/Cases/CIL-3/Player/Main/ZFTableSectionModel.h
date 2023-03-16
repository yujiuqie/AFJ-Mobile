//
//  ZFTableSectionModel.h
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2019/6/4.
//  Copyright © 2019 紫枫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFTableItem : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subTitle;
@property(nonatomic, copy) NSString *viewControllerName;

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle viewControllerName:(NSString *)name;

@end

@interface ZFTableSectionModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSArray <ZFTableItem *> *items;

+ (instancetype)sectionModeWithTitle:(NSString *)title items:(NSArray <ZFTableItem *> *)items;

@end

NS_ASSUME_NONNULL_END
