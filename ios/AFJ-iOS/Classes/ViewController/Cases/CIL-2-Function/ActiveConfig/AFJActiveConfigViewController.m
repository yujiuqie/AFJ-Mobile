//
//  AFJActiveConfigViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/18.
//

#import "AFJActiveConfigViewController.h"

#import "AFJCaseItemData.h"

@interface AFJActiveConfigViewController ()



@end

@implementation AFJActiveConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"AB Test 示例";
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"更新 AB Test 配置";
        item.type = @"MSSettingsViewController";
        __weak typeof(self) weakSelf = self;
        item.didSelectAction = ^(id data) {
            [weakSelf colorCellAction:data];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"应用 AB Test 配置";
        item.type = @"MSSampleViewController";
        __weak typeof(self) weakSelf = self;
        item.didSelectAction = ^(id data) {
            [weakSelf colorCellAction:data];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)colorCellAction:(id)data {
    AFJCaseItemData *item = data;
    NSLog(@"click %@ item", item.title);

    UIViewController *vc = [[NSClassFromString(item.type) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
