//
//  FHXConfirmView.m
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import "FHXConfirmView.h"

@interface FHXConfirmView ()
@property(nonatomic, strong) void (^confirm)(void);
@property(nonatomic, strong) void (^cancel)(void);


@end

@implementation FHXConfirmView

+ (instancetype)ConfirmViewwithConfirm:(void (^)(void))confirm cancel:(void (^)(void))cancel {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    FHXConfirmView *view = [[bundle loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    view.confirm = confirm;
    view.cancel = cancel;

    return view;
}

- (IBAction)confirmAction:(UIButton *)sender {
    self.confirm();
}

- (IBAction)cancelAction:(UIButton *)sender {
    self.cancel();
}

@end
