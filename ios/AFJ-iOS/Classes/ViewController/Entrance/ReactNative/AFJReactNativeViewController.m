//
//  AFJReactNativeViewController.m
//  AFJ-iOS
//
//  Created by alfred on 2023/3/16.
//

#import "AFJReactNativeViewController.h"
#import "AFJKittenTricksViewController.h"
#import "AFJReactNativeMessageViewController.h"
#import "AFJRNSampleViewController.h"
#import "AFJRNLocalBundleViewController.h"

@interface AFJReactNativeViewController ()

@end

@implementation AFJReactNativeViewController

- (void)initDataSource{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"React Native、iOS 通信示例";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            AFJReactNativeMessageViewController *viewController = [[AFJReactNativeMessageViewController alloc] init];
            viewController.title = product.title;
            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [dataArray addObject:item];
    }
    
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"React Native 官方示例一";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            AFJRNSampleViewController *viewController = [[AFJRNSampleViewController alloc] initRNSampleWith:[NSString stringWithFormat:@"%@/rn_jsbundle/rn-sample-1.js",AFJ_RESOURCES_PATH] module:@"RNSample1"];
            viewController.title = product.title;
            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [dataArray addObject:item];
    }
    
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"React Native 官方示例二";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            AFJRNSampleViewController *viewController = [[AFJRNSampleViewController alloc] initRNSampleWith:[NSString stringWithFormat:@"%@/rn_jsbundle/rn-sample-2.js",AFJ_RESOURCES_PATH] module:@"RNSample2"];
            viewController.title = product.title;
            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [dataArray addObject:item];
    }
    
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"三方 - EasyApp";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            AFJRNLocalBundleViewController *viewController = [[AFJRNLocalBundleViewController alloc] initRNLocalWith:@"rn-easy-app" module:@"EasyApp"];
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
