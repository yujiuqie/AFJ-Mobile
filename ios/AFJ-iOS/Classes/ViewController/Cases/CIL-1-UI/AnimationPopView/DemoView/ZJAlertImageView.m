//
//  ZJAlertImageView.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/3.
//

#import "ZJAlertImageView.h"

@implementation ZJAlertImageView

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
}

- (void)setupImage:(UIImage *)image {
    [self.imageView setImage:image];
}

- (IBAction)canceSureAction:(UIButton *)sender {
    if (self.canceSureActionBlock) {
        self.canceSureActionBlock(sender.tag);
    }
}

@end
