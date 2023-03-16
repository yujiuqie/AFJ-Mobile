//
//  AFJConnectionViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/22.
//

#import "AFJConnectionViewController.h"

#import "AFJCaseItemData.h"
#import "AFJPeerTalkSampleViewController.h"

@interface AFJConnectionViewController()



@end

@implementation AFJConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"PeerTalk 示例";
        item.didSelectAction = ^(id data) {
            AFJPeerTalkSampleViewController *vc = [[AFJPeerTalkSampleViewController alloc] initWithNibName:@"AFJPeerTalkSampleViewController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
