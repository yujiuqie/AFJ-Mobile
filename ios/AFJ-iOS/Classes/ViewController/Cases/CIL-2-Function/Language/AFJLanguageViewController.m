//
//  AFJLanguageViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/16.
//

#import "AFJLanguageViewController.h"
#import "HXPreferenceViewController.h"
#import "HXLanguageManager.h"

@interface AFJLanguageViewController ()

@property(strong, nonatomic) UILabel *titleLabel;

@end

@implementation AFJLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 600, 60)];
    [self.view addSubview:self.titleLabel];

    //注册通知，用于接收改变语言的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:ChangeLanguageNotificationName object:nil];

    [self changeLanguage];
}

//改变语言界面刷新
- (void)changeLanguage {
    self.title = kLocalizedString(@"home", @"首页");

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:kLocalizedString(@"preference", @"偏好") style:UIBarButtonItemStyleDone target:self action:@selector(gotoPreferenceViewController)];
    self.navigationItem.rightBarButtonItem = item;

    _titleLabel.text = kLocalizedString(@"welcome", @"你好 世界!");
}

#pragma mark - goto

//去偏好设置界面
- (void)gotoPreferenceViewController {
    HXPreferenceViewController *vc = [HXPreferenceViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
