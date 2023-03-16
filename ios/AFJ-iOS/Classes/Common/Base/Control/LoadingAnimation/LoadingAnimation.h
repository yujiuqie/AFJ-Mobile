//
//  LoadingAnimation.h
//  OCDemol
//
//  Created by 冯汉栩 on 2020/1/15.
//  Copyright © 2020 com.fenghanxu.demol. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingAnimation : NSObject

Single_interface(LoadingAnimation)

@property(nonatomic, strong) UIImageView *icon;

+ (void)share;

@end

NS_ASSUME_NONNULL_END
