//
//  AFJEmptyViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/15.
//

#import "AFJEmptyViewController.h"
#import "AFJEmptyDetailTableViewController.h"
#import "Application.h"
#import "UIColor+Hexadecimal.h"
#import "UIScrollView+EmptyDataSet.h"

@interface AFJEmptyViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) NSArray *applications;



@end

@implementation AFJEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];

    for (int i = 1; i <= 8; i++) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = [NSString stringWithFormat:@"示例 %d", i];
        item.didSelectAction = ^(id data) {
            UITableViewController *vc = [[NSClassFromString([NSString stringWithFormat:@"HQLEmptyDataSetExample%d", i]) alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"applications" ofType:@"json"];
    self.applications = [Application applicationsFromJSONAtPath:path];
    
    for (Application *obj in _applications) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = obj.displayName;
        item.didSelectAction = ^(id data) {
            AFJEmptyDetailTableViewController *vc = [[AFJEmptyDetailTableViewController alloc] initWithApplication:obj];
            vc.applications = weakSelf.applications;
            vc.allowShuffling = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end

