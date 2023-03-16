//
//  UIImageView+FHXExtension.h
//  OCDemol
//
//  Created by 冯汉栩 on 2019/11/8.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (FHXExtension)

/**
 *  输入Url
 *
 * return  处理好的原型图片
 *
 */
- (void)setHeader:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
