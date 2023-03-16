//
//  BMKGlobalLocTabView.h
//  BMKGlobalLocOCDemo
//
//  Created by v_chiyuanwei on 2020/7/14.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BMKGlobalLocTabViewDidClickTabBlock)(NSInteger idx, BOOL isSelected);

NS_ASSUME_NONNULL_BEGIN

@interface BMKGlobalLocTabView : UIView

@property(nonatomic, copy) BMKGlobalLocTabViewDidClickTabBlock didClickTabBlock;

@end

NS_ASSUME_NONNULL_END
