//
//  AFJPaySampleViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/14.
//

#import "AFJPaySampleViewController.h"
#import "HQLConst.h"
#import "HQLPasswordView.h"
// Controller
#import "HQLOrderTableViewController.h" // 订单示例页面
//#import "HQLWeChatPayViewController.h" // 微信支付
//#import "HQLAlipayViewController.h" // 支付宝原生支付
//#import "HQLAlipayWebViewController.h" // 支付宝 H5 支付
//#import "HQLICBCPayViewController.h" // 工行e支付
#import "AFJIAPStoreViewController.h"
#import "AFJApplePayViewController.h"

static const CGFloat kRequestTime = 3.0f;
static const CGFloat KDelay = 2.0f;

@interface AFJPaySampleViewController ()


@property(nonatomic, strong) HQLPasswordView *passwordView;

@end

@implementation AFJPaySampleViewController

static BOOL flag = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"输入支付密码示例";
        item.didSelectAction = ^(id data) {
            [weakSelf paymentButtonDidClicked];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"订单页面示例";
        item.didSelectAction = ^(id data) {
            // 订单示例页面
            HQLOrderTableViewController *payViewController = [[HQLOrderTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:payViewController animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"微信支付示例";
        item.didSelectAction = ^(id data) {
            // 微信支付
//            HQLWeChatPayViewController *weChatPayViewController = [[HQLWeChatPayViewController alloc] init];
//            [self.navigationController pushViewController:weChatPayViewController animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"支付宝原生支付示例";
        item.didSelectAction = ^(id data) {
            // 支付宝原生支付
//            HQLAlipayViewController *alipayViewController = [[HQLAlipayViewController alloc] init];
//            [self.navigationController pushViewController:alipayViewController animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"支付宝 H5 支付示例";
        item.didSelectAction = ^(id data) {
            // 支付宝H5支付
//            HQLAlipayWebViewController *alipayWebViewController = [[HQLAlipayWebViewController alloc] init];
//            [self.navigationController pushViewController:alipayWebViewController animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"工商银行支付示例";
        item.didSelectAction = ^(id data) {
            // 工商银行
//            HQLICBCPayViewController *icbcPayViewController = [[HQLICBCPayViewController alloc] init];
//            [self.navigationController pushViewController:icbcPayViewController animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"苹果支付示例";
        item.didSelectAction = ^(id data) {
            // 工商银行
            AFJApplePayViewController *vc = [[AFJApplePayViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"苹果内购示例";
        item.didSelectAction = ^(id data) {
            // 工商银行
            AFJIAPStoreViewController *vc = [[AFJIAPStoreViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)paymentButtonDidClicked {

    self.passwordView = [[HQLPasswordView alloc] init];
    [self.passwordView showInView:self.view.window];
    self.passwordView.title = @"我是标题";
    self.passwordView.loadingText = @"正在支付中...";
    self.passwordView.closeBlock = ^{
        NSLog(@"取消支付回调...");
    };
    self.passwordView.forgetPasswordBlock = ^{
        NSLog(@"忘记密码回调...");
    };
    WS(weakself);
    self.passwordView.finishBlock = ^(NSString *password) {
        NSLog(@"完成支付回调...");

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (kRequestTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            flag = !flag;
            if (flag) {
                // 购买成功，跳转到成功页
                [weakself.passwordView requestComplete:YES message:@"购买成功"];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (KDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // 从父视图移除密码输入视图
                    [weakself.passwordView removePasswordView];
                });
            } else {
                // 购买失败，跳转到失败页
                [weakself.passwordView requestComplete:NO];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (KDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // 购买失败的处理，也可以继续支付

                });
            }
        });
    };
}

@end
