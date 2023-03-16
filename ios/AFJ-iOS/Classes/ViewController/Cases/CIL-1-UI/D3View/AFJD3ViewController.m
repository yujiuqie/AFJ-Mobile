//
//  AFJD3ViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/24.
//

#import "AFJD3ViewController.h"
#import "AFJD3SampleViewController.h"

@interface AFJD3ViewController ()



@end

@implementation AFJD3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    [self setupWebViewWith:nil];
}

- (void)jumpToDemo {
    AFJD3SampleViewController *d3VC = [[AFJD3SampleViewController alloc] initWithNibName:@"AFJD3SampleViewController" bundle:nil];
    [self.navigationController pushViewController:d3VC animated:YES];
}

@end
