//
//  AFJHTTPStubsViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/18.
//

#import "AFJHTTPStubsViewController.h"
#import "StubsViewController.h"

@interface AFJHTTPStubsViewController ()

@property(nonatomic, strong) StubsViewController *stbuVC;

@end

@implementation AFJHTTPStubsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebViewWith:self.product.link];
}

- (void)jumpToDemo {
    self.stbuVC = [[StubsViewController alloc] initWithNibName:@"StubsViewController" bundle:nil];
    [self.view addSubview:self.stbuVC.view];
    self.stbuVC.view.frame = self.view.bounds;
}


@end
