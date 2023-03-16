//
//  AFJColorViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/15.
//

#import "AFJColorViewController.h"
#import "AFJCollectionViewController.h"
#import "TableViewController.h"

@interface AFJColorViewController ()



@end

@implementation AFJColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Collection Viewer";
        item.didSelectAction = ^(id data) {
            AFJCollectionViewController *vc = [[AFJCollectionViewController alloc] initWithNibName:@"AFJCollectionViewController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Table List Viewer";
        item.didSelectAction = ^(id data) {
            TableViewController *vc = [[TableViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end

