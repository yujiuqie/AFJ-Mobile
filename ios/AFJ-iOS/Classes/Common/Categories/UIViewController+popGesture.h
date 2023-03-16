//
//  UIViewController+popGesture.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (popGesture)

+ (void)popGestureClose:(UIViewController *)VC;

+ (void)popGestureOpen:(UIViewController *)VC;

@end

NS_ASSUME_NONNULL_END
