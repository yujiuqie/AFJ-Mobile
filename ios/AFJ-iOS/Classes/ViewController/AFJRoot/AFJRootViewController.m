//
//  AFJRootViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/11.
//

#import "AFJRootViewController.h"
#import "Toast.h"
#import "JXBWebViewController.h"
#import "UIView+TYAlertView.h"
#import "ZJAlertImageView.h"
#import "ZJAnimationPopView.h"
#import "SlideSelectCardView.h"

@interface AFJRootViewController ()

@property(nonatomic, strong) JXBWebViewController *webVC;
@property(nonatomic, strong) ZJAlertImageView *alertView;

@end

@implementation AFJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.product.title;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)showToastWithMessage:(NSString *)message {
    if (message == nil) {
        message = @"";
    }

    [self.view makeToast:message
                duration:2
                position:CSToastPositionCenter];
}

- (void)showAlertWithImage:(UIImage *)image {
    if (!_alertView) {
        self.alertView = [ZJAlertImageView xib];
    }
    self.alertView.imageView.image = image;
    [self showPopAnimationWithAnimationStyle:1];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message complete:(void (^)(NSString *info))handler {
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:title message:message];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        if(handler){
            handler(action.title);
        }
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        if(handler){
            handler(action.title);
        }
    }]];

    [alertView showInController:self];
}

- (void)showInputAlert:(NSString *)title placeholder:(NSString *)placeholder complete:(void (^)(NSString *info))handler {
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:title message:nil];
    __typeof(alertView) __weak weakAlertView = alertView;
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        for (UITextField *textField in weakAlertView.textFieldArray) {
            if (handler) {
                handler([textField.text length] > 0 ? textField.text : textField.placeholder);
            }
            NSLog(@"%@", textField.text);
        }
    }]];

    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeholder ?: @"请输入";
    }];
    [alertView showInController:self];
}

- (void)showInputAlert:(NSString *)title complete:(void (^)(NSString *info))handler {
    [self showInputAlert:title placeholder:nil complete:handler];
}

- (void)jumpToDemo {
    NSLog(@"Jump To %@ Demo", self.product.title);
}

- (void)setupWebViewWith:(NSString *)url {
    if ([url length] == 0) {
        url = self.product.link;
    }
    
    UIBarButtonItem *item = [UIBarButtonItem qmui_itemWithTitle:@"Demo" target:self action:@selector(jumpToDemo)];
    self.navigationItem.rightBarButtonItems = @[item];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.webVC = [[JXBWebViewController alloc] initWithURLRequest:request];
    [self.view addSubview:self.webVC.view];
    self.webVC.view.frame = CGRectMake(0, 88, SCREENW, SCREENH - 88 - 83);
}

- (void)presentWebViewWith:(NSString *)url {
    if ([url length] == 0) {
        url = self.product.link;
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.webVC = [[JXBWebViewController alloc] initWithURLRequest:request];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.webVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showPopAnimationWithAnimationStyle:(NSInteger)style {
    ZJAnimationPopStyle popStyle = (ZJAnimationPopStyle) style;
    ZJAnimationDismissStyle dismissStyle = (ZJAnimationDismissStyle) style;

    // 1.初始化
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:self.alertView popStyle:popStyle dismissStyle:dismissStyle];

    // 2.设置属性，可不设置使用默认值，见注解
    // 2.1 显示时点击背景是否移除弹框
    popView.isClickBGDismiss = ![self.alertView isKindOfClass:[SlideSelectCardView class]];
    // 2.2 显示时背景的透明度
    popView.popBGAlpha = 0.5f;
    // 2.3 显示时是否监听屏幕旋转
    popView.isObserverOrientationChange = YES;
    // 2.4 显示时动画时长
//    popView.popAnimationDuration = 0.8f;
    // 2.5 移除时动画时长
//    popView.dismissAnimationDuration = 0.8f;

    // 2.6 显示完成回调
    popView.popComplete = ^{
        NSLog(@"显示完成");
    };
    // 2.7 移除完成回调
    popView.dismissComplete = ^{
        NSLog(@"移除完成");
    };

    // 3.处理自定义视图操作事件
    [self handleCustomActionEnvent:popView];

    // 4.显示弹框
    // 4.1 弹框的父视图，建议设置为控制器的根视图，不设置则用keyWindow
//    popView.superView = self.view;

    // 显示
    [popView pop];
}

- (void)handleCustomActionEnvent:(ZJAnimationPopView *)popView {
    // 在监听自定义视图的block操作事件时，要使用弱对象来避免循环引用
    __weak typeof(popView) weakPopView = popView;

    self.alertView.canceSureActionBlock = ^(BOOL isSure) {
        [weakPopView dismiss];
        NSLog(@"点击了%@", isSure ? @"确定" : @"取消");
    };
}

@end
