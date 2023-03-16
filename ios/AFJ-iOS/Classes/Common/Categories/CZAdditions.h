//
//  CZAdditions.h
//
//  Created by 刘凡 on 16/4/21.
//  Copyright © 2016年 itcast. All rights reserved.
//


// MARK:- Foundation
#import "NSObject+CZRuntime.h" // 字典转模型、当前类属性数组、当前类成员变量数组
// MARK: NSString
#import "NSString+CZHash.h" // 对当前字符串进行(哈希)散列函数 MD5, SHA256等
#import "NSString+Hash.h" // 对当前字符串进行(哈希)散列函数 MD5, SHA256等
#import "NSString+CZBase64.h" // 对当前字符串进行编码和解码
#import "NSString+CZPath.h" // 给当前文件名添加沙盒路径前缀
#import "NSString+Sandbox.h" // 给当前文件名添加沙盒路径前缀

// MARK: NSAttributedString
#import "NSAttributedString+CZAddition.h" // 使用图像和文本生成上下排列的属性文本

#import "Foundation+Log.h" // 解决控制台中文显示问题

// MARK: NSArray
#import "NSArray+ChineseDisplay.h" // 解决控制台中文显示问题
// MARK: NSDictionary
#import "NSDictionary+ChineseDisplay.h" // 解决控制台中文显示问题

// MARK:- UIKit
// MARK: UIView
#import "UIView+CZAddition.h" // 返回视图截图，获取当前视图所在的导航控制器，UIView 设置任意角为圆角，快速修改宽、高、边框等


// MARK: UILabel
#import "UILabel+CZAddition.h" // 快速创建文本框并设置属性

// MARK: UIButton
#import "UIButton+CZAddition.h" // 快速创建文本和图像按钮
#import "UIButton+TcExtension.h" // 快速调整按钮图片和文字位置、标题、字体等属性
// MARK: UIColor
#import "UIColor+CZAddition.h" // 使用16进制数字创建颜色、生成随机颜色、使用 R / G / B 数值创建颜色

// MARK: UIScreen
#import "UIScreen+CZAddition.h" // 屏幕宽度、高度、缩放因子

// MARK: UIViewController
#import "UIViewController+CZAddition.h" // 在当前视图控制器中添加子控制器，将子控制器的视图添加到 view 中

// MARK: UIImage

/*
 根据图片名返回一张能够自由拉伸的图片 (从中间拉伸)
 返回一张未被渲染的图片
 获取视频某个时间的帧图片
 获取屏幕截图
 根据颜色生成纯色图片
 取图片某一点的颜色
 取某一像素的颜色
 返回该图片是否有透明度通道
 获得灰度图
 对图像进行base64编码和解码
 */
#import "UIImage+Extension.h" // 如上图片相关操作



