//
//  AFJRNLocalBundleViewController.m
//  AFJ-iOS
//
//  Created by alfred on 2023/3/23.
//

#import "AFJRNLocalBundleViewController.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "SplashScreen.h"

@interface AFJRNLocalBundleViewController ()

@property (nonatomic, strong) NSString *bundle;
@property (nonatomic, strong) NSString *module;

@end

@implementation AFJRNLocalBundleViewController

- (instancetype)initRNLocalWith:(NSString *)bundle module:(NSString *)module
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
    NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:self.bundle withExtension:@"jsbundle"];

    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:self.module
                                                 initialProperties:nil
                                                     launchOptions:nil];
    
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    
    self.view = rootView;
}

@end
