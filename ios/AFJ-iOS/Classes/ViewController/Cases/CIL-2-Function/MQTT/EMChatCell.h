//
//  EMChatCellNew.h
//  MQTTChat
//
//  Created by liujinliang on 2021/7/22.
//  Copyright © 2021 Owntracks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EMChatCell : UITableViewCell
@property(strong, nonatomic) UILabel *messageLabel;

+ (NSString *)indentifier;

@end

NS_ASSUME_NONNULL_END
