//
//  AFJRNSampleViewController.m
//  AFJ-iOS
//
//  Created by alfred on 2023/3/23.
//

#import "AFJRNSampleViewController.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "SplashScreen.h"

@interface AFJRNSampleViewController ()

@property (nonatomic, strong) NSString *bundle;
@property (nonatomic, strong) NSString *module;

@end

@implementation AFJRNSampleViewController

- (instancetype)initRNSampleWith:(NSString *)bundle module:(NSString *)module
{
    self = [super init];
    if(self){
        _bundle = bundle;
        _module = module;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self initRCTRootView];
}

- (void)initRCTRootView {
    NSURL *jsCodeLocation;

//    jsCodeLocation = [NSURL URLWithString:@"http://www.jhfs.fun:8000/afj-mobile/rn_jsbundle/rn-sample-1.js"];
    jsCodeLocation = [NSURL URLWithString:self.bundle];
//
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
//                                                        moduleName:@"RNSample1"
//                                                 initialProperties:nil
//                                                     launchOptions:nil];

//    TODO:: RN 发布 npm run build
//    jsCodeLocation = [[NSBundle mainBundle] URLForResource:self.bundle withExtension:@"jsbundle"];

    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:self.module
                                                 initialProperties:nil
                                                     launchOptions:nil];
    
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    
    self.view = rootView;
}

@end
