//
//  BMKGlobalLocResultView.h
//  BMKGlobalLocOCDemo
//
//  Created by v_chiyuanwei on 2020/7/14.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMKGlobalLocInfoView : UIView

/// 单次定位结果
@property(nonatomic, strong) NSString *coldInfo;
/// 连续定位结果
@property(nonatomic, strong) NSString *hotInfo;

@end

NS_ASSUME_NONNULL_END
