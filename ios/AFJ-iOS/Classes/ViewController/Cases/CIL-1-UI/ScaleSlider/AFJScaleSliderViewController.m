//
//  AFJScaleSliderViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/7.
//

#import "AFJScaleSliderViewController.h"

#import "AFJCaseItemData.h"

@interface AFJScaleSliderViewController ()



@end

@implementation AFJScaleSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];

    NSArray *array = @[
            @[@"Basic", @"EFBasicViewController"],
            @[@"Big Circle Handle", @"EFBigCircleHandleViewController"],
            @[@"Double Circle Handle", @"EFDoubleCircleViewController"],
            @[@"With Labels", @"EFWithLabelsViewController"],
            @[@"Big line", @"EFBigLineViewController"],
            @[@"Snap to Labels", @"EFSnapToLabelsViewController"],
            @[@"Time Picker", @"EFTimePickerViewController"]
    ];

    for (NSArray *arr in array) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = [arr firstObject];
        item.type = [arr lastObject];
        item.didSelectAction = ^(id data) {
            [weakSelf colorCellAction:data];
        };
        [dataArray addObject:item];
    }

        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)colorCellAction:(id)data {
    AFJCaseItemData *item = data;
    NSLog(@"click %@ item", item.title);

    UIViewController *vc = [[NSClassFromString(item.type) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
