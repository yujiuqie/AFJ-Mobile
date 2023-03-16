//
//  AFJMotionBlurController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/24.
//

#import "AFJMotionBlurController.h"

#import "AFJCaseItemData.h"
#import "AFJMotionBluSamplerController.h"

@interface AFJMotionBlurController()



@end

@implementation AFJMotionBlurController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"运动模糊效果";
        item.didSelectAction = ^(id data) {
            AFJMotionBluSamplerController *vc = [[AFJMotionBluSamplerController alloc] initWithNibName:@"AFJMotionBluSamplerController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end

