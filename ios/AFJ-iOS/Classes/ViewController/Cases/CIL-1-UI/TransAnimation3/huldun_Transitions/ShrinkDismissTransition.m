//
//  ShrinkDismissTransition.m
//  Transitions
//
//  Created by Haldun Bayhantopcu on 29/01/14.
//  Copyright (c) 2014 Monoid. All rights reserved.
//

#import "ShrinkDismissTransition.h"

@implementation ShrinkDismissTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
  return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
  // obtain state from context
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
  
  // obtain the container view
  UIView *containerView = [transitionContext containerView];
  
  toViewController.view.frame = finalFrame;
  toViewController.view.alpha = 0.5;
  
  [containerView addSubview:toViewController.view];
  [containerView sendSubviewToBack:toViewController.view];
  
  // determine the intermediate and final frame for the from view
  CGRect screenBounds = [UIScreen mainScreen].bounds;
  CGRect shrunkenFrame = CGRectInset(fromViewController.view.frame,
                                     fromViewController.view.frame.size.width / 4,
                                     fromViewController.view.frame.size.height / 4);
  CGRect fromFinalFrame = CGRectOffset(shrunkenFrame, 0, screenBounds.size.height);
  NSTimeInterval duration = [self transitionDuration:transitionContext];
  
  // create a snapshot
  UIView *snapshot = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
  snapshot.frame = fromViewController.view.frame;
  [containerView addSubview:snapshot];
  
  // remove the real view
  [fromViewController.view removeFromSuperview];
  
  // animate with keyframes
  [UIView animateKeyframesWithDuration:duration
                                 delay:0.0
                               options:UIViewKeyframeAnimationOptionCalculationModeCubic
                            animations:^{
                              // add keyframe one
                              [UIView addKeyframeWithRelativeStartTime:0.0
                                                      relativeDuration:0.5
                                                            animations:^{
                                                              snapshot.frame = shrunkenFrame;
                                                              toViewController.view.alpha = 0.5;
                                                            }];
                              // add keyframe two
                              [UIView addKeyframeWithRelativeStartTime:0.5
                                                      relativeDuration:0.5
                                                            animations:^{
                                                              snapshot.frame = fromFinalFrame;
                                                              toViewController.view.alpha = 1.0;
                                                            }];
                            } completion:^(BOOL finished) {
                              // remove snapshot
                              [snapshot removeFromSuperview];
                              // inform the context of completion
                              [transitionContext completeTransition:YES];
                            }];
}

@end
