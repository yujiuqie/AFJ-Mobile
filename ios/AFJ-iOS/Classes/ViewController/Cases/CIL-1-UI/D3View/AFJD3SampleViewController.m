//
//  AFJD3SampleViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/24.
//

#import "AFJD3SampleViewController.h"
#import "D3View.h"

@interface AFJD3SampleViewController ()
        <
        UIPickerViewDelegate,
        UIPickerViewDataSource
        >

@property(weak, nonatomic) IBOutlet UIView *d3view;
@property(weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property(weak, nonatomic) IBOutlet UIPickerView *picker;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, assign) CGRect exFrame;
@property(nonatomic, assign) NSInteger selectedRow;

@end

@implementation AFJD3SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //                fade     //交叉淡化过渡(不支持过渡方向)
    //                push     //新视图把旧视图推出去
    //                moveIn   //新视图移到旧视图上面
    //                reveal   //将旧视图移开,显示下面的新视图
    //                cube     //立方体翻滚效果
    //                oglFlip  //上下左右翻转效果
    //                suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
    //                rippleEffect //滴水效果(不支持过渡方向)
    //                pageCurl     //向上翻页效果
    //                pageUnCurl   //向下翻页效果
    //                cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
    //                cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)

    self.dataSource = @[@"闪亮", @"左右摇", @"上下摇", @"心跳", @"摇摆", @"缩小", @"放大", @"掉落", @"翻转", @"翻页",
            @"交叉淡化", @"推出", @"覆盖", @"揭开", @"3D立方", @"翻转", @"收缩效果", @"滴水效果", @"向上翻页", @"向下翻页", @"镜头打开", @"镜头关闭",
            @"不停旋转", @"渐隐", @"渐现"];
    self.selectedRow = 0;
    [self selected:self.selectedRow];
}

- (void)viewDidLayoutSubviews {
    self.exFrame = self.d3view.frame;
}

- (NSString *)subType {
    if (self.segment.selectedSegmentIndex == 0) {
        return kCATransitionFromLeft;
    } else if (self.segment.selectedSegmentIndex == 1) {
        return kCATransitionFromRight;
    } else if (self.segment.selectedSegmentIndex == 2) {
        return kCATransitionFromTop;
    }

    return kCATransitionFromBottom;
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    [self selected:self.selectedRow];
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self selected:row];
}

- (void)selected:(NSInteger)row {
    self.selectedRow = row;
    self.d3view.transform = CGAffineTransformIdentity;
    self.d3view.frame = self.exFrame;
    self.d3view.alpha = 1;
    self.d3view.backgroundColor = [self randomColor];

    switch (row) {
        case 0:
            [self.d3view d3_blink];
            break;
        case 1:
            [self.d3view d3_shake];
            break;
        case 2:
            [self.d3view d3_bounce:10 duration:0.2 completion:^{
                NSLog(@"摇完了");
            }];
            break;
        case 3:
            [self.d3view d3_heartbeat];
            break;
        case 4:
            [self.d3view d3_swing];
            break;
        case 5:
            [self.d3view d3_scale:0.1];
            break;
        case 6:
            [self.d3view d3_scale:2.0];
            break;
        case 7:
            [self.d3view d3_drop];
            break;
        case 8:
            [self.d3view d3_flip];
            break;
        case 9:
            [self.d3view d3_pageing];
            break;
        case 10:

            //后面的效果自己尝试，换参数而已
            //                fade     //交叉淡化过渡(不支持过渡方向)
            //                push     //新视图把旧视图推出去
            //                moveIn   //新视图移到旧视图上面
            //                reveal   //将旧视图移开,显示下面的新视图
            //                cube     //立方体翻滚效果
            //                oglFlip  //上下左右翻转效果
            //                suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
            //                rippleEffect //滴水效果(不支持过渡方向)
            //                pageCurl     //向上翻页效果
            //                pageUnCurl   //向下翻页效果
            //                cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
            //                cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)


            //            subType:
            //            kCATransitionFromRight
            //            kCATransitionFromLeft
            //            kCATransitionFromTop
            //            kCATransitionFromBottom

            [self.d3view d3_Animation:kCATransitionFade subType:[self subType] duration:1.0];
            break;
        case 11:
            [self.d3view d3_Animation:kCATransitionPush subType:[self subType] duration:1.0];
            break;
        case 12:
            [self.d3view d3_Animation:kCATransitionMoveIn subType:[self subType] duration:1.0];
            break;
        case 13:
            [self.d3view d3_Animation:kCATransitionReveal subType:[self subType] duration:1.0];
            break;
        case 14:
            [self.d3view d3_Animation:@"cube" subType:[self subType] duration:1.0];
            break;
        case 15:
            [self.d3view d3_Animation:@"oglFlip" subType:[self subType] duration:1.0];
            break;
        case 16:
            [self.d3view d3_Animation:@"suckEffect" subType:[self subType] duration:1.0];
            break;
        case 17:
            [self.d3view d3_Animation:@"rippleEffect" subType:[self subType] duration:1.0];
            break;
        case 18:
            [self.d3view d3_Animation:@"pageCurl" subType:[self subType] duration:1.0];
            break;
        case 19:
            [self.d3view d3_Animation:@"pageUnCurl" subType:[self subType] duration:1.0];
            break;
        case 20:
            [self.d3view d3_Animation:@"cameraIrisHollowOpen" subType:[self subType] duration:1.0];
            break;
        case 21:
            [self.d3view d3_Animation:@"cameraIrisHollowClose" subType:[self subType] duration:1.0];
            break;
        case 22:
            [self.d3view d3_setRotate:-1 duration:1 completion:nil];
            break;
        case 23:
            [self.d3view d3_fadeOut];
            break;
        case 24:
            [self.d3view d3_fadeIn];
            break;
        default:
            break;
    }
}

- (UIColor *)randomColor {
    srand48(time(0));

    double red = drand48();
    double green = drand48();
    double blue = drand48();

    return [[UIColor alloc] initWithRed:red green:green blue:blue alpha:1.0];
}

@end
