//
//  BMKFootView.m
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKFootView.h"

@interface BMKFootView ()
/// 路线数据
@property(nonatomic, strong) UILabel *topLabel;
@end

@implementation BMKFootView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self loadSubView];
    }
    return self;
}

- (void)loadSubView {
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(22 * widthScale, 21 * widthScale, self.frame.size.width - (19 * 2 + 22 * 2) * widthScale, 19 * widthScale)];
    _topLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:19];
    _topLabel.textColor = COLOR(0x333333);
    _topLabel.text = @"0分钟 0公里";
    [self addSubview:_topLabel];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(22 * widthScale, 60 * widthScale, self.frame.size.width - 44 * widthScale, 1)];
    [line setBackgroundColor:COLOR(0xF0F0F0)];
    [self addSubview:line];

    //详情
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(22 * widthScale, 80 * widthScale, self.frame.size.width - 44 * widthScale, 38 * widthScale)];
    [addButton setBackgroundColor:COLOR(0x3385FF)];
    addButton.layer.cornerRadius = 19 * widthScale;
    addButton.layer.masksToBounds = YES;
    [addButton setTitle:@"详情" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(showRouteDetail) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
}

- (void)showRouteDetail {
    if ([self.delegate respondsToSelector:@selector(didClickDetailButton)]) {
        [self.delegate performSelector:@selector(didClickDetailButton)];
    }
}

- (void)updateData:(BMKWalkingRouteLine *)routeLine {
    NSString *time;
    if (routeLine.duration.minutes > 0) {
        time = [NSString stringWithFormat:@"%d分钟", routeLine.duration.minutes];
    }
    if (routeLine.duration.hours > 0) {
        time = [NSString stringWithFormat:@"%d小时", routeLine.duration.hours];
    }
    if (routeLine.duration.hours > 0 && routeLine.duration.minutes > 0) {
        time = [NSString stringWithFormat:@"%d小时%d分", routeLine.duration.hours, routeLine.duration.minutes];
    }
    NSString *distance;
    if (routeLine.distance < 100) {
        distance = [NSString stringWithFormat:@"%d米", routeLine.distance];
    } else {
        distance = [NSString stringWithFormat:@"%.1f公里", routeLine.distance / 1000.0];
    }
    NSString *duringString = [NSString stringWithFormat:@"%@ %@", time, distance];
    _topLabel.text = duringString;
}
@end
