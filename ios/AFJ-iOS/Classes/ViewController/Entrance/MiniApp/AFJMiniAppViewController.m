//
//  AFJMiniAppViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/29.
//

#import "AFJMiniAppViewController.h"
#import <FinApplet/FinApplet.h>

@interface AFJMiniAppViewController ()

@end

@implementation AFJMiniAppViewController

- (void)initDataSource{
    NSMutableArray *dataArray = [NSMutableArray array];

    NSArray *array = @[
            @[@"FinClip 小程序"]
    ];

    __weak typeof(self) weakSelf = self;
    for (NSArray *arr in array) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = [arr firstObject];
        item.didSelectAction = ^(id data) {
            [weakSelf jumpToFinClipDemo];
        };
        [dataArray addObject:item];
    }
    
    self.dataSource = dataArray;
}

- (void)viewDidLoad {
    
    self.navigationItem.title = @"Mini App";
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)jumpToFinClipDemo {
    FATAppletRequest *request = [[FATAppletRequest alloc] init];
    request.appletId = @"630c7a8b73a4600001ead50a";
    request.apiServer = @"https://api.finclip.com";
    request.transitionStyle = FATTranstionStyleUp;
    request.startParams = @{@"test key": @"test value"};

    [[FATClient sharedClient] startAppletWithRequest:request InParentViewController:self completion:^(BOOL result, FATError *error) {
        NSLog(@"打开小程序:%@", error);
    }                                closeCompletion:^{
        NSLog(@"关闭小程序");
    }];
}


@end
