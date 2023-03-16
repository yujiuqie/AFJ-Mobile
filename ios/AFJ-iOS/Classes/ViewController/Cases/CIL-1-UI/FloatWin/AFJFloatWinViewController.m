//
//  AFJFloatWinViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/7.
//

#import "AFJFloatWinViewController.h"
#import "NerdyUI.h"

@interface AFJFloatWinViewController ()

@property(nonatomic, strong) UIView *assistView;

@end

@implementation AFJFloatWinViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.assistView = [UIView new];
    self.assistView.addTo(self.view).bgColor([Color randomColor]).makeCons(^{
        make.centerY.equal.view(self.view).constants(-100);
        make.centerX.equal.view(self.view).constants(-100);
        make.width.height.equal.constants(100);
    }).onClick((^{
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];

        CGRect newRect = CGRectMake([self.assistView convertRect:CGRectZero toView:self.view].origin.x, [self.assistView convertRect:CGRectZero toView:self.view].origin.y + self.assistView.bounds.size.height, 300, 100);
        //创建
        [FHXFloatWinView showViewWithRect:newRect withList:arr withBlock:^(NSString *value, NSString *operating) {
            if ([operating isEqualToString:@"点击"]) {
                [self showToastWithMessage:[NSString stringWithFormat:@"点击了 ：%@", value]];
            } else if ([operating isEqualToString:@"删除"]) {

            }
        }];
    }));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [FHXFloatWinView cancelFloatView];
}


@end
