
//
//  CountDown.m
//  倒计时
//
//  Created by Maker on 16/7/5.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import "CountDownManager.h"

@interface CountDownManager ()

@property(nonatomic, retain) dispatch_source_t timer;

@property(nonatomic, retain) NSDateFormatter *dateFormatter;

@end

@implementation CountDownManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
        [self.dateFormatter setTimeZone:localTimeZone];
    }
    return self;
}

- (void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second))completeBlock {
    [self destoryTimer];
    NSTimeInterval timeInterval = [finishDate timeIntervalSinceDate:startDate];
    __block int timeout = timeInterval; //倒计时时间
    if (timeout != 0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if (timeout <= 0) { //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                _timer = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBlock(0, 0, 0, 0);
                });
            } else {
                int days = (int) (timeout / (3600 * 24));
                int hours = (int) ((timeout - days * 24 * 3600) / 3600);
                int minute = (int) (timeout - days * 24 * 3600 - hours * 3600) / 60;
                int second = timeout - days * 24 * 3600 - hours * 3600 - minute * 60;
                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBlock(days, hours, minute, second);
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }
}

- (void)countDownWithPER_SECBlock:(void (^)())PER_SECBlock {
    [self destoryTimer];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            PER_SECBlock();
        });
    });
    dispatch_resume(_timer);
}

///这个有问题不能除以1000
- (NSDate *)dateWithLongLong:(long long)longlongValue {
    long long value = longlongValue / 1000;
    NSNumber *time = [NSNumber numberWithLongLong:value];
    //转换成NSTimeInterval
    NSTimeInterval nsTimeInterval = [time longValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:nsTimeInterval];
    return date;
}

/**
 *  <#Description#>
 *
 *  @param starTimeStamp   <#starTimeStamp description#>
 *  @param finishTimeStamp <#finishTimeStamp description#>
 *  @param completeBlock   <#completeBlock description#>
 */
- (void)countDownWithStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second))completeBlock {
    [self destoryTimer];

    NSDate *finishDate = [self dateWithLongLong:finishTimeStamp];
    NSDate *startDate = [self dateWithLongLong:starTimeStamp];
    NSTimeInterval timeInterval = [finishDate timeIntervalSinceDate:startDate];
    __block int timeout = timeInterval; //倒计时时间
    if (timeout != 0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if (timeout <= 0) { //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                _timer = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBlock(0, 0, 0, 0);
                });
            } else {
                int days = (int) (timeout / (3600 * 24));
                int hours = (int) ((timeout - days * 24 * 3600) / 3600);
                int minute = (int) (timeout - days * 24 * 3600 - hours * 3600) / 60;
                int second = timeout - days * 24 * 3600 - hours * 3600 - minute * 60;
                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBlock(days, hours, minute, second);
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }
}


/******************************************************************/

- (void)dealloc {
    NSLog(@"%s dealloc", object_getClassName(self));

}

/**
 *  内部方法  设置输出字符串格式
 */
- (NSString *)refreshUIDays:(NSInteger)days hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSMutableString *timeStr = [NSMutableString string];

    if (days < 10) {
        [timeStr appendString:[NSString stringWithFormat:@"0%ld:", (long) days]];
    } else {
        [timeStr appendString:[NSString stringWithFormat:@"%ld:", (long) days]];
    }

    if (hour < 10) {
        [timeStr appendString:[NSString stringWithFormat:@"0%ld:", (long) hour]];
    } else {
        [timeStr appendString:[NSString stringWithFormat:@"%ld:", (long) hour]];
    }

    if (minute < 10) {
        [timeStr appendString:[NSString stringWithFormat:@"0%ld:", (long) minute]];
    } else {
        [timeStr appendString:[NSString stringWithFormat:@"%ld:", (long) minute]];
    }

    if (second < 10) {
        [timeStr appendString:[NSString stringWithFormat:@"0%ld", (long) second]];
    } else {
        [timeStr appendString:[NSString stringWithFormat:@"%ld", (long) second]];
    }

    return timeStr.copy;
}


/**
 *  主动销毁定时器
 *  @return 格式为年-月-日
 */
- (void)destoryTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

