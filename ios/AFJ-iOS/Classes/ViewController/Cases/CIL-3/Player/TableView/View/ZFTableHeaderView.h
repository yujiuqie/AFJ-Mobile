//
//  ZFTableHeaderView.h
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2018/10/30.
//  Copyright © 2018 紫枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFTableData.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZFTableHeaderView : UIView

@property(nonatomic, strong) ZFTableData *data;
@property(nonatomic, strong, readonly) UIImageView *coverImageView;

@property(nonatomic, copy) void (^playCallback)(void);

@end

NS_ASSUME_NONNULL_END
