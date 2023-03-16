//
//  SelectTimeAreaTankuangView.m
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import "SelectTimeAreaTankuangView.h"
//#import "Masonry.h"
#import "FHXConfirmView.h"
#import "SelectTimeAreaPickerView.h"

@interface SelectTimeAreaTankuangView ()

@property(nonatomic, weak) FHXConfirmView *titleView;
@property(nonatomic, weak) SelectTimeAreaPickerView *TimeSelectView;

@property(nonatomic, strong) void (^confirm)(NSString *startStr, NSString *endStr);
@property(nonatomic, strong) void (^cancel)(void);

@property(nonatomic, copy) NSString *startStr;
@property(nonatomic, copy) NSString *endStr;

@end

@implementation SelectTimeAreaTankuangView

#pragma mark ------ 初始化

+ (instancetype)SelectTimeAreaTankuangViewWithConfirm:(void (^)(NSString *startStr, NSString *endStr))confirm cancel:(void (^)(void))cancel {

    SelectTimeAreaTankuangView *dateView = [[self alloc] init];

    dateView.confirm = confirm;
    dateView.cancel = cancel;

    return dateView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

#pragma mark ------ 私有方法

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.titleView];
    [self addSubview:self.TimeSelectView];

//    [self setConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setConstraints];
}

- (void)setConstraints {

    [self.titleView setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];

    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];

    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:50];

    [self addConstraints:@[leftConstraint, topConstraint, rightConstraint, heightConstraint]];

//    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.top.trailing.equalTo(self);
//        make.height.mas_equalTo(50);
//    }];

//  self.TimeSelectView.dateViewLeft = self.dateViewLeft+40;
//  self.TimeSelectView.dateViewTop = self.titleView.dateViewBottom;
//  self.TimeSelectView.dateViewWidth = self.dateViewWidth-80;
//  self.TimeSelectView.dateViewHeight = self.dateViewHeight;

    self.TimeSelectView.frame = CGRectMake(40, 50, self.bounds.size.width - 80, self.bounds.size.height);

//    [self.TimeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleView.mas_bottom);
//        make.leading.equalTo(self).offset(40);
//        make.trailing.equalTo(self).offset(-40);
//        make.bottom.equalTo(self);
//    }];

}

#pragma mark ---- 懒加载

- (FHXConfirmView *)titleView {
    if (_titleView != nil) {
        return _titleView;
    }
    FHXConfirmView *view = [FHXConfirmView ConfirmViewwithConfirm:^{
        self.confirm(self.startStr, self.endStr);
    }                                                      cancel:^{
        self.cancel();
    }];

    _titleView = view;
    return _titleView;
}

- (SelectTimeAreaPickerView *)TimeSelectView {
    if (_TimeSelectView != nil) {
        return _TimeSelectView;
    }
    SelectTimeAreaPickerView *view = [SelectTimeAreaPickerView SelectTimeAreaViewWithcomplete:^(NSString *startStr, NSString *endStr) {
        self.startStr = startStr;
        self.endStr = endStr;
    }];
    _TimeSelectView = view;
    return _TimeSelectView;
}

@end

