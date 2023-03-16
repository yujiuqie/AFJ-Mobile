//
//  BMKCustomSelectedButton.m
//  BMKBikeRoutePlanDemo
//
//  Created by baidu on 2020/5/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKCustomSelectedButton.h"

@implementation BMKCustomSelectedButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self loadSubView];
    }
    return self;
}

- (void)loadSubView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 16 * widthScale, 16 * widthScale);
    [imageView setImage:[UIImage imageNamed:@"非选择框"]];
    [self addSubview:imageView];
    _leftImageView = imageView;

    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.frame = CGRectMake(16 * widthScale + 5.5 * widthScale, 0, self.frame.size.width - 16 * widthScale, 16 * widthScale);
    textLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    textLabel.textColor = COLOR(0xFFFFFF);
    textLabel.text = @"骑行类型（选中普通骑行模式，不选中电动车模式)";
    [self addSubview:textLabel];
    _rightLabel = textLabel;

    [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click {
    self.selected = !self.selected;
    if (self.selected) {
        [_leftImageView setImage:[UIImage imageNamed:@"选择框"]];
    } else {
        [_leftImageView setImage:[UIImage imageNamed:@"非选择框"]];
    }
    if ([self.delegate respondsToSelector:@selector(didClickSelectButton:)]) {
        [self.delegate performSelector:@selector(didClickSelectButton:) withObject:self];
    }
}


@end
