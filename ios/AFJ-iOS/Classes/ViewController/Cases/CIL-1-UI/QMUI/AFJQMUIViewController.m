//
//  AFJQMUIViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/21.
//

#import "AFJQMUIViewController.h"

#import "AFJCaseItemData.h"
#import "QDUIKitViewController.h"
#import "QDComponentsViewController.h"
#import "QDLabViewController.h"
#import "QDAboutViewController.h"

@interface AFJQMUIViewController()



@end

@implementation AFJQMUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"展示一系列对系统原生控件的拓展的能力";
        item.didSelectAction = ^(id data) {
            QDUIKitViewController *vc = [[QDUIKitViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"展示 QMUI 自己的组件库";
        item.didSelectAction = ^(id data) {
            QDComponentsViewController *vc = [[QDComponentsViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"集合一些非正式但可能很有用的小功能";
        item.didSelectAction = ^(id data) {
            QDLabViewController *vc = [[QDLabViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
