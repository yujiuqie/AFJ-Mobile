//
//  FHXDatePickerView.m
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import "FHXDateWithTimePickerView.h"

@interface FHXDateWithTimePickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
//选中年
@property(nonatomic, assign) NSInteger year;

//选中月
@property(nonatomic, assign) NSInteger month;

//选中日
@property(nonatomic, assign) NSInteger day;

//选中日
@property(nonatomic, assign) NSInteger hour;

//选中日
@property(nonatomic, assign) NSInteger minute;

@property(nonatomic, copy) NSString *outputFormatter;

@property(nonatomic, strong) NSDictionary *attributeDict;

//回调
@property(nonatomic, copy) void (^complete)(NSString *);

@end

@implementation FHXDateWithTimePickerView

+ (instancetype)datePickerViewWithformatter:(NSString *)outputFormatter complete:(void (^)(NSString *outputStr))completion {

    FHXDateWithTimePickerView *pickerView = [[FHXDateWithTimePickerView alloc] init];
    pickerView.outputFormatter = outputFormatter;
    pickerView.complete = completion;
    [pickerView setshowDateWithString:nil formatter:nil];
    //初始化先刷新一次时间
    [pickerView reloadData];
    return pickerView;

}

+ (instancetype)datePickerViewWithdateString:(NSString *)dateStr formatter:(NSString *)inputFormatter outputFormatter:(NSString *)outputFormatter complete:(void (^)(NSString *outputStr))completion {
    FHXDateWithTimePickerView *pickerView = [[FHXDateWithTimePickerView alloc] init];
    pickerView.complete = completion;
    pickerView.outputFormatter = outputFormatter;
    [pickerView setshowDateWithString:dateStr formatter:inputFormatter];
//    //初始化先刷新一次时间
    [pickerView reloadData];
    return pickerView;

}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsSelectionIndicator = YES;
        self.delegate = self;
        self.dataSource = self;
        self.leastYear = 1900;
        self.years = 200;

    }
    return self;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (component == 0) {
        return self.years;
    }
    if (component == 1) {
        return 12;
    }
    if (component == 2) {
        //这里不能直接用self.year 和self.month,可能导致self.day 不显示
        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.leastYear;
        NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;
        return [NSCalendar getDaysWithYear:yearSelected month:monthSelected];
    }
    if (component == 3) {
        return 24;
    }
    return 60;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *myView = nil;

    CGFloat width = component == 3 ? [UIScreen mainScreen].bounds.size.width * 0.4 : [UIScreen mainScreen].bounds.size.width * 0.4;

    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 30)];

    myView.textAlignment = NSTextAlignmentCenter;
    myView.backgroundColor = [UIColor clearColor];

    NSString *string = nil;
    if (component == 0) {
        string = [NSString stringWithFormat:@"%ld年", self.leastYear + row];
    }
    if (component == 1) {
        string = [NSString stringWithFormat:@"%ld月", row + 1];
    }
    if (component == 2) {
        string = [NSString stringWithFormat:@"%ld日", row + 1];
    }
    if (component == 3) {
        string = [NSString stringWithFormat:@"%ld : 00", row];
    }

    myView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:self.attributeDict];

    return myView;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 3) {
        return [UIScreen mainScreen].bounds.size.width * 0.4;
    } else {
        return [UIScreen mainScreen].bounds.size.width * 0.2;
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 1) {
        [self reloadComponent:2];
    }
    [self reloadData];
}

- (void)reloadData {
    self.year = [self selectedRowInComponent:0] + self.leastYear;
    self.month = [self selectedRowInComponent:1] + 1;
    self.day = [self selectedRowInComponent:2] + 1;
    self.hour = [self selectedRowInComponent:3];
//    self.minute = [self selectedRowInComponent:4];
    self.minute = 0;

    NSString *outputStr = [self dateStringWithformatter:self.outputFormatter];
    //被选中时，调用block把值传出去
    self.complete(outputStr);
}

//选中时输出时间
- (NSString *)dateStringWithformatter:(NSString *)formatter {
    return [self dateStringWithYear:self.year month:self.month day:self.day hour:self.hour minute:self.minute formatter:formatter];
}

- (NSString *)dateStringWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute formatter:(NSString *)formatter {
    NSDateComponents *component = [[NSDateComponents alloc] init];
    component.year = year;
    component.month = month;
    component.day = day;
    component.hour = hour;
    component.minute = minute;
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [calendar dateFromComponents:component];
    return [NSCalendar datestringWithDate:date formatterStr:formatter];
}

//创建时,设置显示时间
- (void)setshowDateWithString:(NSString *)dateStr formatter:(NSString *)formatter {
    NSDate *date;
    if (dateStr == nil) {
        date = [NSDate date];
    } else {
        date = [NSCalendar dateWithDatestring:dateStr formatterStr:formatter];
    }
    NSDateComponents *component = [NSCalendar componentsFromDate:date];
    self.year = component.year;
    self.month = component.month;
    self.day = component.day;
    self.hour = component.hour;
    self.minute = 0;
    [self selectRow:(component.year - self.leastYear) inComponent:0 animated:YES];
    [self selectRow:(component.month - 1) inComponent:1 animated:YES];
    [self selectRow:(component.day - 1) inComponent:2 animated:YES];
    [self selectRow:(component.hour) inComponent:3 animated:YES];
//    [self selectRow:(component.minute) inComponent:4 animated:YES];
}

#pragma mark ---- 懒加载

- (NSDictionary *)attributeDict {
    if (_attributeDict != nil) {
        return _attributeDict;
    }
    CGFloat fontSize = 14;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (height >= 812) {
        fontSize = 15;
    }
    if (width == 320) {
        fontSize = 12;
    }

    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName: [UIColor colorWithRed:51.f / 255.0 green:51.f / 255.0 blue:51.f / 255.0 alpha:1]};

    _attributeDict = dict;
    return _attributeDict;
}
@end
