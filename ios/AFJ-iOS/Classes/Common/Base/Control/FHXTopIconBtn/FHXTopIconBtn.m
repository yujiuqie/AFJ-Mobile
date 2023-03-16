//
//  FHXTopIconBtn.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/1/2.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

#import "NerdyUI.h"

@interface FHXTopIconBtn ()

@property(nonatomic, strong) UIImageView *img;

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation FHXTopIconBtn

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

- (void)setIconTopDistance:(CGFloat)iconTopDistance {
    _iconTopDistance = iconTopDistance;
    self.img.updateCons(^{
        make.top.equal.view(self).constants(self.iconTopDistance);
    });
}

- (void)setTitleTopDistance:(CGFloat)titleTopDistance {
    _titleTopDistance = titleTopDistance;
    self.titleLabel.updateCons(^{
        make.top.equal.view(self.img).bottom.constants(self.titleTopDistance);
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

    self.img = [UIImageView new];
    self.img.addTo(self).makeCons(^{
        make.centerX.equal.view(self);
        make.top.equal.view(self).constants(5);
        make.width.height.equal.constants(25);
    });

    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = [Color textTheme];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.addTo(self).makeCons(^{
        make.centerX.equal.view(self);
        make.top.equal.view(self.img).bottom.constants(10);
        make.left.equal.view(self).constants(2);
        make.right.equal.view(self).constants(-2);
    });

}

@end
