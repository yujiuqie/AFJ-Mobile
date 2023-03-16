//
//  Time.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/3/11.
//  Copyright © 2019年 com.fenghanxu.demol. All rights reserved.
//

#import "Time.h"

@implementation Time

/**
 *  获取当前的时间
 *
 *  @param type  时间格式(YYYY-MM-dd hh:mm:ss SSS)  (YYYY-MM-dd)  (MM-dd) (hh:mm:ss SSS) (hhmmssSSS)
 *
 *  @return  时间字符串
 */
+ (NSString *)getCurrentTimesWithType:(NSString *)type {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:type];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    return [formatter stringFromDate:datenow];
}

//获取当前时间戳有两种方法(以秒为单位)
//获取当前时间的时间戳(秒)  方法1
+ (NSString *)getNowTimeTimestampaSecondA {
    return [NSString stringWithFormat:@"%ld", (long) [[NSDate date] timeIntervalSince1970]];
}

//获取当前时间的时间戳(秒)  方法2
+ (NSString *)getNowTimeTimestampSecondB {
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

//获取当前时间戳  （以毫秒为单位）
+ (NSString *)getNowTimeTimestampMillisecond {
    NSDate *dateValue = [NSDate date];
    NSTimeInterval second = [dateValue timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:second * 1000] longLongValue];
    NSString *msecond = [NSString stringWithFormat:@"%llu", dTime];
    return msecond;
}

//获取距离现在过了多少时间(跟微信一样)(好用)
+ (NSString *)getCurrrentTimeToReleaseTime:(NSString *)releaseTime {

    NSDate *nowDate = [NSDate date];

    NSTimeInterval now = [nowDate timeIntervalSince1970];
    NSTimeInterval yet = [releaseTime doubleValue];

    NSTimeInterval newTime = now - yet;

    NSString *mm = [NSString stringWithFormat:@"%.2f", newTime / 60];
    NSString *hh = [NSString stringWithFormat:@"%.2f", newTime / 60 / 60];
    NSString *dd = [NSString stringWithFormat:@"%.2f", newTime / 60 / 60 / 24];
    NSString *MM = [NSString stringWithFormat:@"%.2f", newTime / 60 / 60 / 24 / 30];
//    NSString * YY = [NSString stringWithFormat:@"%.2f",newTime/60/60/24/30/12];

    NSString *date;

    if ([MM floatValue] >= 1) {
        date = [NSString stringWithFormat:@"%.f个月前", [MM floatValue]];
    } else if ([dd floatValue] >= 1) {
        date = [NSString stringWithFormat:@"%.f天前", [dd floatValue]];
    } else if ([hh floatValue] >= 1) {
        date = [NSString stringWithFormat:@"%.f小时前", [hh floatValue]];
    } else if ([mm floatValue] >= 1) {
        date = [NSString stringWithFormat:@"%.f分钟前", [mm floatValue]];
    } else {
        date = [NSString stringWithFormat:@"%.f秒前", newTime];
    }
    return date;
}

//获取距离现在过了多少时间(跟微信一样)(一般)
+ (NSString *)getDistanceTimeWithBeforeTime:(NSString *)beTime {
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    double distanceTime = now - [beTime doubleValue];
    NSString *distanceStr;
    NSDate *beDate = [NSDate dateWithTimeIntervalSince1970:[beTime doubleValue]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    NSString *timeStr = [df stringFromDate:beDate];
    [df setDateFormat:@"dd"];
    NSString *nowDay = [df stringFromDate:[NSDate date]];
    NSString *lastDay = [df stringFromDate:beDate];
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    } else if (distanceTime < 60 * 60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前", (long) distanceTime / 60];
    } else if (distanceTime < 24 * 60 * 60 && [nowDay integerValue] == [lastDay integerValue]) {//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@", timeStr];
    } else if (distanceTime < 24 * 60 * 60 * 2 && [nowDay integerValue] != [lastDay integerValue]) {
        if ([nowDay integerValue] - [lastDay integerValue] == 1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@", timeStr];
        } else {
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
    } else if (distanceTime < 24 * 60 * 60 * 365) {
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    } else {
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}


@end
