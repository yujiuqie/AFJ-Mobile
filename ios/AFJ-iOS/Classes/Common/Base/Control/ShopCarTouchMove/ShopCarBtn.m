//
//  ShowShopCarBtn.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/12/28.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

#import "ShopCarBtn.h"
#import "NerdyUI.h"

@implementation ShopCarBtn

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.backgroundColor = [UIColor whiteColor];

    self.bgView = [UIView new];
    self.bgView.addTo(self).bgColor([Color themeLight]).border(3, [Color theme]).borderRadius(40).makeCons(^{
        make.center.equal.view(self);
        make.width.height.equal.constants(80);
    });

    self.icon = [UIImageView new];
    self.icon.addTo(self.bgView).img([UIImage createImageWithColor:[UIColor whiteColor]]).makeCons(^{
        make.centerX.equal.view(self.bgView);
        make.top.equal.view(self.bgView).constants(7);
        make.width.height.equal.constants(45);
    });

    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.addTo(self.bgView).fnt(14).makeCons(^{
        make.centerX.equal.view(self.bgView);
        make.top.equal.view(self.icon).bottom.constants(-5);
    });

    self.subTitleLabel = [UILabel new];
    self.subTitleLabel.textColor = [UIColor whiteColor];
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subTitleLabel.addTo(self).fnt(14).borderRadius(13).bgColor([Color themeLight]).makeCons(^{
        make.top.equal.view(self).constants(0);
        make.right.equal.view(self).constants(0);
        make.width.height.equal.constants(26);
    });

}

@end

