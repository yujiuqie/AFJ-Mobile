//
//  UIButton+TcExtension.h
//
/**
 * titleEdgeInsets属性和imageEdgeInsets只是用来设置title和image的位置，但是系统不会用它们来计算button的intrinsicSize；
 * 但是button是用contentInset来计算其intrinsicSize的大小的！！！
 * 该方法调整完Image及Title的位置后，会根据Sapcing通过contentInset 进行优化button 的位置关系。

 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Tc_ImagePosition) {
    Tc_ImagePositionLeft = 0,              //图片在左，文字在右，默认
    Tc_ImagePositionRight = 1,             //图片在右，文字在左
    Tc_ImagePositionTop = 2,               //图片在上，文字在下
    Tc_ImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (TcExtension)

@property(nonatomic, strong) void (^clickBlock)(UIButton *button);

/**
 * 初始化
 */
- (instancetype)setText:(NSString *)text TextColor:(UIColor *)textColor Font:(UIFont *)font;

/**
 * 设置默认字体
 */
- (void)setNormalTitle:(NSString *)title;

/**
 * 设置选中字体
 */
- (void)setSelectedTitle:(NSString *)title;

/**
 * 设置默认图片
 */
- (void)setNormalImage:(UIImage *)image;

/**
 * 设置选中图片
 */
- (void)setSelectedImage:(UIImage *)image;

/**
 * 设置背景颜色
 */
- (void)setBgColor:(UIColor *)color;

/**
 * 设置字体颜色
 */
- (void)setTextColor:(UIColor *)textColor;

/**
 * 设置背景图片
 */
- (void)setBgImg:(UIImage *)bgImg;

/**
 * 设置字体
 */
- (void)setFont:(UIFont *)font;

/**
 * 设置文字位置
 */
- (void)setTextPolsition:(NSTextAlignment)alignment;

/**
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *  @param postion 图片位置
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(Tc_ImagePosition)postion spacing:(CGFloat)spacing;

/**
 * 点击事件block
 */
- (void)setOnclick:(void (^)(UIButton *button))block;

- (void)clickBtn:(UIButton *)sender;

@end






