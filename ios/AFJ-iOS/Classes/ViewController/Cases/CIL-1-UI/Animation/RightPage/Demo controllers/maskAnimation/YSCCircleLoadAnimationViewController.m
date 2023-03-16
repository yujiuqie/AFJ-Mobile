//
//  YSCCircleLoadAnimationViewController.m
//  YSCAnimationDemo
//
//  Created by yushichao on 16/8/24.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import "YSCCircleLoadAnimationViewController.h"
#import "YSCCircleLoadAnimationView.h"

@interface YSCCircleLoadAnimationViewController ()

@end

@implementation YSCCircleLoadAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    YSCCircleLoadAnimationView *shapeView = [[YSCCircleLoadAnimationView alloc] initWithFrame:self.view.bounds];
    UIImage *image = [UIImage imageNamed:@"tree.jpg"];
    shapeView.loadingImage.image = image;
    [self.view addSubview:shapeView];
    [shapeView startLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
