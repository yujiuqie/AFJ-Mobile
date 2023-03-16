//
//  AFJDateToolsViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/24.
//

#import "AFJDateToolsViewController.h"

#import "AFJCaseItemData.h"
#import "DateToolsViewController.h"
#import "TimePeriodsViewController.h"

@interface AFJDateToolsViewController()



@end

@implementation AFJDateToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"NSDate+DateTools";
        item.didSelectAction = ^(id data) {
            DateToolsViewController *vc = [[DateToolsViewController alloc] initWithNibName:@"DateToolsViewController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Time Periods";
        item.didSelectAction = ^(id data) {
            TimePeriodsViewController *vc = [[TimePeriodsViewController alloc] initWithNibName:@"TimePeriodsViewController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end

