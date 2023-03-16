//
//  AFJProgressViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/7.
//

#import "AFJProgressViewController.h"
#import "NerdyUI.h"

@interface AFJProgressViewController ()

@property(nonatomic, strong) FHXAnimationProgress *progressView;

@end

@implementation AFJProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.progressView = [FHXAnimationProgress new];
    self.progressView.addTo(self.view);
    self.progressView.makeCons(^{
        make.center.equal.view(self.view);
        make.height.equal.constants(10);
        make.width.equal.constants(200);
    });
    //  self.progressView.frame = CGRectMake(5, self.view.frame.size.height-10-10, self.view.frame.size.width-70-15-10, 12);
    self.progressView.backgroundColor = [UIColor clearColor];
    self.progressView.layer.cornerRadius = 5;
    self.progressView.layer.masksToBounds = YES;
    self.progressView.progressTintColors = @[LRColorWithRGB(0xce2b2c), LRColorWithRGB(0xff734d)];
    //动画节条
    self.progressView.stripesWidth = 10;
    //是否开启动画
    self.progressView.stripesAnimated = YES;
    //YES渐变效果 NO折条效果
    self.progressView.hideStripes = NO;
    //节点个数
    self.progressView.numberOfNodes = 0;
    self.progressView.hideAnnulus = NO;
    //yes 已动画的形式递进(胀满)  NO没有动画  最好设置NO  防止重复刷新滚动条重复加载
    [self.progressView setProgress:[FHXHelp getRandomNumber:1 to:10] / 10.0 animated:NO];
}


@end
