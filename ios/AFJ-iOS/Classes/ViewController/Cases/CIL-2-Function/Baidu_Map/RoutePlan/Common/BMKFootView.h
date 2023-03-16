//
//  BMKFootView.h
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BMKFootViewDelegate <NSObject>

@optional
- (void)didClickDetailButton;
@end

@interface BMKFootView : UIView
@property(nonatomic, weak) id <BMKFootViewDelegate> delegate;

/// 更新页面数据
- (void)updateData:(BMKRouteLine *)routeLine;
@end

NS_ASSUME_NONNULL_END
