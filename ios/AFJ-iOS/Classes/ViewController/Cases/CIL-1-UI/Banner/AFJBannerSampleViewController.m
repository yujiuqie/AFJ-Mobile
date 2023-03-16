//
//  AFJBannerSampleViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/27.
//

#import "AFJBannerSampleViewController.h"
#import "ZYBannerView.h"
#import "AFJBannerNextViewController.h"

@interface AFJBannerSampleViewController ()
        <
        ZYBannerViewDataSource,
        ZYBannerViewDelegate,
        UITextFieldDelegate
        >

@property(nonatomic, strong) ZYBannerView *banner;
@property(nonatomic, strong) NSArray *dataArray;

@property(weak, nonatomic) IBOutlet UISwitch *shouldLoopSwitch;
@property(weak, nonatomic) IBOutlet UISwitch *showFooterSwitch;
@property(weak, nonatomic) IBOutlet UISwitch *autoScrollSwitch;
@property(weak, nonatomic) IBOutlet UITextField *scrollIntervalField;
@end

@implementation AFJBannerSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 控制器的 automaticallyAdjustsScrollViewInsets 属性为 YES(default) 时,
    // 若控制器的view及其子控件有唯一的一个 UIScrollView (或其子类), 那么这个
    // UIScrollView (或其子类)会被调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;

    // 配置banner
    [self setupBanner];
}

- (void)setupBanner {
    // 初始化
    self.banner = [[ZYBannerView alloc] init];
    self.banner.dataSource = self;
    self.banner.delegate = self;
    [self.view addSubview:self.banner];

    // 设置frame
    self.banner.frame = CGRectMake(0,
            StatusBarAndNavigationBarHeight,
            SCREENW,
            200.0);
}

#pragma mark - ZYBannerViewDataSource

// 返回 Banner 需要显示 Item(View) 的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner {
    return self.dataArray.count;
}

// 返回 Banner 在不同的 index 所要显示的 View (可以是完全自定义的v iew, 且无需设置 frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    // 取出数据
    NSString *imageName = self.dataArray[index];

    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;

    return imageView;
}

// 返回 Footer 在不同状态时要显示的文字
- (NSString *)banner:(ZYBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState {
    if (footerState == ZYBannerFooterStateIdle) {
        return @"拖动进入下一页";
    } else if (footerState == ZYBannerFooterStateTrigger) {
        return @"释放进入下一页";
    }
    return nil;
}

#pragma mark - ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld个项目", (long) index);
}

- (void)banner:(ZYBannerView *)banner didScrollToItemAtIndex:(NSInteger)index {
    NSLog(@"滚动到第%ld个项目", (long) index);
}

// 在这里实现拖动 Footer 后的事件处理
- (void)bannerFooterDidTrigger:(ZYBannerView *)banner {
    NSLog(@"触发了footer");

    AFJBannerNextViewController *vc = [[AFJBannerNextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark Demo banner property setting (无需关心此部分逻辑)

- (IBAction)switchValueChanged:(UISwitch *)aSwitch {
    switch (aSwitch.tag) {
        case 0: // Should Loop
            self.banner.shouldLoop = aSwitch.isOn;
            break;

        case 1: // Show Footer
            self.banner.showFooter = aSwitch.isOn;
            break;

        case 2: // Auto Scroll
            self.banner.autoScroll = aSwitch.isOn;
            break;

        default:
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // Scroll Interval
    self.banner.scrollInterval = textField.text.integerValue;
}

#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.scrollIntervalField resignFirstResponder];
}

#pragma mark Getter

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"ad_0.jpg", @"ad_1.jpg", @"ad_2.jpg"];
    }
    return _dataArray;
}

@end