/**
 倒计时  10位时间戳
 
 @param finishTimeStamp 结束时间戳
 @param adjust 校验时间
 @param completeBlock 根据结束时间拿到倒计时
 */
- (void)countDownWithFinishTimeTemStamp:(long long)finishTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *, BOOL isFinish))completeBlock {
    ///现在的时间戳
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    ///校正时间为服务器时间
    nowInterval += adjust;

    //    NSTimeInterval lastTimeInterval = finishTimeStamp / 1000 - nowInterval;
    NSTimeInterval lastTimeInterval = finishTimeStamp - nowInterval;
    [self countDownWithTimeout:lastTimeInterval completeBlock:completeBlock];
}

/**
 倒计时  13位时间戳
 
 @param finishTimeStamp 结束时间戳
 @param adjust 校验时间
 @param completeBlock 根据结束时间拿到倒计时
 */
- (void)countDownWithFinishTimeTemThreeStamp:(long long)finishTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *, BOOL isFinish))completeBlock {
    ///现在的时间戳
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    ///校正时间为服务器时间
    nowInterval += adjust;

    NSTimeInterval lastTimeInterval = finishTimeStamp / 1000 - nowInterval;
    [self countDownWithTimeout:lastTimeInterval completeBlock:completeBlock];
}


/**
 顺计时  10位时间戳
 @param starTimeStamp 开始的时间戳 是秒
 @param completeBlock 已经过了多长时间的字符串，是否已经到时间了
 */

- (void)clockwiseHasPasstimeWithStratTimeTemStamp:(long long)starTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *dateStr))completeBlock {
    [self destoryTimer];
    ///现在的时间戳
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    ///校正时间为服务器时间
    nowInterval += adjust;

    //  NSTimeInterval passInterval = nowInterval - starTimeStamp / 1000;
    NSTimeInterval passInterval = nowInterval - starTimeStamp;

    __block int timeout = passInterval; //倒计时时间

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{

        timeout++;
        int days = (int) (timeout / (3600 * 24));
        int hours = (int) (timeout / (60 * 60));
        int minutes = (int) ((timeout % (60 * 60)) / (60));
        int seconds = (int) (timeout % 60);
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock([self refreshUIDays:days hour:hours minute:minutes second:seconds]);
        });

    });
    dispatch_resume(_timer);
}


/**
 顺计时  13位时间戳
 @param starTimeStamp 开始的时间戳 是毫秒
 @param completeBlock 已经过了多长时间的字符串，是否已经到时间了
 */

- (void)clockwiseHasPasstimeWithStratTimeTemThreeStamp:(long long)starTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *dateStr))completeBlock {
    [self destoryTimer];
    ///现在的时间戳
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    ///校正时间为服务器时间
    nowInterval += adjust;

    NSTimeInterval passInterval = nowInterval - starTimeStamp / 1000;

    __block int timeout = passInterval; //倒计时时间

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{

        timeout++;
        int days = (int) (timeout / (3600 * 24));
        int hours = (int) (timeout / (60 * 60));
        int minutes = (int) ((timeout % (60 * 60)) / (60));
        int seconds = (int) (timeout % 60);
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock([self refreshUIDays:days hour:hours minute:minutes second:seconds]);
        });

    });
    dispatch_resume(_timer);
}


/**
 顺计时  开始时间跑到结束时间递增 10位
 
 @param starTimeStamp 开始的时间戳 是秒
 @param finishTimeStamp 结束的时间戳，是秒
 @param completeBlock 已经过了多长时间的字符串，是否已经到时间了
 */

