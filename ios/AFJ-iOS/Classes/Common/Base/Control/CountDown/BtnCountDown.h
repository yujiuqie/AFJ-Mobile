//
//  BtnCountDown.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/3/27.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BtnCountDown : NSObject
/*
 用于外面秒数判断y确保倒数完毕才能再点击
 防止用户输入手机号码点击获取验证码按键 秒数倒数的过程中把手机号码删除 再输入另一个号码变成按键可点击
 if (self.btnCountDown.remainingSeconds > 0) {
 self.codeBtn.color([Color textSub]);
 self.codeBtn.enabled = NO;
 }else{
 self.codeBtn.color([Color theme]);
 self.codeBtn.enabled = YES;
 }
 */
@property(nonatomic, assign) NSInteger remainingSeconds;

- (void)startCount:(BOOL)tag countDownBtn:(UIButton *)btn btnTitleColor:(UIColor *)btnTitleColor btnBackgroung:(UIColor *)btnBackgroung;

- (void)startCount:(BOOL)tag countDownBtn:(UIButton *)btn byCountDownTitleColor:(UIColor *)countDownTitleColor byCountDownBgColor:(UIColor *)countDownbgColor byFinishCountDownTitleColor:(UIColor *)finishCountDownTitleColor byFinishcountDownbgColor:(UIColor *)finishcountDownbgColor;

@end

NS_ASSUME_NONNULL_END
