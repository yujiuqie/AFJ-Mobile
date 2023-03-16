//
//  AFJLogController.h
//  AFJ
//
//  Created by Tanner on 3/17/19.
//  Copyright © 2020 AFJ Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFJSystemLogMessage.h"

@protocol AFJLogController <NSObject>

/// Guaranteed to call back on the main thread.
+ (instancetype)withUpdateHandler:(void (^)(NSArray<AFJSystemLogMessage *> *newMessages))newMessagesHandler;

- (BOOL)startMonitoring;

@end
