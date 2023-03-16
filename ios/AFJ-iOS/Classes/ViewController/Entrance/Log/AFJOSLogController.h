//
//  AFJOSLogController.h
//  AFJ
//
//  Created by Tanner on 12/19/18.
//  Copyright © 2020 AFJ Team. All rights reserved.
//

#import "AFJLogController.h"

#define AFJOSLogAvailable() (NSProcessInfo.processInfo.operatingSystemVersion.majorVersion >= 10)

/// The log controller used for iOS 10 and up.
@interface AFJOSLogController : NSObject <AFJLogController>

+ (instancetype)withUpdateHandler:(void (^)(NSArray<AFJSystemLogMessage *> *newMessages))newMessagesHandler;

- (BOOL)startMonitoring;

/// Whether log messages are to be recorded and kept in-memory in the background.
/// You do not need to initialize this value, only change it.
@property(nonatomic) BOOL persistent;
/// Used mostly internally, but also used by the log VC to persist messages
/// that were created prior to enabling persistence.
@property(nonatomic) NSMutableArray<AFJSystemLogMessage *> *messages;

@end
