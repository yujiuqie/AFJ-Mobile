//
//  EMChatCellNew.m
//  MQTTChat
//
//  Created by liujinliang on 2021/7/22.
//  Copyright © 2021 Owntracks. All rights reserved.
//

#import "EMChatCell.h"
#import "Masonry.h"

@implementation EMChatCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self.contentView addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0));
        }];

    }
    return self;
}

+ (NSString *)indentifier {
    return NSStringFromClass([self class]);
}


- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0, 100.0)];
        _messageLabel.textColor = UIColor.blackColor;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.font = [UIFont systemFontOfSize:14.0];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}


@end
