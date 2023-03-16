//
//  AFJRootViewController.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/11.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJRootViewController : UIViewController

@property(nonatomic, strong) AFJCaseItemData *product;

- (void)showToastWithMessage:(NSString *)message;

- (void)showAlertWithImage:(UIImage *)image;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message complete:(void (^)(NSString *info))handler;

- (void)showInputAlert:(NSString *)title complete:(void (^)(NSString *info))handler;

- (void)showInputAlert:(NSString *)title placeholder:(NSString *)placeholder complete:(void (^)(NSString *info))handler;

- (void)jumpToDemo;

- (void)setupWebViewWith:(NSString *)url;

- (void)presentWebViewWith:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
