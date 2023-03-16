//
//  FHXHelp.h
//  Frame
//
//  Created by 冯汉栩 on 2021/2/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "sys/utsname.h"

NS_ASSUME_NONNULL_BEGIN

@interface FHXHelp : NSObject


#pragma mark - 拨打电话

+ (void)makePhoneCallWithTelNumber:(NSString *)tel;


#pragma mark - 判断手机号码的运营商类型

+ (NSString *)judgePhoneNumTypeOfMobileNum:(NSString *)mobileNum;


#pragma mark - 将时间转换成时间戳

/**
 *  时间戳：指格林威治时间1970年01月01日00时00分00秒(北京时间1970年01月01日08时00分00秒)起至现在的总秒数。
 */
+ (NSString *)timeStringIntoTimeStamp:(NSString *)time;


#pragma mark - 将时间戳转换成时间

+ (NSString *)timeStampIntoTimeString:(NSString *)time;


#pragma mark - 通过时间字符串获取年、月、日

+ (NSArray *)getYearAndMonthAndDayFromTimeString:(NSString *)time;


#pragma mark - 获取今天、明天的日期

+ (NSArray *)timeForTheRecentDate;


#pragma mark - 当前界面截图

+ (UIImage *)imageFromCurrentView:(UIView *)view;


#pragma mark - 去掉html中的标签

+ (NSString *)stringRemovetheHTMLtags:(NSString *)htmlString;


#pragma mark - 生成随机数 n到m

+ (int)getRandomNumber:(int)from to:(int)to;


#pragma mark - 给view设置边框

+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;


#pragma mark - 将数组中重复的对象去除，只保留一个

+ (NSMutableArray *)arrayWithMemberIsOnly:(NSMutableArray *)array;


#pragma mark - 图片大小设置

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;


#pragma mark - 获取当前处于activity状态的view controller

+ (UIViewController *)activityViewController;


#pragma mark - 清空字典数据

+ (NSMutableDictionary *)clearNullData:(NSDictionary *)dic;


#pragma mark - 将image 转化成nsdata

+ (NSData *)getImageDataWith:(UIImage *)image;


#pragma mark - 格式化千分位

+ (NSString *)positiveFormat:(NSString *)text;


#pragma mark - 不四舍五入  小数

+ (NSString *)notRounding:(float)price afterPoint:(int)position;


#pragma mark - 获取用户手机信息

+ (NSMutableDictionary *)getUserPhoneInfo;


#pragma mark - 获取手机品牌型号

+ (NSString *)getUserPhoneModelNumber;


#pragma mark - 转化成手机号空格式字符串

+ (NSString *)becomePhoneNumTypeWithNSString:(NSString *)string;


#pragma mark - 拼接成中间有空格的字符串(类似银行卡中间空格)

+ (NSString *)jointBlankWithString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
