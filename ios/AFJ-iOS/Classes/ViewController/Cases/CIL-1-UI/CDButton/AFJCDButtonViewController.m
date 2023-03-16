//
//  AFJCDButtonViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/7.
//

#import "AFJCDButtonViewController.h"

@interface AFJCDButtonViewController ()

@property(strong, nonatomic) UIButton *againBtn;

@end

@implementation AFJCDButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //获取验证码按钮
    self.againBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2.0, 120, 200, 50)];
    [_againBtn addTarget:self action:@selector(againBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.againBtn.userInteractionEnabled = NO;
    [self messageTime];
    [_againBtn setTitleColor:[UIColor redColor] forState:0];
    [self.view addSubview:_againBtn];
}

- (void)againBtn:(UIButton *)sender {
    //倒计时函数
    [self messageTime];
}

- (void)messageTime {
    __block int timeout = 10; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行

    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.againBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                [_againBtn setTitleColor:[UIColor redColor] forState:0];
                self.againBtn.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.againBtn setTitle:[NSString stringWithFormat:@"重新发送(%@)", strTime] forState:UIControlStateNormal];
                [_againBtn setTitleColor:[UIColor blackColor] forState:0];
                //To do
                [UIView commitAnimations];
                self.againBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);

}

@end
