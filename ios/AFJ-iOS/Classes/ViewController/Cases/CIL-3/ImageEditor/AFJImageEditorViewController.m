//
//  AFJImageEditorViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/20.
//

#import "AFJImageEditorViewController.h"

#import "AFJCaseItemData.h"
#import "AFJImageSampleViewController.h"
#import "AFJPasterImageViewController.h"

@interface AFJImageEditorViewController()



@end

@implementation AFJImageEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"CLImageEditor";
        item.didSelectAction = ^(id data) {
            AFJImageSampleViewController *vc = [[AFJImageSampleViewController alloc] initWithNibName:@"AFJImageSampleViewController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"图像处理(滤镜、标签、贴纸)";
        item.didSelectAction = ^(id data) {
            AFJPasterImageViewController *vc = [[AFJPasterImageViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
