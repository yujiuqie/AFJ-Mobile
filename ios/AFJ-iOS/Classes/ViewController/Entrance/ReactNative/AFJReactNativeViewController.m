//
//  AFJReactNativeViewController.m
//  AFJ-iOS
//
//  Created by alfred on 2023/3/16.
//

#import "AFJReactNativeViewController.h"
#import "AFJKittenTricksViewController.h"

@interface AFJReactNativeViewController ()

@end

@implementation AFJReactNativeViewController

- (void)initDataSource{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"KittenTricks";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            AFJKittenTricksViewController *viewController = [[AFJKittenTricksViewController alloc] init];
            viewController.title = product.title;
            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [dataArray addObject:item];
    }
    
    self.dataSource = dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"React Native";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

@end
