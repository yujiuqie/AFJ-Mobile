//
//  SafeCenterButton.h
//  OCDemol
//
//  Created by 冯汉栩 on 2020/5/28.
//  Copyright © 2020 com.fenghanxu.demol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SafeCenterButton;

@protocol SafeCenterButtonDelegate <NSObject>

- (void)safeCenterButton:(SafeCenterButton *)view btnClick:(NSString *)name;

- (void)safeCenterButton:(SafeCenterButton *)view btnFrame:(CGRect)rect;

@end

@interface SafeCenterButton : UIView

@property(nonatomic, weak) id <SafeCenterButtonDelegate> delegate;

- (instancetype)initWithImage:(NSString *)name top:(CGFloat)top bottom:(CGFloat)bottom frame:(CGRect)frame;

@end

