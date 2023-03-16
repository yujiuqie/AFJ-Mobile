//
//  AFJFlutterUnitViewController.m
//  AFJ-iOS
//
//  Created by alfred on 2023/3/16.
//

#import "AFJFlutterUnitViewController.h"
#import <FlutterPluginRegistrant-umbrella.h>
#import "AFJFlutterViewController.h"
#import <Flutter/Flutter.h>

@interface AFJFlutterUnitViewController ()

@property (nonatomic, strong) FlutterViewController *flutterVC;
@property(nonatomic, strong) FlutterBasicMessageChannel * msgChannel;


@end

@implementation AFJFlutterUnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.flutterVC = [[FlutterViewController alloc] initWithEngine:[kAppDelegate flutterEngine] nibName:nil bundle:nil];
    [self addChildViewController:self.flutterVC];
    [self.view addSubview:self.flutterVC.view];
    self.flutterVC.view.frame = self.view.bounds;
    
    self.msgChannel = [FlutterBasicMessageChannel messageChannelWithName:@"messageChannel" binaryMessenger:self.flutterVC.binaryMessenger];
    
    [self.msgChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        NSLog(@"收到Flutter的：%@",message);
    }];
}

@end
