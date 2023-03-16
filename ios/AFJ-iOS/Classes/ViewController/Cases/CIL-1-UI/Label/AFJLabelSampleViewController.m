//
//  AFJLabelSampleViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/13.
//

#import "AFJLabelSampleViewController.h"

@interface AFJLabelSampleViewController ()

@end

@implementation AFJLabelSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    {
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREENW - 200) / 2.0, 120, 200, 180)];
        testLabel.numberOfLines = 0;
        [testLabel fhxSetText:@"label 行间距调整 10 示例，label 行间距调整 10 示例，label 行间距调整 10 示例，label 行间距调整 10 示例" lineSpacing:10];
        testLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:testLabel];
    }
    {
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREENW - 200) / 2.0, 320, 200, 180)];
        testLabel.numberOfLines = 0;
        [testLabel fhxSetText:@"label 行间距调整 20 示例，label 行间距调整 20 示例，label 行间距调整 20 示例，label 行间距调整 20 示例" lineSpacing:20];
        testLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:testLabel];
    }
    {
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREENW - 200) / 2.0, 520, 200, 180)];
        testLabel.numberOfLines = 0;
        testLabel.verticalText = @"竖行显示";
        testLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:testLabel];
    }
}


@end
