//
//  AFJEventViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/8.
//

#import "AFJEventViewController.h"

#import "AFJCaseItemData.h"
#import "YBEventCalendar.h"

@interface AFJEventViewController ()



@end

@implementation AFJEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"添加日历事件";
        item.didSelectAction = ^(id data) {
            [YBEventCalendar createEventCalendarTitle:@"事件测试" location:@"上海" startDate:[[NSDate date] dateByAddingTimeInterval:(1 * 24 * 60 * 60)] endDate:[[NSDate date] dateByAddingTimeInterval:(2 * 24 * 60 * 60)] allDay:YES alarmArray:@[@"-86400", @"-43200", @"-21600", @"-3600"] completion:^(BOOL granted, NSError *error) {

                if (error) {
                    [self.view makeToast:error.localizedDescription];
                } else {
                    [MBProgressHUD showSuccess:@"添加成功" ToView:self.view];
                }
            }];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
