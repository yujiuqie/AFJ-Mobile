//
//  AFJVerificationViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/12.
//

#import "AFJVerificationViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <TYAlertController.h>

@interface AFJVerificationViewController ()

@end

@implementation AFJVerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(fingerVerification) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"点击验证" forState:UIControlStateNormal];
    button.frame = CGRectMake((SCREENW - 160) / 2.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

- (void)fingerVerification {
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {

        TYAlertView *alertView = [TYAlertView alertViewWithTitle:nil message:@"ios8.0以后才支持指纹识别"];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
            NSLog(@"%@", action.title);
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
        [self presentViewController:alertController animated:YES completion:nil];

        return;
    }
    //IOS11之后如果支持faceId也是走同样的逻辑，faceId和TouchId只能选一个
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持 localizedReason为alert弹框的message内容
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请验证已有指纹" reply:^(BOOL success, NSError *_Nullable error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (success) {
                    TYAlertView *alertView = [TYAlertView alertViewWithTitle:nil message:@"验证通过"];
                    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
                        NSLog(@"%@", action.title);
                    }]];
                    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
                    [self presentViewController:alertController animated:YES completion:nil];
                } else {
                    switch (error.code) {
                        case LAErrorSystemCancel: {
                            NSLog(@"系统取消授权，如其他APP切入");
                            //系统取消授权，如其他APP切入
                            break;
                        }
                        case LAErrorUserCancel: {
                            //用户取消验证Touch ID
                            NSLog(@"用户取消验证Touch ID");
                            break;
                        }
                        case LAErrorAuthenticationFailed: {
                            //授权失败
                            NSLog(@"授权失败");
                            break;
                        }
                        case LAErrorPasscodeNotSet: {
                            //系统未设置密码
                            NSLog(@"系统未设置密码");
                            break;
                        }
                        case LAErrorBiometryNotAvailable: {
                            //设备Touch ID不可用，例如未打开
                            NSLog(@"设备Touch ID不可用，例如未打开");
                            break;
                        }
                        case LAErrorBiometryNotEnrolled: {
                            //设备Touch ID不可用，用户未录入
                            NSLog(@"设备Touch ID不可用，用户未录入");
                            break;
                        }
                        case LAErrorUserFallback: {
                            NSLog(@"用户选择输入密码，切换主线程处理");
                            break;
                        }
                        default: {
                            //其他情况，切换主线程处理
                            NSLog(@"其他情况，切换主线程处理");
                            break;
                        }
                    }

                    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"验证失败" message:error.description];
                    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
                        NSLog(@"%@", action.title);
                    }]];
                    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }];
        }];
    } else {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"不支持指纹识别" message:error.localizedDescription];
            [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
                NSLog(@"%@", action.title);
            }]];
            TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }
}

@end
