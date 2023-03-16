//
//  Color.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/3/23.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//  源主题色ff6619  登录未激活FFA07A

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Color : NSObject

//随机色
@property(class, nonatomic, strong, readonly) UIColor *randomColor;
//主题色
@property(class, nonatomic, strong, readonly) UIColor *theme;
//亮主题色
@property(class, nonatomic, strong, readonly) UIColor *themeLight;
//浅主题色
@property(class, nonatomic, strong, readonly) UIColor *themeShallow;
//弱主题色
@property(class, nonatomic, strong, readonly) UIColor *themeWeak;
//文字色
@property(class, nonatomic, strong, readonly) UIColor *textBlank;
//二级文字信息
@property(class, nonatomic, strong, readonly) UIColor *textSub;
//未激活按钮
@property(class, nonatomic, strong, readonly) UIColor *nonActivated;
//文字描边
@property(class, nonatomic, strong, readonly) UIColor *textLine;
//分割线
@property(class, nonatomic, strong, readonly) UIColor *line;
//背景
@property(class, nonatomic, strong, readonly) UIColor *backgroung;
//辅助色
@property(class, nonatomic, strong, readonly) UIColor *assist;
//辅助浅色
@property(class, nonatomic, strong, readonly) UIColor *assistDeep;
//亮绿色
@property(class, nonatomic, strong, readonly) UIColor *greenLight;
//深亮绿
@property(class, nonatomic, strong, readonly) UIColor *greenDeepLight;
//深绿
@property(class, nonatomic, strong, readonly) UIColor *greenDeep;

//道奇蓝
@property(class, nonatomic, strong, readonly) UIColor *doderBlue;
//皇家蓝
@property(class, nonatomic, strong, readonly) UIColor *royalBlue;
//乳脂
@property(class, nonatomic, strong, readonly) UIColor *bisque;
//春天绿
@property(class, nonatomic, strong, readonly) UIColor *limeGreen;
//晒黑
@property(class, nonatomic, strong, readonly) UIColor *tan;

//标题颜色
@property(class, nonatomic, strong, readonly) UIColor *textTheme;
//秒杀已抢光颜色
@property(class, nonatomic, strong, readonly) UIColor *robed;

@end

NS_ASSUME_NONNULL_END
