//
//  AFJTableViewCellViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/22.
//

#import "AFJTableViewCellViewController.h"

#import "AFJCaseItemData.h"
#import "AFJSampleCell1ViewController.h"

@interface AFJTableViewCellViewController()



@end

@implementation AFJTableViewCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Cell 菜单样式一";
        item.didSelectAction = ^(id data) {
            AFJSampleCell1ViewController *vc = [[AFJSampleCell1ViewController alloc] initWithNibName:@"AFJSampleCell1ViewController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
