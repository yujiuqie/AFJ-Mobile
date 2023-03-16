//
//  CountDown.h
//  倒计时
//
//  Created by Maker on 16/7/5.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CountDownManager : NSObject

//销毁定时器
- (void)destoryTimer;

/**
 倒计时  10位时间戳
 
 @param finishTimeStamp 结束时间戳
 @param adjust 校验时间
 @param completeBlock 根据结束时间拿到倒计时
 */
- (void)countDownWithFinishTimeTemStamp:(long long)finishTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *, BOOL isFinish))completeBlock;


/**
 倒计时  13位时间戳
 
 @param finishTimeStamp 结束时间戳
 @param adjust 校验时间
 @param completeBlock 根据结束时间拿到倒计时
 */
- (void)countDownWithFinishTimeTemThreeStamp:(long long)finishTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *, BOOL isFinish))completeBlock;


/**
 顺计时  10位时间戳
 @param starTimeStamp 开始的时间戳 是秒
 @param completeBlock 已经过了多长时间的字符串，是否已经到时间了
 */

- (void)clockwiseHasPasstimeWithStratTimeTemStamp:(long long)starTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *dateStr))completeBlock;


/**
 顺计时  13位时间戳
 @param starTimeStamp 开始的时间戳 是毫秒
 @param completeBlock 已经过了多长时间的字符串，是否已经到时间了
 */

- (void)clockwiseHasPasstimeWithStratTimeTemThreeStamp:(long long)starTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *dateStr))completeBlock;

/**
 顺计时  开始时间跑到结束时间递增 10位
 
 @param starTimeStamp 开始的时间戳 是秒
 @param finishTimeStamp 结束的时间戳，是秒
 @param completeBlock 已经过了多长时间的字符串，是否已经到时间了
 */

- (void)countDownHasPasstimeWithStratTimeTemStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *dateStr, BOOL isFinish))completeBlock;

/**
 顺计时  开始时间跑到结束时间递增  13位
 
 @param starTimeStamp 开始的时间戳 是毫秒
 @param finishTimeStamp 结束的时间戳，是毫秒
 @param completeBlock 已经过了多长时间的字符串，是否已经到时间了
 */

- (void)countDownHasPasstimeWithStratTimeTemThreeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp adjust:(double)adjust completeBlock:(void (^)(NSString *dateStr, BOOL isFinish))completeBlock;


/**
 *  直接传入秒数   10秒倒计时
 *  根据时间间隔进行倒计时,timeout必须是整数，值是秒数
 *
 *  @param timeOut       倒计时时间 秒
 *  @param completeBlock 倒计时回调
 */
- (void)countDownWithTimeout:(NSTimeInterval)timeOut completeBlock:(void (^)(NSString *, BOOL isFinish))completeBlock;


/**
 *  获取当前时间戳有两种方法(以秒为单位)
 *  根据时间间隔进行倒计时
 *
 *
 */
+ (NSString *)getNowTimeTimestampReturnSecond;

/**
 *  获取当前时间戳有两种方法(以毫秒为单位)
 *  根据时间间隔进行倒计时
 *
 *
 */
+ (NSString *)getNowTimeTimestampMillisecond;

@end
