//
//  FHXSaveIcon.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/4/28.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHXSaveIconModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FHXSaveImage : NSObject

- (FHXSaveIconModel *)saveImage:(UIImage *)image withSavePath:(NSString *)savePath withSubSavePath:(NSString *)subSavePath;

@end

NS_ASSUME_NONNULL_END
