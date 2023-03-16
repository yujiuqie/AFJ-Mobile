//
//  AFJNativeViewController.m
//  AFJ-iOS
//
//  Created by alfred on 2023/2/16.
//

#import "AFJNativeViewController.h"
#import "AFJProductManager.h"
#import "QDNavigationController.h"
#import "QDCommonListViewController.h"
#import "AFJRootListViewController.h"
#import "QDUIKitViewController.h"
#import "QDComponentsViewController.h"
#import "QDLabViewController.h"

@interface AFJNativeViewController ()

@end

@implementation AFJNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Native";
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (NSArray *)setupProducts:(NSArray *)objects {
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dic in objects) {
        AFJCaseItemData *product = [[AFJCaseItemData alloc] init];
        product.title = [dic objectForKey:@"title"];
        product.entrance = [dic objectForKey:@"entrance"];
        product.flag = [dic objectForKey:@"hasDemo"];
        product.link = [dic objectForKey:@"link"];
        __weak __typeof(self) weakSelf = self;
        product.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            UIViewController *viewController = [[NSClassFromString(product.entrance) alloc] init];
            viewController.title = product.title;
            if ([viewController respondsToSelector:@selector(setProduct:)]) {
                [viewController performSelector:@selector(setProduct:) withObject:product];
            }
            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [dataArray addObject:product];
    }

    return dataArray;
}

- (void)initDataSource {
    
    NSMutableArray *result = [NSMutableArray array];
    
    [result addObjectsFromArray:[self fullItemList]];
    
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"QMUIKit";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            QDUIKitViewController *viewController = [[QDUIKitViewController alloc] init];
            viewController.title = product.title;
            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [result addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"QMUIComponents";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            QDComponentsViewController *viewController = [[QDComponentsViewController alloc] init];
            viewController.title = product.title;
            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [result addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"QMUILab";
        __weak __typeof(self) weakSelf = self;
        item.didSelectAction = ^(AFJCaseItemData *product) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            QDLabViewController *viewController = [[QDLabViewController alloc] init];
            viewController.title = product.title;
            [strongSelf.navigationController pushViewController:viewController animated:YES];
        };
        [result addObject:item];
    }
    
    self.dataSource = [result copy];
}

- (NSArray *)fullItemList {
        NSMutableArray *dataArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"product-list" ofType:@"json"];
        NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

        NSError *error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

        if (error) {
            NSLog(@"product list parse error : %@", error);
        }

        if ([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *results = object;
            NSLog(@"product list parse success");
            NSArray *titles = [[results allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                return [obj1 intValue] - [obj2 intValue];
            }];
            for (NSString *title in titles) {
                NSDictionary *dic = [results objectForKey:title];
                AFJCaseItemData *item = [AFJCaseItemData new];
                item.type = [dic objectForKey:@"type"];
                item.title = [dic objectForKey:@"name"];
                item.list = [self setupProducts:[dic objectForKey:@"list"]];
                __weak __typeof(self) weakSelf = self;
                item.didSelectAction = ^(AFJCaseItemData *product) {
                    __strong __typeof(weakSelf) strongSelf = weakSelf;
                    AFJRootListViewController *viewController = [[AFJRootListViewController alloc] init];
                    viewController.title = product.title;
                    viewController.dataSource = product.list;
                    if ([viewController respondsToSelector:@selector(setProduct:)]) {
                        [viewController performSelector:@selector(setProduct:) withObject:product];
                    }
                    [strongSelf.navigationController pushViewController:viewController animated:YES];
                };
                [dataArray addObject:item];
            }
        } else {
            NSLog(@"product list parse error : %@", object);
        }

    return dataArray;
}

@end
