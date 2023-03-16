//
//  AFJProductManager.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFJProductManager : NSObject

@property(nonatomic, strong) NSArray *fullItemList;
@property(nonatomic, strong) NSArray *fullProductList;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
