//
//  NSCalendar+FHXCalendar.h
//  Frame
//
//  Created by 冯汉栩 on 2021/2/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCalendar (FHXCalendar)

//字符串转化为日期
+ (NSDate *)dateWithDatestring:(NSString *)dateStr formatterStr:(NSString *)formatterStr;

//日期转化为字符串
+ (NSString *)datestringWithDate:(NSDate *)date formatterStr:(NSString *)formatterStr;

//日期转化为组分
+ (NSDateComponents *)componentsFromDate:(NSDate *)date;

//根据年 月 显示日
+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month;
@end

NS_ASSUME_NONNULL_END
