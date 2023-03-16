//
//  ZJTest1ViewController.m
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/6/30.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTest1ViewController.h"
#import "ZJScrollPageView.h"

@interface ZJTest1ViewController ()

@end

@implementation ZJTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    testBtn.backgroundColor = [UIColor whiteColor];
    [testBtn setTitle:@"点击" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(testBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:testBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 使用系统的生命周期方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear------%ld", self.zj_currentIndex);

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear-----%ld", self.zj_currentIndex);

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear-----%ld", self.zj_currentIndex);

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear--------%ld", self.zj_currentIndex);

}


- (void)testBtnOnClick:(UIButton *)sender {

    if (_click) {
        _click();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
