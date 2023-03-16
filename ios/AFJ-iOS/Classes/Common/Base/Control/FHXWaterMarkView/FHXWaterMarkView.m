//
//  FHXWaterMarkView.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/9/24.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

/**
 M_PI                  180°
 M_PI_2               90°
 -(M_PI_2 / 3)       45°
 (M_PI_2 / 3)        135°
 */

#define HORIZONTAL_SPACE 30//水平间距
#define VERTICAL_SPACE 50//竖直间距
#define CG_TRANSFORM_ROTATION -(M_PI_2 / 3)//旋转角度(正旋45度 || 反旋45度)

@implementation FHXWaterMarkView

/**
设置水印
@param markText 水印显示的文字
@param view 添加控制器
*/
+ (instancetype)waterMarkViewWithText:(NSString *)markText withView:(UIView *)view withIsLogin:(BOOL)isLogin {
    for (UIView *view in [GetVC getCurrentViewController].view.subviews) {
        if ([view isKindOfClass:[FHXWaterMarkView class]]) {
            [view removeFromSuperview];
        }
    }
    if (!isLogin) {return [FHXWaterMarkView new];}
    FHXWaterMarkView *watermark = [[FHXWaterMarkView alloc] initWithFrame:CGRectMake(0, 0, Phone_Width, Phone_Height) WithText:markText];
    [view addSubview:watermark];
    return watermark;
}

/**
设置水印
@param markText 水印显示的文字
*/
+ (instancetype)waterMarkViewWithText:(NSString *)markText withIsLogin:(BOOL)isLogin {
    for (UIView *view in [GetVC getCurrentViewController].view.subviews) {
        if ([view isKindOfClass:[FHXWaterMarkView class]]) {
            [view removeFromSuperview];
        }
    }
    if (!isLogin) {return [FHXWaterMarkView new];}
    FHXWaterMarkView *watermark = [[FHXWaterMarkView alloc] initWithFrame:CGRectMake(0, 0, Phone_Width, Phone_Height) WithText:markText];
    [[GetVC getCurrentViewController].view addSubview:watermark];
    return watermark;
}

/**
说明:  使用该方法水印添加到win设置水印
@param markText  水印显示的文字
@param window      添加到      win
@param isLogin    是否登录(用不上登录属性 直接填写YES)
*/
+ (instancetype)waterMarkViewWithText:(NSString *)markText withWindow:(UIWindow *)window withIsLogin:(BOOL)isLogin {
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:[FHXWaterMarkView class]]) {
            [view removeFromSuperview];
        }
    }
    if (!isLogin) {return [FHXWaterMarkView new];}
    FHXWaterMarkView *watermark = [[FHXWaterMarkView alloc] initWithFrame:CGRectMake(0, 0, Phone_Width, Phone_Height) WithText:markText];
    [window addSubview:watermark];
    return watermark;
}

/**
 设置水印
 @param frame 水印大小
 @param markText 水印显示的文字
 */
- (instancetype)initWithFrame:(CGRect)frame WithText:(NSString *)markText {
    if (self = [super initWithFrame:frame]) {

        UIFont *font = [UIFont systemFontOfSize:16];

        UIColor *color = [[UIColor colorWithHex:0x989898] colorWithAlphaComponent:0.2];

        //原始image的宽高
        CGFloat viewWidth = frame.size.width;
        CGFloat viewHeight = frame.size.height;

        //为了防止图片失真，绘制区域宽高和原始图片宽高一样
        UIGraphicsBeginImageContext(CGSizeMake(viewWidth, viewHeight));

        //sqrtLength：原始image的对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
        CGFloat sqrtLength = sqrt(viewWidth * viewWidth + viewHeight * viewHeight);
        //文字的属性
        NSDictionary *attr = @{
                //设置字体大小
                NSFontAttributeName: font,
                //设置文字颜色
                NSForegroundColorAttributeName: color,
        };
        NSString *mark = markText;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:mark attributes:attr];
        //绘制文字的宽高
        CGFloat strWidth = attrStr.size.width;
        CGFloat strHeight = attrStr.size.height;

        //开始旋转上下文矩阵，绘制水印文字
        CGContextRef context = UIGraphicsGetCurrentContext();

        //清除画布
        CGContextClearRect(context, CGRectMake(0, 0, Phone_Width, Phone_Height));

        //将绘制原点（0，0）调整到原image的中心
        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(viewWidth / 2, viewHeight / 2));
        //以绘制原点为中心旋转
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(CG_TRANSFORM_ROTATION));
        //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-viewWidth / 2, -viewHeight / 2));

        //计算需要绘制的列数和行数
        int horCount = sqrtLength / (strWidth + HORIZONTAL_SPACE) + 1;
        int verCount = sqrtLength / (strHeight + VERTICAL_SPACE) + 1;

        //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
        CGFloat orignX = -(sqrtLength - viewWidth) / 2;
        CGFloat orignY = -(sqrtLength - viewHeight) / 2;

        //在每列绘制时X坐标叠加
        CGFloat tempOrignX = orignX;
        //在每行绘制时Y坐标叠加
        CGFloat tempOrignY = orignY;
        for (int i = 0; i < horCount * verCount; i++) {
            [mark drawInRect:CGRectMake(tempOrignX, tempOrignY, strWidth, strHeight) withAttributes:attr];
            if (i % horCount == 0 && i != 0) {
                tempOrignX = orignX;
                tempOrignY += (strHeight + VERTICAL_SPACE);
            } else {
                tempOrignX += (strWidth + HORIZONTAL_SPACE);
            }
        }
        //根据上下文制作成图片
        UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGContextRestoreGState(context);

        self.image = finalImg;
    }

    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    //1.判断自己能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
        return nil;
    }
    //2.判断当前点在不在当前View.
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    //3.从后往前遍历自己的子控件.让子控件重复前两步操作,(把事件传递给,让子控件调用hitTest)
    int count = (int) self.subviews.count;
    for (int i = count - 1; i >= 0; i--) {
        //取出每一个子控件
        UIView *chileV = self.subviews[i];
        //把当前的点转换成子控件坐标系上的点.
        CGPoint childP = [self convertPoint:point toView:chileV];
        UIView *fitView = [chileV hitTest:childP withEvent:event];
        //判断有没有找到最适合的View
        if (fitView) {
            return fitView;
        }
    }

    //4.没有找到比它自己更适合的View.那么它自己就是最适合的View
    return self;
}

//作用:判断当前点在不在它调用View,(谁调用pointInside,这个View就是谁)
//什么时候调用:它是在hitTest方法当中调用的.
//注意:point点必须得要跟它方法调用者在同一个坐标系里面
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    return NO;
}

@end
