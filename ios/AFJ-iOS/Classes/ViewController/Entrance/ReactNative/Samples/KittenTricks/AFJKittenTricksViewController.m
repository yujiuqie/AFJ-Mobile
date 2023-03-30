//
//  AFJKittenTricksViewController.m
//  AFJ-iOS
//
//  Created by alfred on 2023/3/16.
//

#import "AFJKittenTricksViewController.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "SplashScreen.h"

@interface AFJKittenTricksViewController ()

@end

@implementation AFJKittenTricksViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self initRCTRootView];
}

- (void)initRCTRootView {
    NSURL *jsCodeLocation;

//     jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"]; //手动拼接jsCodeLocation用于开发环境 //jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"]; //release之后从包中读取名为main的静态js bundle

    //    TODO:: RN 发布 npm run build
    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"rn-sample-1" withExtension:@"jsbundle"];
    //    TODO:: RN 调试 npm run start
//    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];

    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"RNSample1"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    
//    [SplashScreen open:rootView];
    
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    
    self.view = rootView;
}


@end
