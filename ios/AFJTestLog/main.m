//
//  main.m
//  AFJTestLog
//
//  Created by viktyz on 2022/8/18.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include "fishhook.h"

//申明一个函数指针用于保存原NSLog的真实函数地址
static void (*orig_nslog)(NSString *format, ...);

//NSLog重定向
void redirect_nslog(NSString *format, ...) {
    
    //可以添加自己的处理，比如输出到自己的持久化存储系统中

    //继续执行原来的 NSLog
    va_list va;
    format = [NSString stringWithFormat:@"[hook success]%@",format];
    va_start(va, format);
    NSLogv(format, va);
    va_end(va);
}

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        struct rebinding nslog_rebinding = {"NSLog",redirect_nslog,(void*)&orig_nslog};
        rebind_symbols((struct rebinding[1]){nslog_rebinding}, 1);
        
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
