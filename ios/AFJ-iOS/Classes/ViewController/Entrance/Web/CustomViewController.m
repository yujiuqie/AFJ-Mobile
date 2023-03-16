//
//  CustomViewController.m
//  JXBWebKitProject
//
//  Created by 金修博 on 2020/5/17.
//  Copyright © 2020 金修博. All rights reserved.
//

#import "CustomViewController.h"
#import <WebKit/WebKit.h>

@interface CustomViewController () <WKUIDelegate, WKNavigationDelegate>
@property(nonatomic, strong) WKWebView *webView;
@end

@implementation CustomViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.webView.frame = self.view.frame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSLog(@"start");
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    NSLog(@"end");
    self.webView = webView;
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];

    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}


@end
