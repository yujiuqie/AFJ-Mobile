//
//  MyTestReusableView.m
//  ZLCollectionView
//
//  Created by zhaoliang chen on 2018/7/11.
//  Copyright © 2018年 zhaoliang chen. All rights reserved.
//

#import "MyTestReusableView.h"
#import "UIImageView+WebCache.h"

@interface MyTestReusableView()

@property(nonatomic,strong)UIImageView* imgV;
@end

@implementation MyTestReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingkong"]];
        self.imgV.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.imgV];
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)updateImageView {
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1547035180781&di=ad7e771ee99afc06b9280062c13b3cd9&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201508%2F14%2F20150814165156_iAvkx.jpeg"]];
}

@end
