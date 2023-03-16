//
//  AFJPickerViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/11.
//

#import "AFJPickerViewController.h"
#import "MOFSPickerManager.h"

@implementation AFJPickerModel

@end

@interface AFJPickerViewController ()



@end

@implementation AFJPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";

    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"请选择日期";
        item.didSelectAction = ^(id data) {
            MOFSDatePicker *p = [MOFSDatePicker new];
            [p showWithSelectedDate:nil commit:^(NSDate *_Nullable date) {
                [weakSelf showToastWithMessage:[df stringFromDate:date]];
            }                cancel:^{

            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"请选择地址";
        item.didSelectAction = ^(id data) {
            MOFSAddressPickerView *picker = [MOFSAddressPickerView new];
            [picker showWithTitle:@"请选择地址" commitTitle:@"确定" cancelTitle:@"取消" commitBlock:^(MOFSAddressSelectedModel *_Nullable selectedModel) {
                [weakSelf showToastWithMessage:[NSString stringWithFormat:@"%@-%@-%@", selectedModel.provinceName, selectedModel.cityName, selectedModel.districtName]];
            }         cancelBlock:^{

            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJPickerModel *a = [AFJPickerModel new];
        a.age = 17;
        a.name = @"示例 Name 一";
        a.nickname = @"示例 Nickname 一";
        a.userId = 0001;

        AFJPickerModel *b = [AFJPickerModel new];
        b.age = 18;
        b.name = @"示例 Name 二";
        b.nickname = @"示例 Nickname 二";
        b.userId = 0002;

        AFJPickerModel *c = [AFJPickerModel new];
        c.age = 22;
        c.name = @"示例 Name 三";
        c.nickname = @"示例 Nickname 三";
        c.userId = 0003;

        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"自定义选择";
        item.didSelectAction = ^(id data) {
            MOFSPickerView *p = [MOFSPickerView new];
            p.attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor redColor]};
            p.toolBar.titleBarTitle = @"";
            [p showWithDataArray:@[a, b, c] keyMapper:@"name" title:@"选择" commitBlock:^(id _Nullable model) {
                AFJPickerModel *m = (AFJPickerModel *) model;
                [weakSelf showToastWithMessage:[NSString stringWithFormat:@"%@-%zd", m.name, m.userId]];
            }        cancelBlock:^{

            }];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end

