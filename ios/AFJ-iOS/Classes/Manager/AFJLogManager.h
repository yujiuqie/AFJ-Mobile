//
//  AFJLogManager.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/12.
//

#import <Foundation/Foundation.h>
#import "AFJSystemLogMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJLogManager : NSObject

@property(nonatomic, strong) NSMutableArray *logs;

+ (instancetype)sharedInstance;

- (void)updateLogs:(NSArray<AFJSystemLogMessage *> *)newMessages;

@end

NS_ASSUME_NONNULL_END
