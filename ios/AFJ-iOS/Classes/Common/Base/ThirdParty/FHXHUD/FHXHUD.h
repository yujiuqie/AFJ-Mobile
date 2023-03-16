//
//  FHXHUD.h
//  SVProgressHUDDemo
//
//  Created by 冯汉栩 on 2019/3/19.
//  Copyright © 2019年 冯汉栩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface FHXHUD : NSObject

//纯菊花旋转
+ (void)showChrysanthemumTime:(double)time;

//纯菊花旋转+文本信息
+ (void)showChrysanthemumTime:(double)time showTitle:(NSString *)title;

//成功标志+文本信息
+ (void)showSuccessTime:(double)time showTitle:(NSString *)title;

//失败标志+文本信息
+ (void)showErrorTime:(double)time showTitle:(NSString *)title;

//进度条
+ (void)showProgressPercentage:(double)percentage;

//感叹号+文本信息
+ (void)showInfoTime:(double)time showTitle:(NSString *)title;

//成功标志+文本信息
+ (void)showSuccessTime:(double)time showTitle:(NSString *)title finish:(void (^)(void))result;

//失败标志+文本信息
+ (void)showErrorTime:(double)time showTitle:(NSString *)title finish:(void (^)(void))result;

//感叹号+文本信息
+ (void)showInfoTime:(double)time showTitle:(NSString *)title finish:(void (^)(void))result;

@end

NS_ASSUME_NONNULL_END
