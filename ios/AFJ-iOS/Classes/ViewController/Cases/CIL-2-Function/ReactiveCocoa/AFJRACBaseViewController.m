//
//  AFJRACBaseViewController.m
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/20.
//

#import "AFJRACBaseViewController.h"

@interface AFJRACBaseViewController ()

@property(weak, nonatomic) IBOutlet UIButton *button;
@property(weak, nonatomic) IBOutlet UITextField *textField;
@property(weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation AFJRACBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 第1种：在调用一个方法后发送订阅
    // RAC方法:可以判断下某个方法有没有调用
    // 只要self调用Selector就会产生一个信号
    // rac_signalForSelector:监听某个对象调用某个方法
    [[self rac_signalForSelector:@selector(didReceiveMemoryWarning)] subscribeNext:^(id x) {
        NSLog(@"控制器调用了didReceiveMemoryWarning");
    }];

    // 第2种：代替代理
    [[self rac_signalForSelector:@selector(scrollViewDidScroll:) fromProtocol:@protocol(UIScrollViewDelegate)] subscribeNext:^(id x) {
        // 打印
    }];

    // 第3种：代替KVO
    // rac_valuesAndChangesForKeyPath：用于监听某个对象的属性改变
    [[self.button rac_valuesAndChangesForKeyPath:@keypath(self.button, selected) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld observer:self] subscribeNext:^(id x) {
        // 只要监听的属性一改变调用,
        // observer为self, self.button销毁或者self销毁, 信号就会停止监听
        NSLog(@"按钮状态改变了");
    }];

    // KVO:第二种,只监听新值的改变
    [[self.button rac_valuesForKeyPath:@keypath(self.button, selected) observer:nil] subscribeNext:^(id x) {
        // observer为nil, self.button销毁, 信号就会停止监听
        NSLog(@"按钮状态改变了2");
    }];

    // 第4种：监听UIControl事件
    // rac_signalForControlEvents：用于监听某个事件
    // 只要按钮产生这个事件,就会产生一个信号
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"按钮被点击%@", x);
    }];

    self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [self showToastWithMessage:@"按钮点击，请检查日志信息"];
        return [RACSignal empty];
    }];


    // 第5种：代替通知
    // rac_addObserverForName:用于监听某个通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];

    // 第6种：监听文本框文字改变
    // rac_textSignal:只要文本框发出改变就会发出这个信号
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        // x:文本框的文字
        NSLog(@"%@", x);
        self.label.text = x;
    }];
}

// ReactiveCocoa常见宏
- (void)test9 {

    // RAC(TARGET, [KEYPATH, [NIL_VALUE]]):用于给某个对象的某个属性绑定
    // 给某个对象的某个属性绑定一个信号,只要产生信号,就会把信号的内容给对象的属性赋值
    RACSignal *s1 = [self.button rac_signalForControlEvents:UIControlEventTouchUpInside];
    RACSignal *s2 = [s1 filter:^BOOL(UIButton *value) {
        if (value.selected) {
            return NO;
        } else {
            return YES;
        }
    }];
    RACSignal *s3 = [s2 map:^id(id value) {
        return @"123";
    }];

    RAC(self.textField, text) = s3;

//    // RACObserve(self, name):监听某个对象的某个属性,返回的是信号
//    // 观察某个对象某个属性
//    // 使用RACObserve观察属性时，会立即将属性当前值sendNext.
//    [RACObserve(self.textField, text) subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
}

@end
