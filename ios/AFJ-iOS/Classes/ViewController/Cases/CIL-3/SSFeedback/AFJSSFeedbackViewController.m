//
//  AFJSSFeedbackViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/23.
//

#import "AFJSSFeedbackViewController.h"

#import "AFJCaseItemData.h"

@interface AFJSSFeedbackViewController()



@end

@implementation AFJSSFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"截屏反馈";
        item.didSelectAction = ^(id data) {

        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
