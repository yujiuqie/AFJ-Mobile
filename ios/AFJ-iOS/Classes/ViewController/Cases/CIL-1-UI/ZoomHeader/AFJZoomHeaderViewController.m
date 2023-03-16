//
//  AFJZoomHeaderViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/26.
//

#import "AFJZoomHeaderViewController.h"

#import "AFJCaseItemData.h"
#import "TableViewExampleVC.h"
#import "CollectionViewExampleVC.h"

@interface AFJZoomHeaderViewController()



@end

@implementation AFJZoomHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"TableViewExample";
        item.didSelectAction = ^(id data) {
            TableViewExampleVC *vc = [[TableViewExampleVC alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"CollectionViewExample";
        item.didSelectAction = ^(id data) {
            CollectionViewExampleVC *vc = [[CollectionViewExampleVC alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
