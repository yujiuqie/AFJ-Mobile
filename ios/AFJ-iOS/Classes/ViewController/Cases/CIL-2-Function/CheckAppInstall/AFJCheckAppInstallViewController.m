//
//  AFJCheckAppInstallViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/2.
//

#import "AFJCheckAppInstallViewController.h"

#import "AFJCaseItemData.h"

@interface AFJCheckAppInstallViewController ()



@end

@implementation AFJCheckAppInstallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *dataArray = [NSMutableArray array];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"scheme-list" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    if (error) {
        NSLog(@"scheme list parse error : %@", error);
    }

    __weak typeof(self) weakSelf = self;
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *results = object;
        NSLog(@"scheme list parse success");
        for (NSArray *title in results) {
            AFJCaseItemData *item = [AFJCaseItemData new];
            item.title = title[0];
            for (int i = 1; i < [title count]; i++) {
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:title[i]]]) {
                    item.flag = @"1";
                    item.type = title[i];
                    item.didSelectAction = ^(id data) {
                        [weakSelf colorCellAction:data];
                    };
                    break;
                }
            }
            [dataArray addObject:item];
        }
    } else {
        NSLog(@"product list parse error : %@", object);
    }

        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)colorCellAction:(AFJCaseItemData *)data {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data.type] options:nil completionHandler:^(BOOL success) {
        NSLog(@"打开 %@ 成功", data.title);
    }];
}

@end
