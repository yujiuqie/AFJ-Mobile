//
//  BMKRouteLineTableViewCell.m
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/22.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKBikeRouteLineTableViewCell.h"

@interface BMKBikeRouteLineTableViewCell ()
@property(nonatomic, assign) CGFloat cellHeight;
@end

@implementation BMKBikeRouteLineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addCustomViews];
    }
    return self;
}

- (void)addCustomViews {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 * widthScale, 0, SCREENW  - 20 * widthScale, 64 * widthScale)];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    [self.contentView addSubview:view];

    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 * widthScale, 18 * widthScale, 28 * widthScale, 28 * widthScale)];
    _leftImageView = leftImageView;
    [self.contentView addSubview:leftImageView];

    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(58 * widthScale, 24 * widthScale, SCREENW - 86 * widthScale, 16 * widthScale)];
    rightLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16 * widthScale];
    rightLabel.textColor = COLOR(0x333333);
    _rightLabel = rightLabel;
    [self.contentView addSubview:rightLabel];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(58 * widthScale, 64 * widthScale - 1, SCREENW - 86 * widthScale, 1)];
    [line setBackgroundColor:COLOR(0xF0F0F0)];
    _line = line;
    [self.contentView addSubview:line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _line.frame = CGRectMake(58 * widthScale, self.cellHeight - 1, SCREENW - 86 * widthScale, 1);
    _rightLabel.frame = CGRectMake(58 * widthScale, 24 * widthScale, SCREENW - 86 * widthScale, self.cellHeight - 48 * widthScale);
    [self.rightLabel sizeToFit];
    _leftImageView.frame = CGRectMake(15 * widthScale, (self.cellHeight - 28 * widthScale) / 2.0, 28 * widthScale, 28 * widthScale);
    [_rightLabel sizeToFit];
}

- (void)setDetailModel:(BMKBikeRouteDetailModel *)detailModel {
    self.rightLabel.text = detailModel.instruction;
    self.cellHeight = detailModel.cellHeight;
    self.leftImageView.image = [self loadImageWithInstruction:detailModel.instruction];
}

- (UIImage *)loadImageWithInstruction:(NSString *)instruction {
    return [UIImage imageNamed:@"详情-选择骑行"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
