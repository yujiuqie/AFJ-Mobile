//
//  AFJFlutterViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/27.
//

#import "AFJFlutterViewController.h"
#import <Flutter/Flutter.h>
#import "AFJFlutterUnitViewController.h"
#import "AFJFlutterMessageViewController.h"

@interface AFJFlutterViewController ()

@end

@implementation AFJFlutterViewController

- (void)initDataSource{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Flutter、iOS 通信示例";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            AFJFlutterMessageViewController *viewController = [[AFJFlutterMessageViewController alloc] init];
            viewController.title = product.title;
            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [dataArray addObject:item];
    }
    
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Flutter 官方示例";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
//            AFJFlutterMessageViewController *viewController = [[AFJFlutterMessageViewController alloc] init];
//            viewController.title = product.title;
//            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [dataArray addObject:item];
    }
    
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"三方 - FlutterUnit";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            AFJFlutterUnitViewController *viewController = [[AFJFlutterUnitViewController alloc] init];
            viewController.title = product.title;
            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [dataArray addObject:item];
    }
    
    self.dataSource = dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Flutter";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

@end
