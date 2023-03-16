//
//  AFJCalendarViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/22.
//

#import "AFJCalendarViewController.h"

#import "AFJCaseItemData.h"

@interface AFJCalendarViewController()



@end

@implementation AFJCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    NSArray *array = @[
            @[@"Range Picker", @"RangePickerViewController"],
            @[@"DIY", @"DIYExampleViewController"],
            @[@"Prev-Next Buttons", @"ButtonsViewController"],
            @[@"Hides Placeholder", @"HidePlaceholderViewController"],
            @[@"Delegate Appearance", @"DelegateAppearanceViewController"],
            @[@"Full Screen ", @"FullScreenExampleViewController"],
            @[@"LoadView", @"LoadViewExampleViewController"]
    ];

    __weak typeof(self) weakSelf = self;
    for (NSArray *arr in array) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = [arr firstObject];
        item.type = [arr lastObject];
        item.didSelectAction = ^(id data) {
            UIViewController *vc = [[NSClassFromString(item.type) alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