- (void)countDownHasPasstimeWithStratTimeTemStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *dateStr, BOOL isFinish))completeBlock {
    [self destoryTimer];
    ///现在的时间戳
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    ///校正时间为服务器时间
    nowInterval += adjust;

    //    NSTimeInterval passInterval = nowInterval - starTimeStamp / 1000;
    //    NSTimeInterval finishInterval = (finishTimeStamp - starTimeStamp) / 1000;
    NSTimeInterval passInterval = nowInterval - starTimeStamp;
    NSTimeInterval finishInterval = (finishTimeStamp - starTimeStamp);

    __block int timeout = passInterval; //倒计时时间
    if (timeout <= finishInterval) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{

            BOOL isFinish = NO;
            if (timeout >= finishInterval) { //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                _timer = nil;
                isFinish = YES;
            } else {
                timeout++;
            }
            int days = (int) (timeout / (3600 * 24));
            int hours = (int) (timeout / (60 * 60));
            int minutes = (int) ((timeout % (60 * 60)) / (60));
            int seconds = (int) (timeout % 60);
            dispatch_async(dispatch_get_main_queue(), ^{
                //                completeBlock([self refreshUIhour:hours minute:minutes second:seconds],isFinish);
                completeBlock([self refreshUIDays:days hour:hours minute:minutes second:seconds], NO);
            });

        });
        dispatch_resume(_timer);
    }
}

/**
 顺计时  开始时间跑到结束时间递增  13位
 
 @param starTimeStamp 开始的时间戳 是毫秒
 @param finishTimeStamp 结束的时间戳，是毫秒
 @param completeBlock 已经过了多长时间的字符串，是否已经到时间了
 */

- (void)countDownHasPasstimeWithStratTimeTemThreeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *dateStr, BOOL isFinish))completeBlock {
    [self destoryTimer];
    ///现在的时间戳
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    ///校正时间为服务器时间
    nowInterval += adjust;

    NSTimeInterval passInterval = nowInterval - starTimeStamp / 1000;
    NSTimeInterval finishInterval = (finishTimeStamp - starTimeStamp) / 1000;

    __block int timeout = passInterval; //倒计时时间
    if (timeout <= finishInterval) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{

            BOOL isFinish = NO;
            if (timeout >= finishInterval) { //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                _timer = nil;
                isFinish = YES;
            } else {
                timeout++;
            }
            int days = (int) (timeout / (3600 * 24));
            int hours = (int) (timeout / (60 * 60));
            int minutes = (int) ((timeout % (60 * 60)) / (60));
            int seconds = (int) (timeout % 60);
            dispatch_async(dispatch_get_main_queue(), ^{
                //                completeBlock([self refreshUIhour:hours minute:minutes second:seconds],isFinish);
                completeBlock([self refreshUIDays:days hour:hours minute:minutes second:seconds], NO);
            });

        });
        dispatch_resume(_timer);
    }
}


/**
 *  根据时间间隔进行倒计时,timeout必须是整数，值是秒数
 *
 *  @param timeOut       倒计时时间 秒
 *  @param completeBlock 倒计时回调
 */
- (void)countDownWithTimeout:(NSTimeInterval)timeOut completeBlock:(void (^)(NSString *, BOOL isFinish))completeBlock {
    [self destoryTimer];
    //    if (_timer == nil) {
    __block long long timeout = timeOut; //倒计时时间
    if (timeout >= 0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if (timeout <= 0) { //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                _timer = nil;

                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBlock([self refreshUIDays:0 hour:0 minute:0 second:0], YES);
                    //                    completeBlock([self refreshUIminute:0 second:0 hSecond:0]);
                });
            } else {

                int days = (int) (timeout / (3600 * 24));
                int hours = (int) ((timeout - days * 24 * 3600) / 3600);
                int minutes = (int) (timeout - days * 24 * 3600 - hours * 3600) / 60;
                int seconds = (int) timeout - days * 24 * 3600 - hours * 3600 - minutes * 60;
                //算错
                //        int days = (int)(timeout/(3600*24));
                //        int hours = (int)(timeout/(60*60));
                //        int minutes = (int)((timeout % (60*60))/(60));
                //        int seconds = (int)(timeout % 60);

                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBlock([self refreshUIDays:days hour:hours minute:minutes second:seconds], NO);
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    } else {
        completeBlock([self refreshUIDays:0 hour:0 minute:0 second:0], YES);
    }
    //    }
}

//获取当前时间戳有两种方法(以秒为单位)
+ (NSString *)getNowTimeTimestampReturnSecond {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long) [datenow timeIntervalSince1970]];

    return timeSp;

}

//获取当前时间戳  （以毫秒为单位）
+ (NSString *)getNowTimeTimestampMillisecond {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long) [datenow timeIntervalSince1970] * 1000];

    return timeSp;

}

@end
