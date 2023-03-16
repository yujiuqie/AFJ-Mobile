//
//  AFJRootListViewController.h
//  AFJ-iOS
//
//  Created by alfred on 2023/2/21.
//

#import "QDCommonTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJRootListViewController : QMUICommonTableViewController

@property(nonatomic, strong) NSArray<AFJCaseItemData *> *dataSource;

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

@interface AFJRootListViewController (UISubclassingHooks)

// 子类继承，可以不调super
- (void)initDataSource;
- (void)didSelectCellWithTitle:(AFJCaseItemData *)item;

@end

NS_ASSUME_NONNULL_END
