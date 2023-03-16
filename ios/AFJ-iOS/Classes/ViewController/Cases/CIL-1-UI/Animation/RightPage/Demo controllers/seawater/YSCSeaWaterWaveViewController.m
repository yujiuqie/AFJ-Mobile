//
//  YSCSeaWaterWaveViewController.m
//  YSCAnimationDemo
//
//  Created by yushichao on 16/8/24.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import "YSCSeaWaterWaveViewController.h"
#import "YSCSeaGLView.h"

@interface YSCSeaWaterWaveViewController () <UINavigationBarDelegate>

@property(nonatomic, strong) YSCSeaGLView *seaGLView;

@end

@implementation YSCSeaWaterWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//
//    self.seaGLView = [[YSCSeaGLView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
////    [self.view addSubview:_seaGLView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
//    [_seaGLView removeFromParent];
//    _seaGLView = nil;
}


@end
