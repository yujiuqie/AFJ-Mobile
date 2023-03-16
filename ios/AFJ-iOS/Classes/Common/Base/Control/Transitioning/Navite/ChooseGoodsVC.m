//
//  ChooseGoodsVC.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/10/15.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

#import "ChooseGoodsVC.h"
#import "NerdyUI.h"

@interface ChooseGoodsVC () <UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) UIButton *bgBtn;

@end

@implementation ChooseGoodsVC

- (instancetype)init {

    self = [super init];
    if (self) {
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
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;//设置当前控制器的内容显示在上一个控制器(n不设置会黑屏)
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bgBtn = [UIButton new];
    self.bgBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.bgBtn.addTo(self.view).makeCons(^{
        make.left.top.right.bottom.equal.view(self.view);
    }).onClick(^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });

    UIView *view = [UIView new];
    view.addTo(self.bgBtn).bgColor([UIColor redColor]).makeCons(^{
        make.left.bottom.right.equal.view(self.bgBtn);
        make.height.equal.constants(Phone_Height * 0.5);
    });

}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[ShopDetailTransitioning alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[ShopDetailTransitioning alloc] init];
}


@end
