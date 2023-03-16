//
//  BMKPoiInfoCell.m
//  BMKPickUpPointsDemo
//
//  Created by Baidu on 2020/5/22.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import "BMKPoiInfoCell.h"

@interface BMKPoiInfoCell ()

/// nameLabel
@property(nonatomic, strong) UILabel *nameLabel;

/// subTitleLabel
@property(nonatomic, strong) UILabel *subTitleLabel;

/// btn
@property(nonatomic, strong) UIButton *confirmBtn;

@end

@implementation BMKPoiInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [[UIScreen mainScreen] bounds].size.width - 20 - 40 - 20, 30)];
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

        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 20 - 100, 22.5, 100, 30)];
        [_confirmBtn setTitle:@"选择该点" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor colorWithRed:72.f / 255.f green:118.f / 255.f blue:1.f alpha:1.f] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = 15;
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.borderWidth = 1;
        _confirmBtn.layer.borderColor = [UIColor colorWithRed:72.f / 255.f green:118.f / 255.f blue:1.f alpha:1.f].CGColor;
        [self.contentView addSubview:_confirmBtn];
        _confirmBtn.hidden = YES;
    }
    return self;
}


- (void)confirmBtnClicked:(UIButton *)btn {
    NSLog(@"选择该点");
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
