//
//  AFJTimerViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/6.
//

#import "AFJTimerViewController.h"

#import "AFJCaseItemData.h"
#import "AFJCountDownViewController.h"
//#import "NSString+HXExtension.h"

@interface AFJTimerViewController ()



@end

@implementation AFJTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"将时间戳转换成时间";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"将时间戳转换成时间" placeholder:@"1218196800" complete:^(NSString *_Nonnull info) {
                //TODO:: remove YYKit
//                if ([info length] > 0) {
//                    [weakSelf showToastWithMessage:[NSString changeTimeStampToTime:info]];
//                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"将时间转换成时间戳";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"将时间转换成时间戳" placeholder:@"2008-08-08 20:00:00" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    [weakSelf showToastWithMessage:[NSString stringWithFormat:@"将时间转换成时间戳: %@", [FHXHelp timeStringIntoTimeStamp:info]]];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"通过时间字符串获取年、月、日";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"通过时间字符串获取年、月、日" placeholder:@"2008-08-08" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    [weakSelf showToastWithMessage:[NSString stringWithFormat:@"通过时间字符串获取年、月、日: %@", [FHXHelp getYearAndMonthAndDayFromTimeString:info]]];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"获取今天、明天的日期";
        item.didSelectAction = ^(id data) {
            [weakSelf showToastWithMessage:[NSString stringWithFormat:@"获取今天、明天、后天的日期:  %@", [FHXHelp timeForTheRecentDate]]];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"获取当前的时间";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"获取当前的时间" placeholder:@"YYYY-MM-dd hh:mm:ss" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    [weakSelf showToastWithMessage:[Time getCurrentTimesWithType:info]];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"获取当前时间戳（秒)";
        item.didSelectAction = ^(id data) {
            [weakSelf showToastWithMessage:[Time getNowTimeTimestampaSecondA]];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"获取当前时间戳(毫秒)";
        item.didSelectAction = ^(id data) {
            [weakSelf showToastWithMessage:[Time getNowTimeTimestampMillisecond]];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"倒计时示例";
        item.didSelectAction = ^(id data) {
            AFJCountDownViewController *cdVC = [[AFJCountDownViewController alloc] init];
            [weakSelf.navigationController pushViewController:cdVC animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"获取时间区间";
        item.didSelectAction = ^(id data) {
            [SelectTimeAreaViewItem SelectTimeAreaViewItemConfirm:^(NSString *startStr, NSString *endStr) {
                NSLog(@"startStr - %@,endStr - %@", startStr, endStr);
                [weakSelf showToastWithMessage:[NSString stringWithFormat:@"start : %@ - end : %@", startStr, endStr]];
            }                                              cancel:^{
                NSLog(@"取消");
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"弹出框选择日期（月）";
        item.didSelectAction = ^(id data) {
            [FHXSelectDateViewItem SelectDateViewItemWithShowDateType:showDateTypeMonth Confirm:^(NSString *dateStr) {
                [weakSelf showToastWithMessage:dateStr];
            }                                                  cancel:nil];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"弹出框选择日期（日）";
        item.didSelectAction = ^(id data) {
            [FHXSelectDateViewItem SelectDateViewItemWithShowDateType:showDateTypeDay Confirm:^(NSString *dateStr) {
                [weakSelf showToastWithMessage:dateStr];
            }                                                  cancel:nil];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"弹出框选择日期（时）";
        item.didSelectAction = ^(id data) {
            [FHXSelectDateViewItem SelectDateViewItemWithShowDateType:showDateTypeHour Confirm:^(NSString *dateStr) {
                [weakSelf showToastWithMessage:dateStr];
            }                                                  cancel:nil];
        };
        [dataArray addObject:item];
    }

        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
