//
//  AFJEventBusViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/16.
//

#import "AFJEventBusViewController.h"
#import "QTEventBus.h"
#import "DemoEvent.h"
#import "QTEventBus+AppModule.h"

#import "AFJCaseItemData.h"

@interface AFJEventBusViewController()



@end

@implementation AFJEventBusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupListener];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Dispatch Notification";
        item.didSelectAction = ^(id data) {
            [weakSelf dispatchNotification];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Dispatch Event";
        item.didSelectAction = ^(id data) {
            [weakSelf dispatchEvent];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Dispatch String";
        item.didSelectAction = ^(id data) {
            [weakSelf dispatchString];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"Dispatch Json";
        item.didSelectAction = ^(id data) {
            [weakSelf dispatchJson];
        };
        [dataArray addObject:item];
    }
   
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)setupListener{
    __weak typeof(self) weakSelf = self;
    [QTSub(self, DemoEvent) next:^(DemoEvent *event) {
        NSLog(@"%ld",event.count);
        [weakSelf showToastWithMessage:[NSString stringWithFormat:@"%ld",event.count]];
    }];
    [QTSubNoti(self, @"name") next:^(NSNotification *event) {
        NSLog(@"%@",@"Block 1 Receive Notification");
        [weakSelf showToastWithMessage:[NSString stringWithFormat:@"%@",@"Block 1 Receive Notification"]];
    }];
    [QTSubNoti(self, @"name") next:^(NSNotification *event) {
        NSLog(@"%@",@"Block 2 Receive Notification");
        [weakSelf showToastWithMessage:[NSString stringWithFormat:@"%@",@"Block 2 Receive Notification"]];
    }];
    [QTSub(self, QTAppLifeCircleEvent).ofSubType(QTAppLifeCircleEvent.didEnterBackground)
     next:^(QTAppLifeCircleEvent *event) {
         NSLog(@"DemoViewController: %@",event.type);
        [weakSelf showToastWithMessage:[NSString stringWithFormat:@"DemoViewController: %@",event.type]];
    }];
    [QTSubName(self, @"ButtonClickedEvent") next:^(NSString *event) {
        NSLog(@"%@",@"Receive String Event");
        [weakSelf showToastWithMessage:[NSString stringWithFormat:@"%@",@"Receive String Event"]];
    }];
    [QTSubJSON(self, @"EventKey") next:^(QTJsonEvent *event) {
        NSLog(@"Receive Json Event: %@",event.data);
        [weakSelf showToastWithMessage:[NSString stringWithFormat:@"Receive Json Event: %@",event.data]];
    }];
}

- (void)dispatchNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"name" object:nil];
}

- (void)dispatchEvent {
    static long _count = 1;
    DemoEvent * event = [[DemoEvent alloc] init];
    event.count = _count;
    _count ++;
    [[QTEventBus shared] dispatch:event];
}

- (void)dispatchString {
    [[QTEventBus shared] dispatch:@"ButtonClickedEvent"];
}

- (void)dispatchJson {
    QTJsonEvent * event = [QTJsonEvent eventWithId:@"EventKey"
                                       jsonObject:@{@"Author" : @"LeoMobileDeveloper"}];
    [[QTEventBus shared] dispatch:event];
}

@end
