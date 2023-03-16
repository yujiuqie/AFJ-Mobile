//
//  AFJBluetoothViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/23.
//

#import "AFJBluetoothViewController.h"

#import "AFJCaseItemData.h"
#import "AFJBTCentralModeViewController.h"
#import "AFJBTPeripheralModeViewController.h"

@interface AFJBluetoothViewController()



@end

@implementation AFJBluetoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"中心模式（central model）使用示例";
        item.didSelectAction = ^(id data) {
            AFJBTCentralModeViewController *vc = [[AFJBTCentralModeViewController alloc] initWithNibName:@"AFJBTCentralModeViewController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"外设模式（peripheral model）使用示例";
        item.didSelectAction = ^(id data) {
            AFJBTPeripheralModeViewController *vc = [[AFJBTPeripheralModeViewController alloc] initWithNibName:@"AFJBTPeripheralModeViewController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
