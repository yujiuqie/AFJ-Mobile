//
//  Config.h
//  Frame
//
//  Created by 冯汉栩 on 2021/5/18.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>//要导入头文件
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Config : NSObject

/** 获取BundleIdentifier */
+ (NSString *)getBundleIdentifier;

/** 当前app的信息 */
+ (NSDictionary *)getAppMessage;

/** app名称 */
+ (NSString *)getAppName;

/** app版本 */
+ (NSString *)getAppVersion;

/** app build版本 */
+ (NSString *)getAppBuildVersion;

/** 手机别名： 用户定义的名称 */
+ (NSString *)getAppAliasName;

/** 手机系统 */
+ (NSString *)getSystemName;

/** 手机系统版本 */
+ (NSString *)getSystemVersion;

/** 手机牌子 */
+ (NSString *)getLocalizedModel;

/** 手机型号 将来有新的手机型号出现可到 https://www.theiphonewiki.com/wiki/Models 查阅  添加 */
+ (NSString *)getCurrentDeviceModel;


@end

NS_ASSUME_NONNULL_END
