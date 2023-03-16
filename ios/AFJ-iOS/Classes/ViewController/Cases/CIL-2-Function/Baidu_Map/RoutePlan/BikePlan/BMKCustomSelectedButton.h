//
//  BMKCustomSelectedButton.h
//  BMKBikeRoutePlanDemo
//
//  Created by baidu on 2020/5/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BMKCustomSelectedButtonDelegate <NSObject>

@optional

- (void)didClickSelectButton:(UIButton *)sender;

@end


@interface BMKCustomSelectedButton : UIButton

@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UILabel *rightLabel;
@property(nonatomic, weak) id <BMKCustomSelectedButtonDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
