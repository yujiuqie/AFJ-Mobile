//
//  AFJHelpViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/3.
//

#import "AFJHelpViewController.h"

#import "AFJCaseItemData.h"
#import "FHXHelp.h"

@interface AFJHelpViewController ()



@end

@implementation AFJHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"拨打电话";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"拨打电话" placeholder:@"18501791217" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    [FHXHelp makePhoneCallWithTelNumber:info];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"判断运营商(本地 API 判断)";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"判断运营商(本地 API 判断)" placeholder:@"18501791217" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    [weakSelf showToastWithMessage:[NSString stringWithFormat:@"%@", [FHXHelp judgePhoneNumTypeOfMobileNum:info]]];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"判断运营商(远程 API 判断)";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"判断运营商(远程 API 判断)" placeholder:@"18501791217" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    [BaseNetWork getNoHeaderWithUrl:@"http://apis.juhe.cn/mobile/get"
                                              parms:@{
                                                      @"key": @"eb94698d6a502e575238857c9b257cba",
                                                      @"phone": info
                                              }
                                            success:^(id _Nonnull json) {
                                                NSLog(@"%@", json);
                                                [self showToastWithMessage:[NSString stringWithFormat:@"%@", json]];
                                            }
                                           failture:^(id _Nonnull json) {
                                               NSLog(@"%@", json);
                                               [self showToastWithMessage:[NSString stringWithFormat:@"%@", json]];
                                           }];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"去掉 HTML 中的标签（<title>Title</title>）";
        item.didSelectAction = ^(id data) {
            [weakSelf showToastWithMessage:[FHXHelp stringRemovetheHTMLtags:@"<title>Title</title>"]];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"生成随机数 n 到 m";
        item.didSelectAction = ^(id data) {
            [weakSelf showToastWithMessage:[NSString stringWithFormat:@"%d", [FHXHelp getRandomNumber:1 to:10]]];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"数组去重";
        item.didSelectAction = ^(id data) {
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:30];
            [arr addObject:@"1"];
            [arr addObject:@"1"];
            [arr addObject:@"2"];
            [arr addObject:@"2"];
            [arr addObject:@"3"];
            NSLog(@"数组去重： %@", [FHXHelp arrayWithMemberIsOnly:arr]);
            [weakSelf showToastWithMessage:[NSString stringWithFormat:@"数组去重： %@", [FHXHelp arrayWithMemberIsOnly:arr]]];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"格式化千分位";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"格式化千分位" placeholder:@"123456789" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    [weakSelf showToastWithMessage:[NSString stringWithFormat:@"千分位: %@", [FHXHelp positiveFormat:info]]];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"向下抹零（不四舍五入）";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"向下抹零（不四舍五入）" placeholder:@"1.9999" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    [weakSelf showToastWithMessage:[NSString stringWithFormat:@"向下抹零（不四舍五入）: %@", [FHXHelp notRounding:[info floatValue] afterPoint:2]]];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"手机号空格格式";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"手机号空格格式" placeholder:@"17623372625" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    [weakSelf showToastWithMessage:[NSString stringWithFormat:@"手机号空格格式: %@", [FHXHelp becomePhoneNumTypeWithNSString:info]]];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"银行卡空格格式";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"银行卡空格格式" placeholder:@"6230521450003856576" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    [weakSelf showToastWithMessage:[NSString stringWithFormat:@"银行卡空格格式: %@", [FHXHelp jointBlankWithString:info]]];
                }
            }];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
