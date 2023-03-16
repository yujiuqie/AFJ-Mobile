//
//  Config.m
//  Frame
//
//  Created by 冯汉栩 on 2021/5/18.
//

#import "Config.h"

@implementation Config

/** 获取BundleIdentifier */
+ (NSString *)getBundleIdentifier {
    return [NSBundle mainBundle].bundleIdentifier;
}

/** 当前app的信息 */
+ (NSDictionary *)getAppMessage {
    return [[NSBundle mainBundle] infoDictionary];
}

/** app名称 */
+ (NSString *)getAppName {
    NSString *displayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    NSString *bundleName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    return displayName ? displayName : bundleName;
}

/** app版本 */
+ (NSString *)getAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/** app build版本 */
+ (NSString *)getAppBuildVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

/** 手机别名： 用户定义的名称 */
+ (NSString *)getAppAliasName {
    return [[UIDevice currentDevice] name];
}

/** 手机系统 */
+ (NSString *)getSystemName {
    return [[UIDevice currentDevice] systemName];
}

/** 手机系统版本 */
+ (NSString *)getSystemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

/** 手机牌子 */
+ (NSString *)getLocalizedModel {
    return [[UIDevice currentDevice] localizedModel];
}

/** 手机型号 将来有新的手机型号出现可到 https://www.theiphonewiki.com/wiki/Models 查阅  添加 */
+ (NSString *)getCurrentDeviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);

    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];


    if ([deviceModel isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"]) return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"]) return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"]) return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"]) return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([deviceModel isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([deviceModel isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([deviceModel isEqualToString:@"iPhone12,8"]) return @"iPhone SE2";
    if ([deviceModel isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([deviceModel isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([deviceModel isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([deviceModel isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    if ([deviceModel isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"]) return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"]) return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"]) return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"]) return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"]) return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"]) return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"]) return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"]) return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"]) return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"]) return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"]) return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"]) return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"]) return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"]) return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"]) return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"]) return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"]) return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";

    if ([deviceModel isEqualToString:@"AppleTV2,1"]) return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"]) return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"]) return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"]) return @"Apple TV 4";

    if ([deviceModel isEqualToString:@"i386"]) return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"]) return @"Simulator";

    return deviceModel;
}


@end
