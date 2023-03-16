//
//  BlockChooseGoodsVC.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/10/15.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

#import "BlockChooseGoodsVC.h"
#import "NerdyUI.h"

typedef void(^CallBackBlcok)(NSString *text);

@interface BlockChooseGoodsVC () <UIViewControllerTransitioningDelegate>
@property(nonatomic, strong) UIButton *bgBtn;
@property(nonatomic, assign) CGFloat ratioH;
@property(nonatomic, strong) UIViewController *presentingVC;
@property(nonatomic, strong) UIView *buyGoodView;
@property(nonatomic, copy) CallBackBlcok callBackBlock;

@end

@implementation BlockChooseGoodsVC

- (CGFloat)ratioH {
    if (_ratioH == 0) {
        if (IPhoneX) {_ratioH = 1;}
        _ratioH = Phone_Height / 667;
    }
    return _ratioH;
}

+ (void)showVC:(UIViewController *)vc byCallBlock:(void (^)(NSString *))callBlock {
    BlockChooseGoodsVC *chooseVC = [[BlockChooseGoodsVC alloc] init:callBlock];
    [chooseVC presentVC];
}

- (instancetype)init:(void (^)(NSString *))calBlock {
    self = [super init];
    if (self) {
        self.callBackBlock = calBlock;
    }
    return self;
}


- (void)presentVC {
    //必须自身遵守代理才能够实现转场动画
    self.transitioningDelegate = self;
    //设置弹出presented VC时场景切换动画的风格
    /*
     UIModalTransitionStyleCoverVertical = 0, //从下到上盖上进入
     UIModalTransitionStyleFlipHorizontal, //水平翻转
     UIModalTransitionStyleCrossDissolve, //渐变出现
     UIModalTransitionStylePartialCurl, //类似翻页的卷曲
     */
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//渐变出现
    //它决定了当前控制器 present 出的下一控制器的展示方式。
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;//设置当前控制器的内容显示在上一个控制器(不设置会黑屏)
    self.presentingVC = [GetVC getRootViewController];
    [self.presentingVC presentViewController:self animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.callBackBlock(@"block");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat topHeight = Phone_Height - 425 * self.ratioH;
    self.bgBtn = [UIButton new];
    self.bgBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.bgBtn.addTo(self.view).frame = CGRectMake(0, 0, Phone_Width, topHeight);
    self.bgBtn.addTo(self.view).onClick(^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });

    self.buyGoodView = [UIView new];
    self.buyGoodView.addTo(self.bgBtn).bgColor([UIColor redColor]);
    self.buyGoodView.frame = CGRectMake(0, topHeight, Phone_Width, Phone_Height - topHeight);
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[ShopDetailTransitioning alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[ShopDetailTransitioning alloc] init];
}

@end

