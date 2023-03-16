//
//  AFJStatusBarNotificationViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/24.
//

#import "AFJStatusBarNotificationViewController.h"

#import "AFJCaseItemData.h"
#import "SBExampleViewController.h"
#import "SBNMainViewController.h"

@interface AFJStatusBarNotificationViewController ()



@end

@implementation AFJStatusBarNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"JDStatusBarNotification";
        item.type = @"";
        item.didSelectAction = ^(id data) {
            SBExampleViewController *vc = [[SBExampleViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"CRToast";
        item.type = @"";
        item.didSelectAction = ^(id data) {
            SBNMainViewController *vc = [[SBNMainViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end

