//
//  XPSchooleMateNoView.m
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

//#import "Masonry.h"

#import "FHXConfirmView.h"
#import "FHXDatePickerView.h"
#import "FHXDateWithTimePickerView.h"
#import "FHXDateMonthPickerView.h"

@interface FHXSelectDateTankuangView ()
@property(nonatomic, weak) FHXConfirmView *titleView;
@property(nonatomic, weak) FHXDatePickerView *dateSelectView;
@property(nonatomic, weak) FHXDateWithTimePickerView *TimeSelectView;

@property(nonatomic, weak) FHXDateMonthPickerView *monthSelectView;


@property(nonatomic, strong) void (^confirm)(NSString *dateStr);
@property(nonatomic, strong) void (^cancel)(void);

@property(nonatomic, copy) NSString *dateStr;
@property(nonatomic, assign) showDateType type;

@end

@implementation FHXSelectDateTankuangView

#pragma mark ------ 初始化

+ (instancetype)SelectDateTankuangViewWithShowDateType:(showDateType)showDateType Confirm:(void (^)(NSString *dateStr))confirm cancel:(void (^)(void))cancel {
    FHXSelectDateTankuangView *dateView = [[self alloc] init];

    dateView.confirm = confirm;
    dateView.cancel = cancel;
    dateView.type = showDateType;

    [dateView setUI];

    return dateView;
}

- (instancetype)init {
    if (self = [super init]) {
//        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self setUI];
    }
    return self;
}

#pragma mark ------ 私有方法

- (void)setUI {
    self.backgroundColor = [UIColor clearColor];

    [self addSubview:self.titleView];

    switch (self.type) {
        case showDateTypeMonth:
            [self addSubview:self.monthSelectView];
            break;
        case showDateTypeDay:
            [self addSubview:self.dateSelectView];
            break;
        case showDateTypeHour:
            [self addSubview:self.TimeSelectView];
            break;
        default:
            break;
    }
//    [self addSubview:self.isNeedTime ? self.TimeSelectView : self.dateSelectView];

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

    UIView *timeView = nil;

    switch (self.type) {
        case showDateTypeMonth:
            timeView = self.monthSelectView;
            break;
        case showDateTypeDay:
            timeView = self.dateSelectView;
            break;
        case showDateTypeHour:
            timeView = self.TimeSelectView;
            break;
        default:
            break;
    }

    timeView.frame = CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height);

//  timeView.dateViewLeft = self.dateViewLeft;
//  timeView.dateViewTop = self.titleView.dateViewBottom;
//  timeView.dateViewWidth = self.dateViewWidth;
//  timeView.dateViewHeight = self.dateViewHeight;
//  
//  timeView.bottom = self.bottom;
//  timeView.right = self.right;
//    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleView.mas_bottom);
//        make.leading.equalTo(self);
//        make.trailing.equalTo(self);
//        make.bottom.equalTo(self);
//    }];

}

#pragma mark ---- 懒加载

- (FHXConfirmView *)titleView {
    if (_titleView != nil) {
        return _titleView;
    }
    FHXConfirmView *view = [FHXConfirmView ConfirmViewwithConfirm:^{
        self.confirm(self.dateStr);
    }                                                      cancel:^{
        self.cancel();
    }];

    _titleView = view;
    return _titleView;
}

- (FHXDateWithTimePickerView *)TimeSelectView {
    if (_TimeSelectView != nil) {
        return _TimeSelectView;
    }
    FHXDateWithTimePickerView *object = [FHXDateWithTimePickerView datePickerViewWithformatter:@"yyyy-MM-dd HH:mm" complete:^(NSString *outputStr) {
        self.dateStr = outputStr;
    }];

    _TimeSelectView = object;
    return _TimeSelectView;
}

- (FHXDatePickerView *)dateSelectView {
    if (_dateSelectView != nil) {
        return _dateSelectView;
    }
    FHXDatePickerView *view = [FHXDatePickerView datePickerViewWithformatter:@"yyyy-MM-dd" complete:^(NSString *outputStr) {
        NSLog(@"%@", outputStr);
        self.dateStr = outputStr;
    }];
    _dateSelectView = view;
    return _dateSelectView;
}

- (FHXDateMonthPickerView *)monthSelectView {
    if (_monthSelectView != nil) {
        return _monthSelectView;
    }
    FHXDateMonthPickerView *view = [FHXDateMonthPickerView datePickerViewWithformatter:@"yyyy-MM" complete:^(NSString *outputStr) {
        NSLog(@"%@", outputStr);
        self.dateStr = outputStr;
    }];
    _monthSelectView = view;
    return _monthSelectView;
}

@end
