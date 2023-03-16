//
//  AFJBarrageViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/17.
//

#import "AFJBarrageViewController.h"

#import "AFJCaseItemData.h"
#import "VideoDemoViewController.h"
#import "LiveDemoViewController.h"

@interface AFJBarrageViewController()



@end

@implementation AFJBarrageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"VideoMode";
        item.didSelectAction = ^(id data) {
            VideoDemoViewController *vc = [[VideoDemoViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"LiveMode";
        item.didSelectAction = ^(id data) {
            LiveDemoViewController *vc = [[LiveDemoViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
