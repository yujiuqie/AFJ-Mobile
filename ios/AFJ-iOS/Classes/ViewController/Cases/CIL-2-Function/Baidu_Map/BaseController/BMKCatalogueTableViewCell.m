//
//  BMKCatalogueTableViewCell.m
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/5.
//  Copyright © 2018年 Baidu. All rights reserved.
//

#import "BMKCatalogueTableViewCell.h"

@interface BMKCatalogueTableViewCell ()
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *subtitle;
@property(nonatomic, strong) UIImageView *iconImage;
@property(nonatomic, strong) UIView *circleView;
@end

@implementation BMKCatalogueTableViewCell

#pragma mark - Initialization method

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self configUI];
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.subtitle];
}

#pragma mark - Config datasel

- (void)refreshUIWithData:(NSArray *)titles images:(NSArray *)images atIndexPath:(NSUInteger)indexpath {
    if (titles) {
        self.title.text = [[titles objectAtIndex:indexpath] allKeys].firstObject;
        NSArray *tempArray = [[titles objectAtIndex:indexpath] allValues];
        self.subtitle.text = tempArray[0][0];
    }
    if (images) {
        [self.contentView addSubview:self.circleView];
        [self.contentView addSubview:self.iconImage];
        _iconImage.image = [UIImage imageNamed:[images objectAtIndex:indexpath]];
    } else {
        _title.frame = CGRectMake(30, 21, 323 * widthScale, 22.5);
        _subtitle.frame = CGRectMake(30, 47, 323 * widthScale, 16.5);
    }
}

#pragma mark - Lazy loading

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(86, 21, 270 * widthScale, 22.5)];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textColor = COLOR(0x303030);
    }
    return _title;
}

- (UILabel *)subtitle {
    if (!_subtitle) {
        _subtitle = [[UILabel alloc] initWithFrame:CGRectMake(86, 47, 270 * widthScale, 16.5)];
        _subtitle.font = [UIFont systemFontOfSize:13];
        _subtitle.textColor = COLOR(0x999999);
    }
    return _subtitle;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 31, 21, 21)];
    }
    return _iconImage;
}

- (UIView *)circleView {
    if (!_circleView) {
        _circleView = [[UIView alloc] initWithFrame:CGRectMake(15.5, 16.5, 53, 53)];
        _circleView.layer.borderWidth = 1;
        _circleView.clipsToBounds = YES;
        _circleView.layer.cornerRadius = 26;
        _circleView.layer.borderColor = COLOR(0x3486FF).CGColor;
    }
    return _circleView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
