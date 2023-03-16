//
//  AFJCountDownViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/7.
//

#import "AFJCountDownViewController.h"

@interface AFJCountDownViewController ()

@property(nonatomic, strong) CountDownManager *aloneCountDownA;
@property(nonatomic, strong) CountDownManager *aloneCountDownB;

@end

@implementation AFJCountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.aloneCountDownA = [CountDownManager new];
    self.aloneCountDownB = [CountDownManager new];
}

- (void)viewDidAppear:(BOOL)animated {
    {
        __block UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, SCREENW - 40, 80)];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];

        [self.aloneCountDownB countDownWithFinishTimeTemStamp:([[Time getNowTimeTimestampaSecondA] intValue] + 60) adjust:0 completeBlock:^(NSString *timeStr, BOOL isFinish) {
            if (isFinish) {
                label.text = @"已结束";
            } else {
                label.text = [NSString stringWithFormat:@"%@", timeStr];
            }
        }];
    }
    {
        __block UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, SCREENW - 40, 80)];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];

        [self.aloneCountDownA clockwiseHasPasstimeWithStratTimeTemStamp:[[Time getNowTimeTimestampaSecondA] intValue] adjust:0 completeBlock:^(NSString *dateStr) {
            label.text = [NSString stringWithFormat:@"%@", dateStr];
        }];
    }
}


@end
