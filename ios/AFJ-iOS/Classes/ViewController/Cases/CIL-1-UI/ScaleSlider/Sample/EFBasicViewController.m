//
//  EFBasicViewController.m
//  EFCircularSlider
//
//  Created by Eliot Fowler on 12/4/13.
//  Copyright (c) 2013 Eliot Fowler. All rights reserved.
//

#import "EFBasicViewController.h"
#import "EFCircularSlider.h"

@interface EFBasicViewController ()

@end

@implementation EFBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect sliderFrame = CGRectMake((SCREENW - 200) / 2.0, 150, 200, 200);
    EFCircularSlider *circularSlider = [[EFCircularSlider alloc] initWithFrame:sliderFrame];
    [circularSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:circularSlider];
    [circularSlider setCurrentValue:10.0f];

    {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREENW - 200) / 2.0, 380, 200, 180)];
        _valueLabel.numberOfLines = 0;
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_valueLabel];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIViewController popGestureClose:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIViewController popGestureOpen:self];
}

- (void)valueChanged:(EFCircularSlider *)slider {
    _valueLabel.text = [NSString stringWithFormat:@"%.02f", slider.currentValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
