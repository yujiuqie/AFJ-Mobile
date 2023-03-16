//
//  AdvertiseGradientNSObject.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/10/29.
//  Copyright © 2019 fenghanxu.compang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvertiseGradientView.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kUserDefaults [NSUserDefaults standardUserDefaults]

@interface AdvertiseGradientNSObject : NSObject

+ (void)initAdvertise:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
