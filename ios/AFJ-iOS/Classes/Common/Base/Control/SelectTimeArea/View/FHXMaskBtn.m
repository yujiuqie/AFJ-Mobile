//
//  FHXMaskBtn.m
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import "FHXMaskBtn.h"

@interface FHXMaskBtn ()

@property(nonatomic, copy) void (^complete)(FHXMaskBtn *);

@end

@implementation FHXMaskBtn
/**
 *  设置以后已经添加到window上，并且设置了frame
 */
+ (instancetype)zhenZhaoBtnWithComplete:(void (^)(FHXMaskBtn *zheZhaoBtn))complete {

    FHXMaskBtn *btn = [FHXMaskBtn buttonWithType:UIButtonTypeCustom];
    /** 保存点击回调 */
    btn.complete = complete;
    btn.backgroundColor = [UIColor blackColor];
    btn.alpha = 0.6;

    /** 设置frame */
    btn.frame = [UIScreen mainScreen].bounds;

//    /** 添加的父控件 */
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window addSubview:btn];
//    [window bringSubviewToFront:btn];

    /** 添加点击事件 */
    [btn addTarget:btn action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

/**
 *  点击回调
 *
 */
- (void)btnClicked:(FHXMaskBtn *)btn {
    self.complete(btn);
}
@end
