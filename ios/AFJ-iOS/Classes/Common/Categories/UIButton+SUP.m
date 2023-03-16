//
//  UIButton+SUP.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

static const void *UIButtonBlockKey = &UIButtonBlockKey;

@implementation UIButton (SUP)

- (void)addActionHandler:(TouchedBlock)touchHandler {
    objc_setAssociatedObject(self, UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionTouched:(UIButton *)btn {
    TouchedBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}


/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (instancetype)initWithFrame:(CGRect)frame buttonTitle:(NSString *)buttonTitle normalBGColor:(UIColor *)normalBGColor selectBGColor:(UIColor *)selectBGColor
                  normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor buttonFont:(UIFont *)buttonFont cornerRadius:(CGFloat)cornerRadius
                    doneBlock:(void (^)(UIButton *))doneBlock {
    self = [self initWithFrame:frame];

    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;


    self.titleLabel.font = buttonFont;
    [self setTitle:buttonTitle forState:UIControlStateNormal];
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    [self setTitleColor:selectColor forState:UIControlStateHighlighted];
    [self setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];

    __block typeof(self) weakSelf = self;
    [self addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {

        !doneBlock ?: doneBlock(weakSelf);
    }];

    return self;
}


+ (UIButton *)initWithFrame:(CGRect)frame buttonTitle:(NSString *)buttonTitle normalBGColor:(UIColor *)normalBGColor selectBGColor:(UIColor *)selectBGColor
                normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor buttonFont:(UIFont *)buttonFont cornerRadius:(CGFloat)cornerRadius
                  doneBlock:(void (^)(UIButton *))doneBlock {
    UIButton *solidColorButton = [[UIButton alloc] initWithFrame:frame buttonTitle:buttonTitle normalBGColor:normalBGColor selectBGColor:selectBGColor normalColor:normalColor selectColor:selectColor buttonFont:buttonFont cornerRadius:cornerRadius doneBlock:doneBlock];

    return solidColorButton;
}

@end
