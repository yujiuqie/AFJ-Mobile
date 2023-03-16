//
//  FHXHUD.m
//  SVProgressHUDDemo
//
//  Created by 冯汉栩 on 2019/3/19.
//  Copyright © 2019年 冯汉栩. All rights reserved.
//

@implementation FHXHUD

//纯菊花旋转
+ (void)showChrysanthemumTime:(double)time {
    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    //最简单的显示隐藏
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

//纯菊花旋转+文本信息
+ (void)showChrysanthemumTime:(double)time showTitle:(NSString *)title {

    //显示加载标题
    [SVProgressHUD showWithStatus:title];
    //设置样式
    /*
     SVProgressHUDStyleLight,        // default style, white HUD with black text, HUD background will be blurred
     SVProgressHUDStyleDark,         // black HUD and white text, HUD background will be blurred
     SVProgressHUDStyleCustom        // uses the fore- and background color properties
     */
    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];

    /**
     *  设置HUD背景图层的样式
     *
     *  SVProgressHUDMaskTypeNone：默认图层样式，当HUD显示的时候，允许用户交互。
     *
     *  SVProgressHUDMaskTypeClear：当HUD显示的时候，不允许用户交互。
     *
     *  SVProgressHUDMaskTypeBlack：当HUD显示的时候，不允许用户交互，且显示黑色背景图层。
     *
     *  SVProgressHUDMaskTypeGradient：当HUD显示的时候，不允许用户交互，且显示渐变的背景图层。
     *
     *  SVProgressHUDMaskTypeCustom：当HUD显示的时候，不允许用户交互，且显示背景图层自定义的颜色。
     */
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    /*
     SVProgressHUDAnimationTypeFlat,     // default animation type, custom flat animation (indefinite animated ring)
     SVProgressHUDAnimationTypeNative    // iOS native UIActivityIndicatorView
     */
    //动画效果
    [SVProgressHUD setDefaultAnimationType:(SVProgressHUDAnimationTypeFlat)];


    //设置多少秒后隐藏
    [SVProgressHUD dismissWithDelay:time];

}

//成功标志+文本信息
+ (void)showSuccessTime:(double)time showTitle:(NSString *)title {
    //加载成功动画
    [SVProgressHUD showSuccessWithStatus:title];
    [SVProgressHUD dismissWithDelay:time];

    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
}

//失败标志+文本信息
+ (void)showErrorTime:(double)time showTitle:(NSString *)title {
    //加载失败动画
    [SVProgressHUD showErrorWithStatus:title];
    [SVProgressHUD dismissWithDelay:time];
    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
}

//进度条
+ (void)showProgressPercentage:(double)percentage {

    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];

    if (percentage < 1.0) {
        [SVProgressHUD showProgress:percentage];
    } else {
        [SVProgressHUD dismiss];
    }

}

//感叹号+文本信息
+ (void)showInfoTime:(double)time showTitle:(NSString *)title {
    [SVProgressHUD showInfoWithStatus:title];
    [SVProgressHUD dismissWithDelay:time];
    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
}

+ (void)showSuccessTime:(double)time showTitle:(NSString *)title finish:(void (^)(void))result {
    //加载成功动画
    [SVProgressHUD showSuccessWithStatus:title];
    [SVProgressHUD dismissWithDelay:time completion:result];
    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
}

//失败标志+文本信息
+ (void)showErrorTime:(double)time showTitle:(NSString *)title finish:(void (^)(void))result {
    //加载失败动画
    [SVProgressHUD showErrorWithStatus:title];
    [SVProgressHUD dismissWithDelay:time completion:result];
    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
}

//感叹号+文本信息
+ (void)showInfoTime:(double)time showTitle:(NSString *)title finish:(void (^)(void))result {
    [SVProgressHUD showInfoWithStatus:title];
    [SVProgressHUD dismissWithDelay:time];
    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
}

@end
