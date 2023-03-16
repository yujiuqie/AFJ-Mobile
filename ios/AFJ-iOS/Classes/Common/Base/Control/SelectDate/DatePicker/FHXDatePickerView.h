//
//  FHXDatePickerView.h
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSCalendar+FHXCalendar.h"

@interface FHXDatePickerView : UIPickerView
//最小年份,默认是1900年
@property(nonatomic, assign) NSInteger leastYear;

//有多少年，默认是200年
@property(nonatomic, assign) NSInteger years;

//当月有多少有多少日
@property(nonatomic, assign) NSInteger dates;

//输出时间
@property(nonatomic, copy) NSString *outputString;

/**
 *  初始化的时候，此种方法选中为当前时间
 *
 *  @param outputFormatter 输出的日期格式
 *  @param completion 完成回调，传出了选定日期的字符串
 */
+ (instancetype)datePickerViewWithformatter:(NSString *)outputFormatter complete:(void (^)(NSString *outputStr))completion;

/**
 *  这种初始化方法显示的时你想显示的时间
 *
 *  @param dateStr         日期字符串
 *  @param inputFormatter  输入的日期格式，必须与输入的字符串一致
 *  @param outputFormatter 输出的日期格式
 *  @param completion      完成回调，传出了选定日期的字符串
 */
+ (instancetype)datePickerViewWithdateString:(NSString *)dateStr formatter:(NSString *)inputFormatter outputFormatter:(NSString *)outputFormatter complete:(void (^)(NSString *outputStr))completion;

@end
