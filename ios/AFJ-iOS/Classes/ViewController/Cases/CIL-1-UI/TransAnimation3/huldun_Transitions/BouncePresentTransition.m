//
//  BouncePresentTransition.m
//  Transitions
//
//  Created by Haldun Bayhantopcu on 29/01/14.
//  Copyright (c) 2014 Monoid. All rights reserved.
//

#import "BouncePresentTransition.h"

@implementation BouncePresentTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
  return 0.7;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
  // obtain state from context
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
  
  // obtain the container view
  UIView *containerView = [transitionContext containerView];
  
  // set initial state
  CGRect screenBounds = [[UIScreen mainScreen] bounds];
  toViewController.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
  
  // add the view
  [containerView addSubview:toViewController.view];
  
  // animate
  [UIView animateWithDuration:[self transitionDuration:transitionContext]
                        delay:0
       usingSpringWithDamping:0.5
          initialSpringVelocity:0.0
                      options:UIViewAnimationOptionCurveLinear
                   animations:^{
                     fromViewController.view.alpha = 0.5;
                     toViewController.view.frame = finalFrame;
                   } completion:^(BOOL finished) {
                     fromViewController.view.alpha = 1.0;
                     // inform the context of completion
                     [transitionContext completeTransition:YES];
                   }];
}


@end
