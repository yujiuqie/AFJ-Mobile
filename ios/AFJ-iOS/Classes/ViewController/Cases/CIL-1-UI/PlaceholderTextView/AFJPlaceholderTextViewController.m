//
//  AFJPlaceholderTextViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/3.
//

#import "AFJPlaceholderTextViewController.h"
#import "PlaceholderAndLimitTextView.h"
#import "NerdyUI.h"

@interface AFJPlaceholderTextViewController ()
        <
        PlaceholderAndLimitTextViewDelegate
        >

@property(nonatomic, strong) PlaceholderAndLimitTextView *textView;

@end

@implementation AFJPlaceholderTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView = [PlaceholderAndLimitTextView new];
    self.textView.addTo(self.view).borderRadius(8).xywh(15, StatusBarAndNavigationBarHeight, Phone_Width - 30, 200);
    self.textView.placeholder = @"写下您宝贵的建议，我们将尽快处理";
    self.textView.placeholderColor = [Color nonActivated];
    self.textView.placeholderFont = [UIFont systemFontOfSize:16];
    self.textView.placeholderTopDistance = 15;
    self.textView.placeholderLeftDistance = 20;
    self.textView.bgColor = [Color backgroung];
    self.textView.contentFont = [UIFont systemFontOfSize:16];
    self.textView.limitFont = [UIFont systemFontOfSize:16];
    self.textView.limitColor = [Color nonActivated];
    self.textView.limitCurrentCount = 0;
    self.textView.limitAllCount = 10;
    self.textView.delegate = self;
}


- (void)placeholderAndLimitTextView:(nonnull PlaceholderAndLimitTextView *)textView returnCurrentValue:(nonnull NSString *)value {
    NSLog(@"returnCurrentValue : %@", value);
}

@end
