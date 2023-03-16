//
//  AFJLoginRegistViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/8.
//

#import "AFJLoginRegistViewController.h"
#import "SUPRegisterViewController.h"
#import "AFJLoginSampleViewController.h"

@interface AFJLoginRegistViewController ()



@end

@implementation AFJLoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"登录示例";
        item.didSelectAction = ^(id data) {
            AFJLoginSampleViewController *vc = [[AFJLoginSampleViewController alloc] init];
            [weakSelf presentViewController:vc animated:YES completion:nil];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"注册示例";
        item.didSelectAction = ^(id data) {
            SUPRegisterViewController *vc = [[SUPRegisterViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [weakSelf presentViewController:nav animated:YES completion:nil];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end

