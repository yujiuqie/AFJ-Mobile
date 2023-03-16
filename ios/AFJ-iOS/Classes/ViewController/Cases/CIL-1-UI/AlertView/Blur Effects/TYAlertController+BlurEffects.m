//
//  TYAlertController+BlurEffects.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/10/26.
//  Copyright © 2015年 tanyang. All rights reserved.
//

#import "TYAlertController+BlurEffects.h"
#import "UIImage+ImageEffects.h"

@implementation TYAlertController (BlurEffects)

#pragma mark - public

- (void)setBlurEffectWithView:(UIView *)view {
    [self setBlurEffectWithView:view style:BlurEffectStyleLight];
}

- (void)setBlurEffectWithView:(UIView *)view style:(BlurEffectStyle)blurStyle {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 处理耗时操作的代码块...
        UIImage *snapshotImage = [UIImage snapshotImageWithView:view];
        //通知主线程刷新
        UIImage *blurImage = [self blurImageWithSnapshotImage:snapshotImage style:blurStyle];
        UIImageView *blurImageView = [[UIImageView alloc] initWithImage:blurImage];
        self.backgroundView = blurImageView;
    });
}

- (void)setBlurEffectWithView:(UIView *)view effectTintColor:(UIColor *)effectTintColor {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 处理耗时操作的代码块...
        UIImage *snapshotImage = [UIImage snapshotImageWithView:view];
        //通知主线程刷新
        UIImage *blurImage = [snapshotImage applyTintEffectWithColor:effectTintColor];
        UIImageView *blurImageView = [[UIImageView alloc] initWithImage:blurImage];
        self.backgroundView = blurImageView;
    });
}

#pragma mark - private

- (UIImage *)blurImageWithSnapshotImage:(UIImage *)snapshotImage style:(BlurEffectStyle)blurStyle {
    switch (blurStyle) {
        case BlurEffectStyleLight:
            return [snapshotImage applyLightEffect];
        case BlurEffectStyleDarkEffect:
            return [snapshotImage applyDarkEffect];
        case BlurEffectStyleExtraLight:
            return [snapshotImage applyExtraLightEffect];
        default:
            return nil;
    }
}

@end
