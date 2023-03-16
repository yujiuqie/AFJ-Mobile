//
//  AFJIMViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/27.
//

#import "AFJIMViewController.h"
#import "ClientCoreSDK.h"
#import "IMLoginViewController.h"
#import "IMClientManager.h"

@interface AFJIMViewController ()

@property(nonatomic, strong) IMLoginViewController *loginViewController;

@end

@implementation AFJIMViewController

static AFJIMViewController *__onetimeClass;

+ (AFJIMViewController *)sharedIMViewController {
    static dispatch_once_t oneToken;

    dispatch_once(&oneToken, ^{

        __onetimeClass = [[AFJIMViewController alloc] init];

    });
    return __onetimeClass;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // init MobileIMSDK first
    // 提示：在不退出APP的情况下退出登陆后再重新登陆时，请确保调用本方法一次，不然会报code=203错误哦！
    [self switchToLoginViewController];
}

- (void)switchToLoginViewController {
    [[IMClientManager sharedInstance] initMobileIMSDK];

    if (self.loginViewController == nil) {
        self.loginViewController = [[IMLoginViewController alloc] initWithNibName:@"IMLoginViewController" bundle:nil];
    }

    [self.viewController.view removeFromSuperview];
    [self.view addSubview:self.loginViewController.view];
    self.loginViewController.view.frame = CGRectMake(0, StatusBarAndNavigationBarHeight, SCREENW, SCREENH - StatusBarAndNavigationBarHeight - TabbarHeight);
}

- (void)switchToMainViewController {
    if (self.viewController == nil) {
        self.viewController = [[IMMainViewController alloc] initWithNibName:@"IMMainViewController" bundle:nil];
    }

    [self.loginViewController.view removeFromSuperview];
    [self.view addSubview:self.viewController.view];
    self.viewController.view.frame = CGRectMake(0, StatusBarAndNavigationBarHeight, SCREENW, SCREENH - StatusBarAndNavigationBarHeight - TabbarHeight);
}

- (UIView *)getMainView {
    return self.viewController.view;
}

- (IMMainViewController *)getMainViewController {
    return self.viewController;
}

- (void)refreshConnecteStatus {
    [self.viewController refreshConnecteStatus];
}

@end
