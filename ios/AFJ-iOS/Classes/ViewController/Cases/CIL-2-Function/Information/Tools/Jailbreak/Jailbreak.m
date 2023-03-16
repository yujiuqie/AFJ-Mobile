//
//  Jailbreak.m
//  Frame
//
//  Created by 冯汉栩 on 2021/8/12.
//

#import "Jailbreak.h"

@implementation Jailbreak

+ (BOOL)isJailBreak {

    if ([Jailbreak isJailBreakWithFile]) {
        return YES;//手机越狱
    } else if ([Jailbreak isJailBreakWithOpenCydia]) {
        return YES;//是否能打开cydia判断
    } else if ([Jailbreak isJailBreakWithReadAppList]) {
        return YES;//能读取App所有权限
//    }else if ([Jailbreak isJailBreakWithPath]){
//        return YES;//是否存在环境变量
    } else if ([Jailbreak isJailBreakSimulator]) {
        return YES;//模拟器场景
    }

    return NO;
}

//模拟器场景
+ (BOOL)isJailBreakSimulator {
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        return YES;
    }
    return NO;
}

//判断这些文件是否存在，只要有存在的，就可以认为手机已经越狱了。
+ (BOOL)isJailBreakWithFile {

    NSArray *jailbreak_tool_paths = @[
            @"/Applications/Cydia.app",
            @"/Library/MobileSubstrate/MobileSubstrate.dylib",
            @"/bin/bash",
            @"/usr/sbin/sshd",
            @"/etc/apt"
    ];

    for (int i = 0; i < jailbreak_tool_paths.count; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:jailbreak_tool_paths[i]]) {
            return YES;
        }
    }
    return NO;
}

//根据是否能打开cydia判断
+ (BOOL)isJailBreakWithOpenCydia {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return YES;
    }
    return NO;
}

//根据是否能获取所有应用的名称判断
//没有越狱的设备是没有读取所有应用名称的权限的。

+ (BOOL)isJailBreakWithReadAppList {
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"]) {
        DEBUGLog(@"The device is jail broken!");
        return YES;
    }
    return NO;
}

//根据读取的环境变量是否有值判断
//DYLD_INSERT_LIBRARIES环境变量在非越狱的设备上应该是空的，而越狱的设备基本上都会有Library/MobileSubstrate/MobileSubstrate.dylib
char *printEnv(void) {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    return env;
}

+ (BOOL)isJailBreakWithPath {
    if (printEnv()) {
        return YES;
    }
    return NO;
}

@end
