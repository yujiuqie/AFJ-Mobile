//
//  MoveBtnVC.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/5/28.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

#import "NerdyUI.h"

#define safeBottom 100+49
#define widthAheight 100

@interface MoveBtnVC () <SafeCenterButtonDelegate>
@property(nonatomic, strong) SafeCenterButton *loginBtn;
@property(nonatomic, assign) CGRect rect;
@end

@implementation MoveBtnVC

- (void)loginBtnShow {
    if (NO) {//虽然现实，但是还有一个前提  判断是否登录
        [UIView animateWithDuration:1.0 animations:^{
            self.loginBtn.xywh(self.rect.origin.x, self.rect.origin.y, widthAheight, widthAheight);
        }];
    }
}

- (void)loginBtnDismiss {
    [UIView animateWithDuration:0.6 animations:^{
        if (self.rect.origin.x == 0) {
            self.loginBtn.xywh(self.rect.origin.x - widthAheight, self.rect.origin.y, widthAheight, widthAheight);
        } else {
            self.loginBtn.xywh(self.rect.origin.x + widthAheight, self.rect.origin.y, widthAheight, widthAheight);
        }
    }];
}

- (void)loginBtnFront {
    [self.view bringSubviewToFront:self.loginBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.rect = CGRectMake(Phone_Width - widthAheight, Phone_Height - safeBottom - widthAheight - 100, widthAheight, widthAheight);
    self.loginBtn = [[SafeCenterButton alloc] initWithImage:@"loginBtn" top:statusHight bottom:safeBottom frame:self.rect];
    self.loginBtn.delegate = self;
    [self.view addSubview:self.loginBtn];
    if (NO) {//虽然现实，但是还有一个前提  判断是否登录
        self.loginBtn.xywh(self.rect.origin.x + widthAheight, self.rect.origin.y, widthAheight, widthAheight);
    }
}

- (void)safeCenterButton:(SafeCenterButton *)view btnClick:(NSString *)name {
    [self loginBtnDismiss];

    //跳转登录页面
    NSLog(@"登录成功");
//   [FHXRouter openURL:[NSURL URLWithString:@"http://Route/Login#push"]];
}

- (void)safeCenterButton:(SafeCenterButton *)view btnFrame:(CGRect)rect {
    self.rect = rect;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self loginBtnDismiss];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loginBtnShow];
    });
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loginBtnShow];
    });
}

@end
