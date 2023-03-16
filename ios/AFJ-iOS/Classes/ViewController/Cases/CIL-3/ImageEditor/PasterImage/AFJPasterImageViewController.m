//
//  AFJPasterImageViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/20.
//

#import "AFJPasterImageViewController.h"
#import "YBPasterImageVC.h"
#import "UIViewController+Swizzling.h"

@interface AFJPasterImageViewController ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *filterLabel;
@property(nonatomic, strong) UIButton *nextBtn;

@end

@implementation AFJPasterImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _filterLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREENW - 400)/2.0, StatusBarAndNavigationBarHeight + 5, 400, 40)];
    _filterLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_filterLabel];
  
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENW - 400)/2.0, StatusBarAndNavigationBarHeight + 5 + 40 + 5, 400, 400)];
    _imageView.image = [UIImage imageNamed:@"fjjwtx (252).jpg"];
    [self.view addSubview:_imageView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake((SCREENW - 400)/2.0, StatusBarAndNavigationBarHeight + 5 + 40 + 5 + 400 + 5, 400, 40);
    [_nextBtn setTitle:@"进行图像处理" forState:UIControlStateNormal];
    _nextBtn.backgroundColor = [UIColor redColor];
    [_nextBtn addTarget:self action:@selector(showDemo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
}

- (void)showDemo{
    YBPasterImageVC *pasterVC = [[YBPasterImageVC alloc]init];
    pasterVC.originalImage = [UIImage imageNamed:@"fjjwtx (252).jpg"];
    
    pasterVC.block = ^(UIImage *editedImage){
        self.imageView.image = editedImage;
    };
    
    [self.navigationController pushViewController:pasterVC animated:YES];
}

@end
