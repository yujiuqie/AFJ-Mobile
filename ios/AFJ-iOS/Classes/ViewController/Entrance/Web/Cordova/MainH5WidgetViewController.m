//
//  MainH5WidgetViewController.m
//  LastCordova
//
//  Created by hsm on 2019/5/14.
//  Copyright © 2019年 SM. All rights reserved.
//
#import "MainH5WidgetViewController.h"
#import <WebKit/WebKit.h>

@interface MainH5WidgetViewController ()

@end

@implementation MainH5WidgetViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
//        self.wwwFolderName = @"www";
        self.startPage = @"https://www.baidu.com";
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - extension delegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    // View defaults to full size.  If you want to customize the view's size, or its subviews (e.g. webView),
    // you can do so here.

    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view from its nib.
//        if(![kLoadModel isEqualToString:@"offline"]){
//            [self.webViewEngine loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kDomainUrl]]];
//        }
    [self.webViewEngine loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://122.51.132.117/"]]];
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *filePath = [bundle pathForResource:@"index" ofType:@"html"];
//    NSString *fileStr = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    [self.webViewEngine loadHTMLString:fileStr baseURL:nil];
}

/* Comment out the block below to over-ride */

/*
 - (UIWebView*) newCordovaViewWithFrame:(CGRect)bounds
 {
 return[super newCordovaViewWithFrame:bounds];
 }
 
 // CB-12098
 #if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
 - (NSUInteger)supportedInterfaceOrientations
 #else
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations
 #endif
 {
 return [super supportedInterfaceOrientations];
 }
 
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
 {
 return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
 }
 
 - (BOOL)shouldAutorotate
 {
 return [super shouldAutorotate];
 }
 */
@end
