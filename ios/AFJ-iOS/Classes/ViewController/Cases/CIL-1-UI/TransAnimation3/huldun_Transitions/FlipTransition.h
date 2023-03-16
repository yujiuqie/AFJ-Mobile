//
//  FlipTransition.h
//  Transitions
//
//  Created by Haldun Bayhantopcu on 29/01/14.
//  Copyright (c) 2014 Monoid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlipTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic, getter = isReverse) BOOL reverse;

@end
