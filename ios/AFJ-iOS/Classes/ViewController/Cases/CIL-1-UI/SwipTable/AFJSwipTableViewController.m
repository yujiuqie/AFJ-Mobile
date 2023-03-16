//
//  AFJSwipTableViewController.m
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/25.
//

#import "AFJSwipTableViewController.h"

#import "AFJCaseItemData.h"
#import "STViewController.h"

@interface AFJSwipTableViewController ()



@end

@implementation AFJSwipTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *dataArray = [NSMutableArray array];

    NSArray *arr1 = @[@{
            @"title": @"SingleOneKindView",
            @"type": @(STControllerTypeNormal),
    },
            @{
                    @"title": @"HybridItemViews",
                    @"type": @(STControllerTypeHybrid),
            },
            @{
                    @"title": @"DisabledBarScroll",
                    @"type": @(STControllerTypeDisableBarScroll),
            },
            @{
                    @"title": @"HiddenNavigationBar",
                    @"type": @(STControllerTypeHiddenNavBar),
            }
    ];

    __weak typeof(self) weakSelf = self;
    for (NSDictionary *dic in arr1) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = dic[@"title"];
        item.type = dic[@"type"];
        item.didSelectAction = ^(id data) {
            [weakSelf cell1Action:data];
        };
        [dataArray addObject:item];
    }

    NSArray *arr2 = @[@{
            @"title": @"遮盖+颜色渐变+segmentView没有弹性 效果",
            @"type": @"ZJVc1Controller",
    },
            @{
                    @"title": @"缩放+颜色渐变 效果",
                    @"type": @"ZJVc1Controller",
            },
            @{
                    @"title": @"滚动条+颜色渐变 效果",
                    @"type": @"ZJVc3Controller",
            },
            @{
                    @"title": @"遮盖+缩放+没有颜色渐变 效果",
                    @"type": @"ZJVc4Controller",
            },
            @{
                    @"title": @"标题不滚动+遮盖+颜色渐变 效果",
                    @"type": @"ZJVc5Controller",
            },
            @{
                    @"title": @"自定义segmentView和contentView位置的效果)",
                    @"type": @"ZJVc6Controller",
            },
            @{
                    @"title": @"可以在初始化或者返回页面的时候设置当前页为其他页",
                    @"type": @"ZJVc7Controller",
            },
            @{
                    @"title": @"更改选中的下标的效果",
                    @"type": @"ZJVc8Controller",
            },
            @{
                    @"title": @"微博&简书个人主页效果",
                    @"type": @"ZJVc9Controller",
            },
            @{
                    @"title": @"显示图片的效果",
                    @"type": @"ZJVc10Controller",
            }
    ];

    for (NSDictionary *dic in arr2) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = dic[@"title"];
        item.type = dic[@"type"];
        item.didSelectAction = ^(id data) {
            [weakSelf cell2Action:data];
        };
        [dataArray addObject:item];
    }

        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)cell1Action:(id)data {
    AFJCaseItemData *item = data;
    NSLog(@"click %@ item", item.title);

    STViewController *demoVC = [[STViewController alloc] init];
    demoVC.type = [item.type intValue];

    [self.navigationController pushViewController:demoVC animated:YES];
}

- (void)cell2Action:(id)data {
    AFJCaseItemData *item = data;
    NSLog(@"click %@ item", item.title);

    UIViewController *demoVC = [[NSClassFromString(item.type) alloc] init];
    [self.navigationController pushViewController:demoVC animated:YES];
}

@end

