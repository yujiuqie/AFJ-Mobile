//
//  FHXWaterMarkView.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/9/24.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHXWaterMarkView : UIImageView

/**
说明:  使用该方法水印添加到View  或者UIScrollView(TableView,CollectionView)都可以
设置水印
@param markText 水印显示的文字
@param view 添加控制器
@param isLogin  是否登录(用不上登录属性 直接填写YES)
*/
+ (instancetype)waterMarkViewWithText:(NSString *)markText withView:(UIView *)view withIsLogin:(BOOL)isLogin;

/**
说明:  使用该方法水印添加到View上面
设置水印
@param markText 水印显示的文字
 @param isLogin  是否登录(用不上登录属性 直接填写YES)
*/
+ (instancetype)waterMarkViewWithText:(NSString *)markText withIsLogin:(BOOL)isLogin;

/**
说明:  使用该方法水印添加到win设置水印
@param markText  水印显示的文字
@param window      添加到win
@param isLogin    是否登录(用不上登录属性 直接填写YES)
*/
+ (instancetype)waterMarkViewWithText:(NSString *)markText withWindow:(UIWindow *)window withIsLogin:(BOOL)isLogin;

/**
 水印说明:
 封装本来是只有下面的这个方法，它是通过对象调用方法的，只需要传递frame值跟水印值进去就好了。
 后来我把下面的方法再次封装一下。封装成类点出方法调用方便一点。
 上面有两个方法：(一般用第一个方法就可以了)
 第一个方法：添加到控制器的view
 第二个方法：不需要传递水印的view，直接通过获取当前控制器的view就可以了。
 第三个方法：添加到    win
 */

/**
 设置水印
 @param frame 水印大小
 @param markText 水印显示的文字
 */
//- (instancetype)initWithFrame:(CGRect)frame WithText:(NSString *)markText;



@end

NS_ASSUME_NONNULL_END
