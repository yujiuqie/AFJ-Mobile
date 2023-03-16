//
//  JZLoadingViewPacket.m
//  OCDemol
//
//  Created by 冯汉栩 on 2020/3/12.
//  Copyright © 2020 com.fenghanxu.demol. All rights reserved.
//

@interface LoadingGif ()
@property(nonatomic, strong) UIImageView *imageView;
@end

@implementation LoadingGif

- (void)showWithIimageName:(NSString *)name {
    self.hidden = NO;
    self.imageView.hidden = NO;
    self.imageView.image = [self loadGifWithImageName:name];
}

- (void)hide {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    self.imageView.hidden = YES;
    self.hidden = YES;

}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];

        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-10];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:65];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:65];
        [self addConstraint:constraint];

    }
    return _imageView;
}

+ (LoadingGif *)share {
    static LoadingGif *loading = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loading = [[LoadingGif alloc] init];
    });
    return loading;
}

+ (void)showWithAddToView:(UIView *)selfView withIimageName:(NSString *)name {
    LoadingGif *loading = [self share];
    [selfView addSubview:loading];

    loading.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:loading attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [selfView addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:loading attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [selfView addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:loading attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [selfView addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:loading attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [selfView addConstraint:constraint];

    [loading showWithIimageName:name];
}

- (UIImage *)loadGifWithImageName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    return [UIImage sd_imageWithGIFData:gifData];
}

@end

