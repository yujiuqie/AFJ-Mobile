//
//  FHXFloatWinCell.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/4/17.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

#import "FHXFloatWinCell.h"
#import "NerdyUI.h"

@interface FHXFloatWinCell ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *btn;

@end

@implementation FHXFloatWinCell

- (void)setModel:(NSString *)model {
    _model = model;
    self.titleLabel.str(_model);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"kFHXFloatWinCellID";
    FHXFloatWinCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FHXFloatWinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
//  self.backgroundColor = [Color textLine];
    self.backgroundColor = [UIColor colorWithHex:0x40454A];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.btn = [UIButton new];
    self.btn.addTo(self.contentView).img(@"floatWinView_delected_normal").borderRadius(15).makeCons(^{
        make.centerY.equal.view(self.contentView);
        make.right.equal.view(self.contentView).constants(-10);
        make.width.height.equal.constants(25);
    }).onClick(^{
        if ([self.delegate respondsToSelector:@selector(fhxFloatWinCell:returnPhoneNum:)]) {
            [self.delegate fhxFloatWinCell:self returnPhoneNum:self.model];
        }
    });

    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.addTo(self.contentView).fnt(16).makeCons(^{
        make.centerY.equal.view(self.contentView);
        make.left.equal.view(self.contentView).constants(15);
        make.right.equal.view(self.btn).left.constants(10);
    });

}

@end
