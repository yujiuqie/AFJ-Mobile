//
//  AFJLSTPopViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/24.
//

#import "AFJLSTPopViewController.h"

#import "AFJCaseItemData.h"
#import "LSTPopViewTestVC.h"
#import <LSTPopView.h>
#import <UIView+LSTView.h>
#import "LSTPopViewXibView.h"
#import "LSTPopViewCodeView.h"
#import "LSTMutiPopViewVC.h"
#import "LSTAutoKeyboardVC.h"
#import "LSTPopViewRAMVC.h"
#import "LSTPopViewSceneVC.h"
#import "LSTPopViewGroupTestVC.h"
#import "LSTPopViewPriorityVC.h"
#import "LSTPopViewLifeCycleTestVC.h"
#import "LSTPopViewTimerTestVC.h"
#import "LSTPopViewListView.h"
//#import <LSTPopViewManager.h>
#import "LSTPopViewTVView.h"
#import "LSTLaunchMutiPopViewVC.h"
#import "LSTModel.h"
#import "LSTTestView.h"
#import <UIKit/UIFeedbackGenerator.h>
#import "LSTPopViewDragVC.h"

@interface AFJLSTPopViewController()



@end

@implementation AFJLSTPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"拨打电话";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"拨打电话" placeholder:@"18501791217" complete:^(NSString * _Nonnull info) {
                if([info length] > 0){
                    [FHXHelp makePhoneCallWithTelNumber:info];
                }
            }];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
