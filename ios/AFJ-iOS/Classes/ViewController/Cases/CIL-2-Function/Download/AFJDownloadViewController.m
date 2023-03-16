//
//  AFJDownloadViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/7.
//

#import "AFJDownloadViewController.h"

#import "AFJCaseItemData.h"
#import "DownLoadViewController.h"
#import "ShowViewController.h"

@interface AFJDownloadViewController ()



@end

@implementation AFJDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"测试断点续传";
        item.didSelectAction = ^(id data) {
            DownLoadViewController *zfVC = [[DownLoadViewController alloc] init];
            [weakSelf.navigationController pushViewController:zfVC animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"测试多并发";
        item.didSelectAction = ^(id data) {
            ShowViewController *vc = [[ShowViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end

