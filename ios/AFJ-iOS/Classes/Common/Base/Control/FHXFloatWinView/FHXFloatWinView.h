//
//  FHXFloatWinView.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/4/16.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FHXFloatWinViewBlcok)(NSString *value, NSString *operating);

@interface FHXFloatWinView : UIView

+ (void)showViewWithRect:(CGRect)rect withList:(NSMutableArray<NSString *> *)list withBlock:(FHXFloatWinViewBlcok)block;

+ (void)cancelFloatView;

@end

NS_ASSUME_NONNULL_END
