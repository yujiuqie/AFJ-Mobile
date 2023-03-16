//
//  AFJFileManagerViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/14.
//

#import "AFJFileManagerViewController.h"

#import "AFJCaseItemData.h"
#import "HQLSandBoxPathViewController.h"
#import "HQLConvertPathViewController.h"
#import "HQLFileBasicUsageViewController.h"
#import "HQLFIleManagerUsuallyMethodViewController.h"

@interface AFJFileManagerViewController ()



@end

@implementation AFJFileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"沙盒目录路径示例";
        item.didSelectAction = ^(id data) {
            HQLSandBoxPathViewController *vc = [[HQLSandBoxPathViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"路径类型转换";
        item.didSelectAction = ^(id data) {
            HQLConvertPathViewController *vc = [[HQLConvertPathViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"复制、移动、删除、枚举";
        item.didSelectAction = ^(id data) {
            HQLFileBasicUsageViewController *vc = [[HQLFileBasicUsageViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"常用操作";
        item.didSelectAction = ^(id data) {
            HQLFIleManagerUsuallyMethodViewController *vc = [[HQLFIleManagerUsuallyMethodViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
