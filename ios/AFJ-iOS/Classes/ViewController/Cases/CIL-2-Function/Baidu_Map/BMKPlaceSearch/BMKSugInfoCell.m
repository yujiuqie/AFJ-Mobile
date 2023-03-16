//
//  BMKSugInfoCell.m
//  BMKPlaceSearchDemo
//
//  Created by baidu on 2020/7/22.
//  Copyright © 2020 zhangbaojin. All rights reserved.
//

#import "BMKSugInfoCell.h"

@interface BMKSugInfoCell ()

/// btn
@property(nonatomic, strong) UIButton *leftBtn;

/// nameLabel
@property(nonatomic, strong) UILabel *nameLabel;

/// subTitleLabel
@property(nonatomic, strong) UILabel *subTitleLabel;


@end

@implementation BMKSugInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 23.5, 23, 23)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"local_icon"] forState:UIControlStateNormal];
        [self.contentView addSubview:_leftBtn];

        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftBtn.frame) + 10, 10, [[UIScreen mainScreen] bounds].size.width - CGRectGetMaxX(_leftBtn.frame) - 10 * 2, 30)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:19];
        _nameLabel.text = @"【位置】";
        [self.contentView addSubview:_nameLabel];

        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame) + 5, CGRectGetWidth(_nameLabel.frame), 18)];
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        _subTitleLabel.textColor = [UIColor colorWithRed:139.f / 255.f green:126.f / 255.f blue:102.f / 255.f alpha:1.f];
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.text = @"";
        [self.contentView addSubview:_subTitleLabel];

    }
    return self;
}

- (void)configTitle:(NSString *)title subTitle:(NSString *)subTitle {
    if (title) {
        self.nameLabel.text = title;
    }
    if (subTitle) {
        self.subTitleLabel.text = subTitle;
    }
}

@end
