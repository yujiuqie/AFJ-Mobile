//
//  ZFOtherCell.m
//  ZFPlayer_Example
//
//  Created by 任子丰 on 2018/6/21.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFOtherCell.h"

@interface ZFOtherCell ()

@end

@implementation ZFOtherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.text = @"这是非视频类型cell";
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
