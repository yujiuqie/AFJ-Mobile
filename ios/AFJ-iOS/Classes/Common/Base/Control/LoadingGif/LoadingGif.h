//
//  JZLoadingViewPacket.h
//  OCDemol
//
//  Created by 冯汉栩 on 2020/3/12.
//  Copyright © 2020 com.fenghanxu.demol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingGif : UIView

- (void)hide;

+ (LoadingGif *)share;


+ (void)showWithAddToView:(UIView *)selfView withIimageName:(NSString *)name;

@end


NS_ASSUME_NONNULL_END
