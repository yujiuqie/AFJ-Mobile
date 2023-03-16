//
//  AFJLogManager.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/12.
//

#import "AFJLogManager.h"

@implementation AFJLogManager

+ (instancetype)sharedInstance {
    static AFJLogManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[AFJLogManager alloc] init];
    });

    return shared;
}

- (void)updateLogs:(NSArray<AFJSystemLogMessage *> *)newMessages {
    AFJSystemLogMessage *msg = [newMessages lastObject];

    if (![msg.messageText hasPrefix:@"[AFJ-iOS-Log]"]) {
        return;
    }

    if (!_logs) {
        _logs = [NSMutableArray array];
    }

    AFJLog *product = [[AFJLog alloc] init];
    product.title = [NSString stringWithFormat:@"%@ [AFJ-iOS-Log]  %@", msg.date, [msg.messageText substringFromIndex:13]];

    [self.logs addObject:product];
}

@end
