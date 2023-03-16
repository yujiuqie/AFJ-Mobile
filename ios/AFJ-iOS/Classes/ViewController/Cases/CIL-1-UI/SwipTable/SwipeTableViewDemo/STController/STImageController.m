//
//  STImageController.m
//  SwipeTableView
//
//  Created by Roy lee on 16/6/24.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

#import "STImageController.h"
#import "UIView+STFrame.h"

@interface STImageController ()

@end

@implementation STImageController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.imageView = [[UIImageView alloc] init];
    _imageView.st_width = [UIScreen mainScreen].bounds.size.width;
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapImageView:(UITapGestureRecognizer *)tap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
