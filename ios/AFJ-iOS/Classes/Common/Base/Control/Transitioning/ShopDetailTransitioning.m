//
//  ShopDetailTransitioning.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/10/15.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

@implementation ShopDetailTransitioning

// 转场时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *formVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (formVC == nil || toVC == nil) {
        return;
    }
    BOOL isPresenting = toVC.presentingViewController == formVC;
    UIView *formView = formVC.view;
    UIView *toView = toVC.view;

    // 容器/视图栈
    UIView *container = transitionContext.containerView;
    UIView *maskView = [UIView new];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.3;
    maskView.frame = [[UIApplication sharedApplication] keyWindow].frame;
    if (isPresenting) {
        maskView.y = 0;
    } else {
        maskView.y = -UIScreen.mainScreen.bounds.size.height;
    }
    [container addSubview:maskView];
    if (isPresenting) {
        formView.layer.transform = CATransform3DIdentity;
        toView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    } else {
        toView.layer.transform = CATransform3DMakeScale(0.85, 0.9, 1.0);
        formView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    }

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:
            ^{
                if (isPresenting) {
                    maskView.y = -UIScreen.mainScreen.bounds.size.height;
                    [container addSubview:toView];
                    formView.layer.transform = CATransform3DMakeScale(0.85, 0.9, 1.0);
                    toView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
                } else {
                    maskView.y = 0;
                    toView.layer.transform = CATransform3DIdentity;
                    formView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
                }
            }        completion:^(BOOL finished) {
        [maskView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

}

@end
