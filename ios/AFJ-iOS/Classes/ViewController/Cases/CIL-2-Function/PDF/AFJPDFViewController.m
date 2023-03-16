//
//  AFJPDFViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/20.
//

#import "AFJPDFViewController.h"

#import "AFJCaseItemData.h"
#import "AFJPDFSampleViewController.h"

@interface AFJPDFViewController()



@end

@implementation AFJPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"示例 PDF : 《Swift 教程》";
        item.didSelectAction = ^(id data) {
            AFJPDFSampleViewController *vc = [[AFJPDFSampleViewController alloc] initWithPdfName:@"Swift5.1"];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"示例 PDF : 《Swift 开发者必备 Tips》";
        item.didSelectAction = ^(id data) {
            AFJPDFSampleViewController *vc = [[AFJPDFSampleViewController alloc] initWithPdfName:@"Swifter-Tips"];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
