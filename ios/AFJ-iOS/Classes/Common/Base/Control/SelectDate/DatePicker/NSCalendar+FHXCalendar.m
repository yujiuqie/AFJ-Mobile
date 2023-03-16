//
//  NSCalendar+FHXCalendar.m
//  Frame
//
//  Created by 冯汉栩 on 2021/2/12.
//

#import "NSCalendar+FHXCalendar.h"

@implementation NSCalendar (FHXCalendar)

+ (NSDate *)dateWithDatestring:(NSString *)dateStr formatterStr:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSDate *date = [formatter dateFromString:dateStr];
    NSDate *dateTure = [NSDate dateWithTimeInterval:(8 * 60 * 60) sinceDate:date];
    return dateTure;
}

+ (NSString *)datestringWithDate:(NSDate *)date formatterStr:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSDateComponents *)componentsFromDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | kCFCalendarUnitHour | kCFCalendarUnitMinute;
    return [calendar components:unitFlags fromDate:date];
}

+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month {
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)) {
                return 29;
            } else {
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}
@end
