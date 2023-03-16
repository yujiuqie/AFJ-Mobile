//
//  AFJARViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/17.
//

#import "AFJARViewController.h"

#import "AFJCaseItemData.h"
#import "ARViewController.h"

@interface AFJARViewController()



@end

@implementation AFJARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"AR 示例";
        item.didSelectAction = ^(id data) {
            ARViewController *vc = [[ARViewController alloc] initWithNibName:@"ARViewController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
