//
//  AFJBlurViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/22.
//

#import "AFJBlurViewController.h"
#import "FXBlurView.h"
#import <QuartzCore/QuartzCore.h>

#import "AFJCaseItemData.h"

@interface AFJBlurViewController()


@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) UIBarButtonItem *rightBarBtn;

@end

@implementation AFJBlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnClick)];
    self.navigationItem.rightBarButtonItem = _rightBarBtn;
    

    
    _blurView = [[FXBlurView alloc] initWithFrame:self.view.bounds];
    _blurView.tintColor = [UIColor clearColor];
    [self.view addSubview:_blurView];
    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"测试页面模糊效果";
        item.didSelectAction = ^(id data) {
           
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.blurView.blurRadius < 5)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.blurView.blurRadius = 100;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.blurView.blurRadius = 0;
        }];
    }
}

- (void)rightBarBtnClick{
    if (self.blurView.blurRadius < 5)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.blurView.blurRadius = 40;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.blurView.blurRadius = 0;
        }];
    }
}

@end
