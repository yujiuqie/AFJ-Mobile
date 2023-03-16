//
//  FHXAvatarPicker.h
//  FHXAvatarPicker
//
//  Created by 冯汉栩 on 2019/4/6.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface FHXAvatarPicker : NSObject

+ (void)startSelected:(void (^)(UIImage *image))compleiton;

@end

NS_ASSUME_NONNULL_END
