//
//  AFJLabelViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/5.
//

#import "AFJLabelViewController.h"
#import "AFJLabelSampleViewController.h"
//#import "AFJLabelSample2ViewController.h"
// Controllers
#import "LabelBasicUsageViewController.h"
#import "LabelCornerBorderViewController.h"
#import "LabelAttributesViewController.h"
#import "HQLSystemFontViewController.h"
#import "HQLSystemFontWeightViewController.h"

@interface AFJLabelViewController ()



@end

@implementation AFJLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"基础用法";
        item.didSelectAction = ^(id data) {
            // 基础用法
            LabelBasicUsageViewController *vc = [[LabelBasicUsageViewController alloc] init];
            vc.title = @"基础用法";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"间距及纵向排列";
        item.didSelectAction = ^(id data) {
            AFJLabelSampleViewController *sampleVC = [[AFJLabelSampleViewController alloc] init];
            [weakSelf.navigationController pushViewController:sampleVC animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"富文本样式展示";
        item.didSelectAction = ^(id data) {
//            AFJLabelSample2ViewController *sampleVC = [[AFJLabelSample2ViewController alloc] init];
//            [weakSelf.navigationController pushViewController:sampleVC animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"圆角和边框";
        item.didSelectAction = ^(id data) {
            // 圆角和边框
            LabelCornerBorderViewController *vc = [[LabelCornerBorderViewController alloc] init];
            vc.title = @"圆角和边框";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"属性字符串";
        item.didSelectAction = ^(id data) {
            // 属性字符串
            LabelAttributesViewController *vc = [[LabelAttributesViewController alloc] init];
            vc.title = @"属性字符串";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"查看系统所有字体";
        item.didSelectAction = ^(id data) {
            // 查看系统所有字体
            HQLSystemFontViewController *vc = [[HQLSystemFontViewController alloc] init];
            vc.title = @"查看系统所有字体";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"系统字重";
        item.didSelectAction = ^(id data) {
            // 系统字重
            HQLSystemFontWeightViewController *vc = [[HQLSystemFontWeightViewController alloc] init];
            vc.title = @"系统字重";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
//    {
//        AFJCaseItemData *item = [AFJCaseItemData new];
//        item.title = @"YYLabel 框架";
//        item.didSelectAction = ^(id data) {
//            // YYLabel 框架
//            HQLYYLabelTestViewController *vc = [[HQLYYLabelTestViewController alloc] init];
//            vc.title = @"YYLabel 框架";
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        };
//        [dataArray addObject:item];
//    }


        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end

