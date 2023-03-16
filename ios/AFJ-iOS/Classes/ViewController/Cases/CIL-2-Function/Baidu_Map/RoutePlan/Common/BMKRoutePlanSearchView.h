//
//  BMKRoutePlanSearchView.h
//  BMKTransitRoutePlanDemo
//
//  Created by baidu on 2020/5/25.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BMKRoutePlanSearchViewDelegate <NSObject>

@optional
- (void)didClickSearchButton;
@end

@interface BMKRoutePlanSearchView : UIView
/// 起点输入框
@property(nonatomic, strong) UITextField *startTextField;
/// 终点输入框
@property(nonatomic, strong) UITextField *endTextField;
/// 检索按钮
@property(nonatomic, strong) UIButton *searchButton;

@property(nonatomic, weak) id <BMKRoutePlanSearchViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
