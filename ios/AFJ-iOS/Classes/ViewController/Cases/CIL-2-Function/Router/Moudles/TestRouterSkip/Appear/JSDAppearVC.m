//
//  JSDAppearVC.m
//  JSDRouterGuide
//
//  Created by Jersey on 15/12/2019.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDAppearVC.h"

@interface JSDAppearVC ()

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) void (^callback)(void);
@property(nonatomic, strong) void (^callback2)(NSString *name);
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UIButton *btn;
@property(nonatomic, strong) UIButton *btn2;
@property(nonatomic, strong) UIButton *btn3;
@property(nonatomic, strong) UIButton *btn4;
@property(nonatomic, strong) UILabel *handlerResultLabel;
@property(nonatomic, strong) UILabel *testPushPopIndex;
@property(nonatomic, strong) UIButton *pushButton;
@property(nonatomic, strong) UIButton *popButton;

@end

@implementation JSDAppearVC

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //1.设置导航栏
    [self setupNavBar];
    //2.设置view
    [self setupView];
    //3.请求数据
    [self setupData];
    //5.解析数据
    [self setupAnalyticalData];
    //6.设置通知
    [self setupNotification];
    //7.private
    [self setupPrivateMethod];
}

#pragma mark - 2 SettingView and Style

- (void)setupNavBar {

    self.navigationItem.title = @"测试 Router 跳转,AppearVC 需登陆";
}

- (void)setupView {

    [self.view addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(100);
    }];

    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.textLabel.mas_bottom).mas_equalTo(25);
    }];
    [self.view addSubview:self.btn2];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.btn.mas_bottom).mas_equalTo(25);
    }];

    [self.view addSubview:self.handlerResultLabel];
    [self.handlerResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.btn2.mas_bottom).mas_equalTo(50);
    }];

    [self.view addSubview:self.btn3];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.handlerResultLabel.mas_bottom).mas_equalTo(25);
    }];

    [self.view addSubview:self.btn4];
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.btn3.mas_bottom).mas_equalTo(25);
    }];

    [self reloadingView];
}

- (void)reloadingView {

    if (self.name) {
        self.textLabel.text = [NSString stringWithFormat:@"接收到的参数: name--%@", self.name];
        NSLog(@"%s, 接收到参数 Name: %@", __func__, self.name);
    } else {
        self.textLabel.text = @"无参数";
    }
}

#pragma mark - 3 Request Data

- (void)setupData {


}

#pragma mark - 4 UITableViewDataSource and UITableViewDelegate
#pragma mark - 5 Event Response

- (void)onTouchHandle:(UIButton *)sender {

    if (sender.tag == 0) {
        if (self.callback) {
            self.callback();
            self.handlerResultLabel.text = @"已执行回调1";
        } else {
            self.handlerResultLabel.text = @"未接收到回调函数";
        }
    } else if (sender.tag == 1) {
        if (self.callback2) {
            self.callback2(self.name);
            self.handlerResultLabel.text = @"已执行回调2";
        } else {
            self.handlerResultLabel.text = @"未接收到回调函数";
        }
    } else if (sender.tag == 2) {
        [JSDVCRouter openURL:JSDVCRouteAppear];
    } else if (sender.tag == 3) {
        [JSDVCRouter openURL:JSDVCRouteAppear parameters:@{kJSDVCRouteSegue: kJSDVCRouteSegueModal}];
    }
}

- (void)setupAnalyticalData {


}

#pragma mark - 6 Private Methods

- (void)setupNotification {

}

- (void)setupPrivateMethod {


}

#pragma mark - 7 GET & SET

- (UILabel *)textLabel {

    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
    }
    return _textLabel;
}

- (UIButton *)btn {

    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn setTitle:@"执行回调1" forState:UIControlStateNormal];
        _btn.tag = 0;
        [_btn addTarget:self action:@selector(onTouchHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UIButton *)btn2 {

    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn2 setTitle:@"执行回调2" forState:UIControlStateNormal];
        _btn2.tag = 1;
        [_btn2 addTarget:self action:@selector(onTouchHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

- (UIButton *)btn3 {

    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn3 setTitle:@"Push到下一个 AppearVC" forState:UIControlStateNormal];
        _btn3.tag = 2;
        [_btn3 addTarget:self action:@selector(onTouchHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}

- (UIButton *)btn4 {

    if (!_btn4) {
        _btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn4 setTitle:@"Modal到下一个 AppearVC" forState:UIControlStateNormal];
        _btn4.tag = 3;
        [_btn4 addTarget:self action:@selector(onTouchHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn4;
}

- (UILabel *)handlerResultLabel {

    if (!_handlerResultLabel) {
        _handlerResultLabel = [[UILabel alloc] init];

    }
    return _handlerResultLabel;
}

- (UIButton *)pushButton {


    return nil;
}


@end

