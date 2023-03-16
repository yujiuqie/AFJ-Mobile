//
//  FHXMainTitleBtn.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/12/31.
//  Copyright © 2019 fenghanxu.compang.cn. All rights reserved.
//

#import "NerdyUI.h"

@interface FHXLeftTitleBtn ()

@property(nonatomic, strong) UIImageView *img;

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation FHXLeftTitleBtn

- (void)setWidth:(CGFloat)width {
    _width = width;
    self.img.updateCons(^{
        make.width.equal.constants(self.width);
        make.height.equal.constants(self.height);
    });
}

- (void)setHeight:(CGFloat)height {
    _height = height;
    self.img.updateCons(^{
        make.width.equal.constants(self.width);
        make.height.equal.constants(self.height);
    });
}

- (void)setIconName:(NSString *)iconName {
    _iconName = iconName;
    self.img.img(_iconName);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.str(_title);
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = _titleColor;
}

- (void)setFnt:(CGFloat)fnt {
    _fnt = fnt;
    self.titleLabel.fnt(_fnt);
}

- (void)setBackgroundColors:(UIColor *)backgroundColors {
    _backgroundColors = backgroundColors;
    self.bgColor(_backgroundColors);
}

- (void)setIconLeftDistance:(CGFloat)iconLeftDistance {
    _iconLeftDistance = iconLeftDistance;
    self.img.updateCons(^{
        make.left.equal.view(self.titleLabel).right.constants(self.iconLeftDistance);
    });
}

- (void)setTitleLeftDistance:(CGFloat)titleLeftDistance {
    _titleLeftDistance = titleLeftDistance;
    self.titleLabel.updateCons(^{
        make.left.equal.view(self).constants(self.titleLeftDistance);
    });
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = [Color textTheme];
    self.titleLabel.addTo(self).makeCons(^{
        make.centerY.equal.view(self);
        make.left.equal.view(self).constants(5);
    });

    self.img = [UIImageView new];
    self.img.addTo(self).makeCons(^{
        make.centerY.equal.view(self);
        make.left.equal.view(self.titleLabel).right.constants(5);
        make.width.height.equal.constants(25);
    });


}
@end
