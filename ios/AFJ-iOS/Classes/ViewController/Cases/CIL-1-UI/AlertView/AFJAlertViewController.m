//
//  AFJAlertViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/16.
//

#import "AFJAlertViewController.h"
#import "UIView+TYAlertView.h"
#import "TYAlertController+BlurEffects.h"
#import "WJYAlertInputTextView.h"
#import "WJYAlertView.h"
#import "SettingModelView.h"
#import "ShareView.h"

@interface AFJAlertViewController ()



@end

@implementation AFJAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Alert View";
        __weak typeof(self) weakSelf = self;
        item.didSelectAction = ^(id data) {
            [weakSelf showAlertViewAction];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Action Sheet";
        __weak typeof(self) weakSelf = self;
        item.didSelectAction = ^(id data) {
            [weakSelf showActionSheetAction];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"blur Effect Alert View";
        __weak typeof(self) weakSelf = self;
        item.didSelectAction = ^(id data) {
            [weakSelf blurEffectAlertViewAction];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"dropdwon Animation";
        __weak typeof(self) weakSelf = self;
        item.didSelectAction = ^(id data) {
            [weakSelf dropdwonAnimationAction];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"costom Acton Sheet";
        __weak typeof(self) weakSelf = self;
        item.didSelectAction = ^(id data) {
            [weakSelf costomActonSheetAction];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Alert View In Window";
        __weak typeof(self) weakSelf = self;
        item.didSelectAction = ^(id data) {
            [weakSelf showAlertViewInWindowAction];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"custom View In Window";
        __weak typeof(self) weakSelf = self;
        item.didSelectAction = ^(id data) {
            [weakSelf customViewInWindowAction];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Alert Input Text View";
        item.didSelectAction = ^(id data) {
            WJYAlertInputTextView *inputView = [[WJYAlertInputTextView alloc] initPagesViewWithTitle:@"Alert Input Text View" leftButtonTitle:@"取消" rightButtonTitle:@"确定" placeholderText:@"示例输入"];
            WJYAlertView *alertV = [[WJYAlertView alloc] initWithCustomView:inputView dismissWhenTouchedBackground:YES];
            [alertV show];
            [inputView setLeftBlock:^(NSString *text) {
                [alertV dismissWithCompletion:nil];
            }];
            [inputView setRightBlock:^(NSString *text) {
                [alertV dismissWithCompletion:nil];
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Custom Alert View";
        item.didSelectAction = ^(id data) {
            [WJYAlertView showOneButtonWithTitle:@"Custom Alert View" Message:@"sample message" ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"确定" Click:^{
                NSLog(@"点击确定");
            }];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)colorCellAction:(id)data {
    AFJCaseItemData *item = data;
    NSLog(@"click %@ item", item.title);
}

#pragma mark -

- (void)showAlertViewAction {

    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"AlertView" message:@"This is a message, the alert view containt text and textfiled. "];

    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        NSLog(@"%@", action.title);
    }]];

    // 弱引用alertView 否则 会循环引用
    __typeof(alertView) __weak weakAlertView = alertView;
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {

        NSLog(@"%@", action.title);
        for (UITextField *textField in weakAlertView.textFieldArray) {
            NSLog(@"%@", textField.text);
        }
    }]];

    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入账号";
    }];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入密码";
    }];

    // first way to show
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];

    [alertController setViewWillShowHandler:^(UIView *alertView) {
        NSLog(@"ViewWillShow");
    }];

    [alertController setViewDidShowHandler:^(UIView *alertView) {
        NSLog(@"ViewDidShow");
    }];

    [alertController setViewWillHideHandler:^(UIView *alertView) {
        NSLog(@"ViewWillHide");
    }];

    [alertController setViewDidHideHandler:^(UIView *alertView) {
        NSLog(@"ViewDidHide");
    }];

    [alertController setDismissComplete:^{
        NSLog(@"DismissComplete");
    }];

    //alertController.alertViewOriginY = 60;
    [self presentViewController:alertController animated:YES completion:nil];

    // second way ,use UIView Category
    //[alertView showInController:self preferredStyle:TYAlertControllerStyleAlert];

}

- (void)showActionSheetAction {

    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"AlertView" message:@"This is a message, the alert view style is actionsheet. "];

    [alertView addAction:[TYAlertAction actionWithTitle:@"默认2" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        NSLog(@"%@", action.title);
    }]];

    [alertView addAction:[TYAlertAction actionWithTitle:@"默认1" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        NSLog(@"%@", action.title);
    }]];

    [alertView addAction:[TYAlertAction actionWithTitle:@"删除" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        NSLog(@"%@", action.title);
    }]];

    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)blurEffectAlertViewAction {
    ShareView *shareView = [ShareView createViewFromNib];

    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:shareView preferredStyle:TYAlertControllerStyleAlert];

    // blur effect
    [alertController setBlurEffectWithView:self.view];

    //alertController.alertViewOriginY = 60;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)dropdwonAnimationAction {
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"AlertView" message:@"This is a message, the alert view containt dropdwon animation. "];

    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        NSLog(@"%@", action.title);
    }]];

    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationDropDown];
    [self presentViewController:alertController animated:YES completion:nil];

    // or show,use UIView Category
    //[alertView showInController:self preferredStyle:TYAlertControllerStyleAlert];
}

- (void)costomActonSheetAction {
    // customview from xib
    SettingModelView *settingModelView = [SettingModelView createViewFromNib];

    // fisrt way to show ,use UIView Category
//    [settingModelView showInController:self preferredStyle:TYAlertControllerStyleActionSheet backgoundTapDismissEnable:YES];

    // second way to show
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:settingModelView preferredStyle:TYAlertControllerStyleActionSheet];
    alertController.backgoundTapDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)showAlertViewInWindowAction {

    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"AlertView" message:@"A message should be a short, but it can support long message, hahahhahahahahhahahahahhaahahhahahahahahhahahahahhahahahahahhahahahahahhahahahhahahhahahahahh. (NSTextAlignmentCenter)"];

    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {

    }]];

    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {

    }]];

    // first way to show ,use UIView Category
    [alertView showInWindowWithOriginY:200 backgoundTapDismissEnable:YES];

    // second way to show
    //[TYShowAlertView showAlertViewWithView:alertView originY:200 backgoundTapDismissEnable:YES];
}

- (void)customViewInWindowAction {
    ShareView *shareView = [ShareView createViewFromNib];

    // use UIView Category
    [shareView showInWindow];
}

@end
