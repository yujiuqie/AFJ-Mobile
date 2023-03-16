//
//  LoadingAnimation.m
//  OCDemol
//
//  Created by 冯汉栩 on 2020/1/15.
//  Copyright © 2020 com.fenghanxu.demol. All rights reserved.
//

#import "NerdyUI.h"

@implementation LoadingAnimation

Single_implementation(LoadingAnimation)

+ (void)share {
    [[LoadingAnimation alloc] buildUI];
}

- (void)buildUI {
    self.icon = [UIImageView new];
    self.icon.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.icon];
    //  self.icon.img(@"empty_rotate_normal").xywh((Phone_Width-25)*0.5,(Phone_Height-25)*0.5,25,25);
    self.icon.img(@"empty_rotate_normal").makeCons(^{
        make.center.equal.view([UIApplication sharedApplication].keyWindow);
        make.width.height.equal.constants(25);
    });

    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 10000;
    [self.icon.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

}

@end
