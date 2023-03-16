//
//  BMKTransitRouteTableViewCell.m
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKTransitRouteTableViewCell.h"

@interface BMKTransitRouteTableViewCell ()
@property(nonatomic, strong) UIView *tipsView;
@property(nonatomic, strong) UIView *view;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *detailLabel;
@property(nonatomic, strong) UILabel *rightLabel;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, assign) CGFloat cellHeight;
@end

@implementation BMKTransitRouteTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addCustomViews];
    }
    return self;
}

- (void)addCustomViews {
    self.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:view];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    _view = view;

    _tipsView = [[UIView alloc] init];
    [self.contentView addSubview:_tipsView];

    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(15 * widthScale, 28 * widthScale, 70 * widthScale, 24 * widthScale);
    timeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    timeLabel.textAlignment = NSTextAlignmentRight;
    [_view addSubview:timeLabel];
    _timeLabel = timeLabel;

//    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(29 * widthScale, 44 * widthScale, 8.5 * widthScale, 15 * widthScale)];
//    leftImageView = leftImageView;
//    [leftImageView setImage:[UIImage imageNamed:@"详情-选择步行"]];
//    [self.contentView addSubview:leftImageView];

    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * widthScale, 61 * widthScale, 70 * widthScale, 24 * widthScale)];
    rightLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15 * widthScale];
    rightLabel.textColor = COLOR(0x333333);
    rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel = rightLabel;
    [_view addSubview:rightLabel];

    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:COLOR(0xF0F0F0)];
    _line = line;
    [_view addSubview:line];

    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14 * widthScale];
    detailLabel.textColor = COLOR(0x868686);
    _detailLabel = detailLabel;
    [_view addSubview:detailLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _line.frame = CGRectMake(102.5 * widthScale, 20 * widthScale - 1, 1, self.cellHeight - 40 * widthScale);
    _detailLabel.frame = CGRectMake(113.5 * widthScale, self.cellHeight - 27 * widthScale - 15 * widthScale * _detailLabel.numberOfLines, self.frame.size.width - 150 * widthScale, 15 * widthScale * _detailLabel.numberOfLines);
    [_detailLabel sizeToFit];
    _view.frame = CGRectMake(10 * widthScale, 0, SCREENW - 20 * widthScale, self.cellHeight);
    _tipsView.frame = CGRectMake(10 * widthScale, 0, SCREENW - 20 * widthScale, self.cellHeight);
}

- (void)setModel:(BMKTransitRouteLineModel *)model {
    for (UIView *label in _tipsView.subviews) {
        [label removeFromSuperview];
    }
    _timeLabel.text = model.time;
    _rightLabel.text = model.distance;

    for (UIView *tip in model.tips) {
        if ([tip isKindOfClass:[UIImageView class]]) {
            [_tipsView addSubview:(UIImageView *) tip];
        } else {
            [_tipsView addSubview:(UILabel *) tip];
        }
    }
    self.cellHeight = model.cellHeight;
    _detailLabel.numberOfLines = model.detailRow;
    _detailLabel.text = model.detail;
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
