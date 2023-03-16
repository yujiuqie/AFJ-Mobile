//
//  AFJCutterViewController.m
//  AFJ-iOS
//
//  Created by viktyz on 2022/9/4.
//

#import "AFJCutterViewController.h"

#import "AFJCaseItemData.h"

@interface AFJCutterViewController ()



@end

@implementation AFJCutterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *dataArray = [NSMutableArray array];

    __weak typeof(self) weakSelf = self;

    for (int i = 0; i < 5; i++) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = [self titleArray][i];
        item.type = [self vcArray][i];
        item.didSelectAction = ^(id data) {
            [weakSelf didClick:data];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)didClick:(AFJCaseItemData *)item {
    UIViewController *vc = [[NSClassFromString(item.type) alloc] init];
    vc.title = item.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)titleArray {
    return @[@"UIViewController截屏-无导航",
            @"UIViewController截屏-有导航",
            @"UITableview截屏",
            @"UICollectionView截屏",
            @"UIWebView截屏"];
}

- (NSArray *)vcArray {
    return @[@"UIViewControllerCutter",
            @"UIViewControllerCutter2",
            @"UITableviewCutter",
            @"UICollectionViewCutter",
            @"UIWebViewCutter"];
}

@end

