//  ----------------------------------------------------------------------
//  Copyright (C) 2020  即时通讯网(52im.net) & Jack Jiang.
//  The MobileIMSDK_X (MobileIMSDK v4.x) Project.
//  All rights reserved.
//
//  > Github地址: https://github.com/JackJiang2011/MobileIMSDK
//  > 文档地址:    http://www.52im.net/forum-89-1.html
//  > 技术社区：   http://www.52im.net/
//  > 技术交流群： 320837163 (http://www.52im.net/topic-qqgroup.html)
//  > 作者公众号： “即时通讯技术圈”，欢迎关注！
//  > 联系作者：   http://www.52im.net/thread-2792-1-1.html
//
//  "即时通讯网(52im.net) - 即时通讯开发者社区!" 推荐开源工程。
//  ----------------------------------------------------------------------

#import "UDPUtils.h"

@implementation UDPUtils

+ (BOOL)send:(MBGCDAsyncUdpSocket *)skt withData:(NSData *)d {
    BOOL sendSucess = YES;
    if (skt != nil && d != nil) {
        if ([skt isConnected]) {
            [skt sendData:d withTimeout:-1 tag:0];
        }
    } else {
        NSLog(@"【IMCORE-UDP】在send()UDP数据报时没有成功执行，原因是：skt==null || d == null!");
    }

    return sendSucess;
}

@end
