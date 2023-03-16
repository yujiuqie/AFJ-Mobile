//
//  BtnCountDown.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/3/27.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

@interface BtnCountDown ()

@property(nonatomic, strong) UIButton *codeBtn;

@property(nonatomic, strong) NSTimer *countdownTimer;

@property(nonatomic, strong) UIColor *btnTitleColor;

@property(nonatomic, strong) UIColor *btnBackgroungColor;

@end

@implementation BtnCountDown

- (void)startCount:(BOOL)tag countDownBtn:(UIButton *)btn btnTitleColor:(UIColor *)btnTitleColor btnBackgroung:(UIColor *)btnBackgroung {
    self.codeBtn = btn;

    self.btnBackgroungColor = btnBackgroung;
    self.btnTitleColor = btnTitleColor;

    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    self.remainingSeconds = 60;
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.codeBtn setBackgroundColor:[Color nonActivated]];
    self.codeBtn.enabled = NO;
}

- (void)startCount:(BOOL)tag countDownBtn:(UIButton *)btn byCountDownTitleColor:(UIColor *)countDownTitleColor byCountDownBgColor:(UIColor *)countDownbgColor byFinishCountDownTitleColor:(UIColor *)finishCountDownTitleColor byFinishcountDownbgColor:(UIColor *)finishcountDownbgColor {
    self.codeBtn = btn;
    self.btnTitleColor = finishCountDownTitleColor;
    self.btnBackgroungColor = finishcountDownbgColor;
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    self.remainingSeconds = 60;
    [self.codeBtn setTitleColor:countDownTitleColor forState:UIControlStateNormal];
    [self.codeBtn setBackgroundColor:countDownbgColor];
    self.codeBtn.enabled = NO;

}

- (void)updateTime {
    self.remainingSeconds -= 1;
    [self.codeBtn setTitle:[NSString stringWithFormat:@"重新获取%ld秒", (long) self.remainingSeconds] forState:UIControlStateNormal];
    if (self.remainingSeconds <= 0) {
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];

        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
        [self.codeBtn setTitleColor:self.btnTitleColor forState:UIControlStateNormal];
        [self.codeBtn setBackgroundColor:self.btnBackgroungColor];
        self.codeBtn.enabled = YES;
    }

}

@end
