//
//  AFJGradientViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/5.
//

#import "AFJGradientViewController.h"

@interface AFJGradientViewController ()

@end

@implementation AFJGradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((SCREENW - 200) / 2.0, 120, 200, 80);
        [btn setTitle:@"水平方向渐变" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(200, 80) direction:ZQGradientChangeDirectionLevel startColor:[UIColor redColor] endColor:[UIColor greenColor]];
        [self.view addSubview:btn];
    }

    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((SCREENW - 200) / 2.0, 220, 200, 80);
        [btn setTitle:@"垂直方向渐变" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(200, 80) direction:ZQGradientChangeDirectionVertical startColor:[UIColor redColor] endColor:[UIColor greenColor]];
        [self.view addSubview:btn];
    }

    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"主对角线方向渐变" forState:UIControlStateNormal];
        btn.frame = CGRectMake((SCREENW - 200) / 2.0, 320, 200, 80);
        btn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(200, 80) direction:ZQGradientChangeDirectionUpwardDiagonalLine startColor:[UIColor redColor] endColor:[UIColor greenColor]];
        [self.view addSubview:btn];
    }

    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((SCREENW - 200) / 2.0, 420, 200, 80);
        [btn setTitle:@"副对角线方向渐变" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(200, 80) direction:ZQGradientChangeDirectionDownDiagonalLine startColor:[UIColor redColor] endColor:[UIColor greenColor]];
        [self.view addSubview:btn];
    }

    {
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREENW - 200) / 2.0, 520, 200, 80)];
        testLabel.text = @"label 上字体渐变示例";
        testLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:testLabel];
        [GradualChange TextGradientview:testLabel bgVIew:self.view gradientColors:@[(id) [UIColor redColor].CGColor, (id) [UIColor greenColor].CGColor, (id) [UIColor blueColor].CGColor] gradientStartPoint:CGPointMake(0, 1) endPoint:CGPointMake(1, 1)];
    }

    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 620, self.view.frame.size.width - 20, 100)];
        [self.view addSubview:btn];
        btn.titleLabel.numberOfLines = 0;
        [btn setTitle:@"button上字体渐变色示例" forState:UIControlStateNormal];
        [GradualChange TextGradientControl:btn bgVIew:self.view gradientColors:@[(id) [UIColor redColor].CGColor, (id) [UIColor greenColor].CGColor, (id) [UIColor blueColor].CGColor] gradientStartPoint:CGPointMake(0, 1) endPoint:CGPointMake(1, 1)];
    }

    {
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREENW - 200) / 2.0, 720, 200, 80)];
        testLabel.text = @"label 背景渐变示例";
        [self.view addSubview:testLabel];
        [testLabel az_setGradientBackgroundWithColors:@[[UIColor colorWithHex:0xA3F6D3], [UIColor colorWithHex:0xF40047]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        testLabel.textAlignment = NSTextAlignmentCenter;
        testLabel.textColor = [UIColor whiteColor];
    }
}


@end
