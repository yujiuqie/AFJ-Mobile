//
//  AdvertiseNsObject.h
//  advertiseDemo
//
//  Created by 冯汉栩 on 2019/7/22.
//  Copyright © 2019 zhouhuanqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AdvertiseCountDownView.h"

#define kUserDefaults [NSUserDefaults standardUserDefaults]

NS_ASSUME_NONNULL_BEGIN

@interface AdvertiseCountDownNsObject : NSObject

+ (void)initAdvertise:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
