//
//  ConstantUI.h
//  XWJSC
//
//  Created by xuewu.long on 16/12/13.
//  Copyright © 2016年 fmylove. All rights reserved.
//

#ifndef ConstantUI_h
#define ConstantUI_h


#pragma mark -   颜色相关

// Color helpers
#define RGBCOLOR(r, g, b)                                     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)                                  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define RGBCOLOR_HEX(h)                                     RGBCOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF))
#define RGBACOLOR_HEX(h, a)                                  RGBACOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF), (a))
#define RGBPureColor(h)                                     RGBCOLOR(h, h, h)
#define HSVCOLOR(h, s, v)                                     [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h, s, v, a)                                  [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]
#define RGBA(r, g, b, a)                                       (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)


//抽取颜色
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

//随机颜色
//#define RandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]

//rgb 十六进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#pragma mark - 尺寸相关

// 屏幕的bounds
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
//屏幕宽度
#define SCREENW [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREENH [UIScreen mainScreen].bounds.size.height

/// 设计图纸尺寸比例
#define kRATIO  (SCREENH/667.0)

// 抽屉的宽度
#define k_Drawer_W      (SCREENW * (616.0/720.0))

#define k_SpanLeft      (15 * kRATIO)
#define k_SpanIn        (k_SpanLeft/2)


// Positioning suit
#import "UIView+Positioning.h"
#import "UIView+NSLayout.h"
#import "UIImageView+FMY.h"

//#import "CNBarButtonItem.h"
//#import "CNNavigationController.h"
//#import "UIImageView+CNImageView.h"
//#import "MBProgressHUD+CN.h"


#pragma mark - APP_FONT ABOUT | APP_COLOR ABOUT
static NSString *FONT_Helvetica = @"Helvetica";
static NSString *FONT_Bradley_Hand = @"Bradley Hand";
static NSString *FONT_Roboto_Regular = @"Roboto-Regular"; // iOS系统默认无此字体


#define CNCOLOR_TEXT_TITLE          RGBCOLOR_HEX(0x131313)
#define CNCOLOR_TEXT_DESC           RGBCOLOR_HEX(0x989898)
#define CNCOLOR_TEXT_SLIGHT         RGBCOLOR_HEX(0xA6A6A6)
#define CNCOLOR_TEXT_SHARE_ITEM     RGBCOLOR_HEX(0x6b6b6b)
#define CNCOLOR_TEXT_SHARE_CANCEL   RGBCOLOR_HEX(0x575757)
#define CNCOLOR_PLAT_SHARE          RGBACOLOR_HEX(0xFFFFFF, 0.85)
#define CNCOLOR_GRAY_SLIGHT         RGBCOLOR_HEX(0xE4E4E4)
#define CNCOLOR_ITEM                RGBCOLOR_HEX(0x474747)
#define CNCOLOR_ITEM_FILL           RGBCOLOR_HEX(0xffffff)
#define CNCOLOR_ITEM_BORDER         RGBCOLOR_HEX(0xE1E1E1)
#define CNCOLOR_FIELD_BORDER        RGBCOLOR_HEX(0xD3D3D3)
#define CNCOLOR_FIELD_FILL          RGBCOLOR_HEX(0xFFFFFF)
#define CNCOLOR_THEME_EDIT          RGBCOLOR_HEX(0xfc5700)
#define CNCOLOR_THEME_EDITNESS      RGBCOLOR_HEX(0xC1C1C1)
#define CNCOLOR_LINE_SEPERATE       RGBCOLOR_HEX(0xE8E8E8)
#define CNCOLOR_OFFLINE_BACKGROUND  RGBCOLOR_HEX(0xEDEDED)


#define TIMER_HIDE_DELAY           (1.0f)


#endif /* ConstantUI_h */
