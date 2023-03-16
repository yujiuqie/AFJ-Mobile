//
//  AFJIMViewController.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/27.
//

#import "AFJRootViewController.h"
#import "IMMainViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJIMViewController : AFJRootListViewController

@property(strong, nonatomic) IMMainViewController *viewController;

+ (AFJIMViewController *)sharedIMViewController;

- (void)switchToLoginViewController;

- (void)switchToMainViewController;

- (UIView *)getMainView;

- (IMMainViewController *)getMainViewController;

- (void)refreshConnecteStatus;

@end

NS_ASSUME_NONNULL_END
