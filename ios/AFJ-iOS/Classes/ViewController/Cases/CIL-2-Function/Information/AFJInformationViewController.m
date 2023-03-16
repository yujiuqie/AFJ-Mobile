//
//  AFJInformationViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/2.
//

#import "AFJInformationViewController.h"

#import "AFJCaseItemData.h"
#import "Config.h"
#import "JXBWebViewController.h"
#import "AFJBasicDeviceViewController.h"
#import "GBDeviceInfo.h"
#import "Jailbreak.h"
#import "ScreenObject.h"

@interface AFJInformationViewController ()



@end

@implementation AFJInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"是否刘海屏";
        NSString *info = [ScreenObject isNotchScreen] ? @"YES" : @"NO";
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"是否越狱";
        NSString *info = [Jailbreak isJailBreak] ? @"YES" : @"NO";
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"Bundle ID";
        NSString *info = [Config getBundleIdentifier];
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"App 名称";
        NSString *info = [Config getAppName];
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"App 版本";
        NSString *info = [Config getAppVersion];
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"Build No.";
        NSString *info = [Config getAppBuildVersion];
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"设备名称";
        NSString *info = [Config getAppAliasName];
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"设备系统";
        NSString *info = [Config getSystemName];
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"设备系统版本";
        NSString *info = [Config getSystemVersion];
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"设备品牌";
        NSString *info = [Config getLocalizedModel];
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        NSArray *languageArray = [NSLocale preferredLanguages];
        NSString *language = [languageArray objectAtIndex:0];
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"语言";
        NSString *info = language;
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        NSLocale *locale = [NSLocale currentLocale];
        NSString *country = [locale localeIdentifier];
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"国家";
        NSString *info = country;
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        CGRect rect = [[UIScreen mainScreen] bounds];
        CGSize size = rect.size;
        CGFloat width = size.width;
        CGFloat height = size.height;
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"屏幕尺寸";
        NSString *info = [NSString stringWithFormat:@"宽、高：%.1f,%.1f", width, height];
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        CGFloat scale_screen = [UIScreen mainScreen].scale;
        CGRect rect = [[UIScreen mainScreen] bounds];
        CGSize size = rect.size;
        CGFloat width = size.width;
        CGFloat height = size.height;
        NSLog(@"screen w:%f", width * scale_screen);
        NSLog(@"screen h:%f", height * scale_screen);
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"分辨率";
        NSString *info = [NSString stringWithFormat:@"screen w:%.1f,screen h:%.1f", width * scale_screen, height * scale_screen];
        item.title = [NSString stringWithFormat:@"%@ : %@", title, info];
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        NSString *title = @"设备型号";
        NSString *info = [Config getCurrentDeviceModel];
        item.title = [NSString stringWithFormat:@"%@ : %@ （点击查看更多）", title, info];
        item.didSelectAction = ^(id data) {
            JXBWebViewController *webVC = [[JXBWebViewController alloc] initWithURLString:@"https://www.theiphonewiki.com/wiki/Models"];
            [self.navigationController pushViewController:webVC animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"硬件信息（点击查看更多）";
        item.didSelectAction = ^(id data) {
            AFJBasicDeviceViewController *basicVC = [[AFJBasicDeviceViewController alloc] initWithType:BasicInfoTypeHardWare];
            [weakSelf.navigationController pushViewController:basicVC animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"电池信息（点击查看更多）";
        item.didSelectAction = ^(id data) {
            AFJBasicDeviceViewController *basicVC = [[AFJBasicDeviceViewController alloc] initWithType:BasicInfoTypeBattery];
            [weakSelf.navigationController pushViewController:basicVC animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"地址信息（点击查看更多）";
        item.didSelectAction = ^(id data) {
            AFJBasicDeviceViewController *basicVC = [[AFJBasicDeviceViewController alloc] initWithType:BasicInfoTypeIpAddress];
            [weakSelf.navigationController pushViewController:basicVC animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"CPU 信息（点击查看更多）";
        item.didSelectAction = ^(id data) {
            AFJBasicDeviceViewController *basicVC = [[AFJBasicDeviceViewController alloc] initWithType:BasicInfoTypeCPU];
            [weakSelf.navigationController pushViewController:basicVC animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"磁盘信息（点击查看更多）";
        item.didSelectAction = ^(id data) {
            AFJBasicDeviceViewController *basicVC = [[AFJBasicDeviceViewController alloc] initWithType:BasicInfoTypeDisk];
            [weakSelf.navigationController pushViewController:basicVC animated:YES];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"GBDeviceInfo（点击查看更多）";
        item.didSelectAction = ^(id data) {
            GBDeviceInfo *info = [[GBDeviceInfo alloc] init];
            [weakSelf showToastWithMessage:info.description];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
