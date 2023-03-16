//  ----------------------------------------------------------------------
//  Copyright (C) 2021  即时通讯网(52im.net) & Jack Jiang.
//  The MobileIMSDK_UDP (MobileIMSDK v6.x UDP版) Project.
//  All rights reserved.
//
//  > Github地址: https://github.com/JackJiang2011/MobileIMSDK
//  > 文档地址:    http://www.52im.net/forum-89-1.html
//  > 技术社区：   http://www.52im.net/
//  > 技术交流群： 215477170 (http://www.52im.net/topic-qqgroup.html)
//  > 作者公众号： “即时通讯技术圈】”，欢迎关注！
//  > 联系作者：   http://www.52im.net/thread-2792-1-1.html
//
//  "即时通讯网(52im.net) - 即时通讯开发者社区!" 推荐开源工程。
//  ----------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "CompletionDefine.h"

@interface AutoReLoginDaemon : NSObject

+ (AutoReLoginDaemon *)sharedInstance;

+ (void)setAUTO_RE_LOGIN_INTERVAL:(int)autoReLoginInterval;

+ (int)getAUTO_RE_LOGIN_INTERVAL;

- (void)stop;

- (void)start:(BOOL)immediately;

- (BOOL)isAutoReLoginRunning;

- (void)setDebugObserver:(ObserverCompletion)debugObserver;

@end
