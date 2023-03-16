//
//  AFJTextFieldViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/15.
//

#import "AFJTextFieldViewController.h"

#import "AFJCaseItemData.h"
// Controller
#import "HQLTextFieldBasicUsageViewController.h"
#import "HQLCodeResignViewController.h"
#import "HQLFloatLabelTextFieldViewController.h"

@interface AFJTextFieldViewController ()



@end

@implementation AFJTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"基础用法";
        item.didSelectAction = ^(id data) {
            // UITextField 基础使用
            HQLTextFieldBasicUsageViewController *vc = [[HQLTextFieldBasicUsageViewController alloc] init];
            vc.title = @"基础用法";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"输入验证码";
        item.didSelectAction = ^(id data) {
            // 输入验证码
            HQLCodeResignViewController *vc = [[HQLCodeResignViewController alloc] init];
            vc.title = @"输入验证码";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"JVFloatLabeledTextField 使用示例";
        item.didSelectAction = ^(id data) {
            // JVFloatLabeledTextField 使用示例
            HQLFloatLabelTextFieldViewController *vc = [[HQLFloatLabelTextFieldViewController alloc] init];
            vc.title = @"JVFloatLabeledTextField 使用示例";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }

        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end

