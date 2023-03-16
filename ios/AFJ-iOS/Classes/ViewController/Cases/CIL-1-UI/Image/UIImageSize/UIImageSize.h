//
//  UIImageSize.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/3/28.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageSize : NSObject

// 支持 png、jpg、gif 等主流格式图片
// 根据图片url获取图片尺寸
- (CGSize)getImageSizeWithURL:(id)imageURL;

@end

NS_ASSUME_NONNULL_END
