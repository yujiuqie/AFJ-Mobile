//
//  FlipTransition.m
//  Transitions
//
//  Created by Haldun Bayhantopcu on 29/01/14.
//  Copyright (c) 2014 Monoid. All rights reserved.
//

#import "FlipTransition.h"

@implementation FlipTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
  return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
  // obtain state from context
  NSTimeInterval duration = [self transitionDuration:transitionContext];
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *containerView = [transitionContext containerView];
  UIView *fromView = fromViewController.view;
  UIView *toView = toViewController.view;
  
  [containerView addSubview:toViewController.view];
  
  // add a perspective transform
  CATransform3D transform = CATransform3DIdentity;
  transform.m34 = -0.002;
  containerView.layer.sublayerTransform = transform;
  
  // give both vc the same start frame
  CGRect initialFrame = [transitionContext initialFrameForViewController:fromViewController];
  fromView.frame = initialFrame;
  toView.frame = initialFrame;
  
  // reverse?
  float factor = self.isReverse ? 1.0 : -1.0;
  
  // flip the toVC halfway round - hiding it
  toView.layer.transform = [self yRotation:factor * -M_PI_2];
  
  // animate
  [UIView animateKeyframesWithDuration:duration
                                 delay:0.0
                               options:0
                            animations:^{
                              [UIView addKeyframeWithRelativeStartTime:0.0
                                                      relativeDuration:0.5
                                                            animations:^{
                                                              // rotate the from view
                                                              fromView.layer.transform = [self yRotation:factor * M_PI_2];
                                                            }];
                              [UIView addKeyframeWithRelativeStartTime:0.5
                                                      relativeDuration:0.5
                                                            animations:^{
                                                              // rotate the to view
                                                              toView.layer.transform = [self yRotation:0.0];
                                                            }];
                            }
                            completion:^(BOOL finished) {
                              [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                            }];
}

- (CATransform3D)yRotation:(CGFloat)angle
{
  return CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
}

@end
