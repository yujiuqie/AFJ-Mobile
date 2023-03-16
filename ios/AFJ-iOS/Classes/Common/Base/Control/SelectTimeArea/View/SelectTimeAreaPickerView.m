//
//  SelectTimeAreaPickerView.m
//  Frame
//
//  Created by 冯汉栩 on 16/8/13.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import "SelectTimeAreaPickerView.h"

@interface SelectTimeAreaPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

//所有的时间
@property(nonatomic, strong) NSArray *times;
//回调
@property(nonatomic, copy) void (^complete)(NSString *, NSString *);

@end

@implementation SelectTimeAreaPickerView

+ (instancetype)SelectTimeAreaViewWithcomplete:(void (^)(NSString *startStr, NSString *endStr))completion {

    SelectTimeAreaPickerView *pickerView = [[SelectTimeAreaPickerView alloc] init];
    pickerView.complete = completion;

    ///初始化选中的时间
    [pickerView selectRow:9 inComponent:0 animated:YES];
    [pickerView selectRow:17 inComponent:2 animated:YES];

    //初始化先刷新一次时间
    [pickerView putOutData];
    return pickerView;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsSelectionIndicator = YES;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 1) {
        return 1;
    }
    return self.times.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 1) {
        return @"至";
    }
    return self.times[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self putOutData];
}

///传出数据
- (void)putOutData {
    NSString *start = self.times[[self selectedRowInComponent:0]];
    NSString *end = self.times[[self selectedRowInComponent:2]];
    //被选中时，调用block把值传出去
    self.complete(start, end);
}

- (NSArray *)times {
    if (_times != nil) {
        return _times;
    }
    NSArray *object = [[NSArray alloc] initWithObjects:@"00:00", @"01:00", @"02:00", @"03:00", @"04:00", @"05:00", @"06:00", @"07:00", @"08:00", @"09:00", @"10:00", @"11:00", @"12:00", @"13:00", @"14:00", @"15:00", @"16:00", @"17:00", @"18:00", @"19:00", @"20:00", @"21:00", @"22:00", @"23:00", nil];

    _times = object;
    return _times;
}
@end
