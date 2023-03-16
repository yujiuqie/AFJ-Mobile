//
//  AdvertiseGradientView.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/10/29.
//  Copyright © 2019 fenghanxu.compang.cn. All rights reserved.
//

@interface AdvertiseGradientView ()

@property(nonatomic, strong) UIImageView *adView;

@end

@implementation AdvertiseGradientView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        [self addSubview:_adView];
    }
    return self;
}

- (void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
    _adView.image = [UIImage imageWithContentsOfFile:filePath];
    [UIView animateWithDuration:3.0f animations:^{
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
        self.alpha = 0.f;
    }                completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

@end
