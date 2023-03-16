//
//  AFJPermissionViewController.m
//  AFJ-iOS
//
//  Created by Alfred Jiang on 2022/10/10.
//

#import "AFJPermissionViewController.h"

#import "AFJCaseItemData.h"
#import "ISHPermissionKit.h"

@interface AFJPermissionViewController()



@end

@implementation AFJPermissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
        NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = @[
            @[@"模拟qq扫码界面", @(ISHPermissionCategoryLocationWhenInUse)],
            @[@"模仿支付宝扫码区域", @"ZhiFuBaoStyle"],
            @[@"模仿微信扫码区域", @"weixinStyle"],
            @[@"无边框，内嵌4个角", @"InnerStyle"],
            @[@"4个角在矩形框线上,网格动画", @"OnStyle"],
            @[@"自定义颜色", @"changeColor"],
            @[@"只识别框内", @"recoCropRect"],
            @[@"改变尺寸", @"changeSize"],
            @[@"条形码效果", @"notSquare"],
            @[@"二维码/条形码生成", @"createBarCode"],
            @[@"相册", @"openLocalPhotoAlbum"]
    ];

    __weak typeof(self) weakSelf = self;
    for (NSArray *arr in array) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = [arr firstObject];
        item.type = [[arr lastObject] stringValue];
        item.didSelectAction = ^(id data) {
            [weakSelf colorCellAction:data];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)colorCellAction:(AFJCaseItemData *)data {
    ISHPermissionsViewController *vc = [ISHPermissionsViewController permissionsViewControllerWithCategories:@[@([data.type intValue])] dataSource:self];

    if (vc) {
        UIViewController *presentingVC = [kAppDelegate.window rootViewController];
        [presentingVC presentViewController:vc
                                   animated:YES
                                 completion:nil];
    }
}

@end
