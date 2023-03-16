//
//  AFJMoreViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/11.
//

#import "AFJMoreViewController.h"

@interface AFJMoreViewController ()

@end

@implementation AFJMoreViewController

-(void)initDataSource{
    NSMutableArray *dataArray = [NSMutableArray array];

    NSArray *array = @[
        @[@"小程序",@"AFJMiniAppViewController"],
        @[@"H5",@"AFJWebKitViewController"],
        @[@"设备信息", @""],
        @[@"软件信息", @""],
        @[@"设备日志", @"AFJLogViewController"],
        @[@"TODO::", @""],
    ];

    __weak typeof(self) weakSelf = self;
    for (NSArray *arr in array) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = [arr firstObject];
        item.type = [arr lastObject];
        item.didSelectAction = ^(id data) {
            [weakSelf colorCellAction:data];
        };
        [dataArray addObject:item];
    }
    
    self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"More";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)colorCellAction:(id)data {
    AFJCaseItemData *item = data;
    NSLog(@"click %@ item", item.title);

    UIViewController *vc = [[NSClassFromString(item.type) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
