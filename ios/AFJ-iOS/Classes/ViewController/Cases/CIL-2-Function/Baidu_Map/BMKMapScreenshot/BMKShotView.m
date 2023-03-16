//
//  BMKShotView.m
//  BMKMapScreenshot
//
//  Created by baidu on 2020/7/20.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKShotView.h"

@interface BMKShotView ()

@property(nonatomic, strong) UILabel *topLabel;

@end

@implementation BMKShotView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
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
    _topLabel.text = @"10分钟 2公里";
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
    [self addSubview:addButton];
}

/// 该API仅可以在未使用layer和OpenGL渲染的视图上使用
- (UIImage *)snapshot {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}
@end
