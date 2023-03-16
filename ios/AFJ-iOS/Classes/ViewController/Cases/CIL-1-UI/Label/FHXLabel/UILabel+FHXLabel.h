//
//  UILabel+FHXLabel.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/11/7.
//  Copyright © 2019 fenghanxu.compang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FHXLabel)

@property(assign, nonatomic) UIEdgeInsets edgeInsets;

/**
 
 [self.label dc_SetText:@"2019-11-06 10:29:11.761049+0800 OCDemol[9313:283391] [framework] CUIThemeStore: No theme registered with id=0" lineSpacing:20];
 
 设置label行间距
 
 @param text 文本
 @param lineSpacing 行间距
 */
- (void)fhxSetText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;

//竖排写
@property(nonatomic) NSString *verticalText;


@end

NS_ASSUME_NONNULL_END
