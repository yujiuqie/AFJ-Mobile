//
//  AFJColorManager.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/15.
//

#import <Foundation/Foundation.h>
#import "AFJColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJColorManager : NSObject

+ (instancetype)sharedInstance;

- (void)reset;

- (NSArray *)fullColorList;

- (NSArray *)currentColorList;

- (void)add:(AFJColor *)color;

- (void)remove:(AFJColor *)color;

@end

NS_ASSUME_NONNULL_END
