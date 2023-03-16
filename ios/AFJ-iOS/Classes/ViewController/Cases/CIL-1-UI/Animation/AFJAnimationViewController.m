//
//  AFJAnimationViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/7.
//

#import "AFJAnimationViewController.h"

#import "AFJCaseItemData.h"

@interface AFJAnimationViewController ()



@end

@implementation AFJAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];

    NSArray *array = @[
            @[@"基础动画", @"BaseAnimationController"],
            @[@"关键帧动画", @"KeyFrameAnimationController"],
            @[@"组动画", @"GroupAnimationController"],
            @[@"过渡动画", @"TransitionAnimationController"],
            @[@"仿射变换", @"AffineTransformController"],
            @[@"综合案例", @"ComprehensiveCaseController"],
            @[@"Layer animation", @"YSCLayerAnimationViewController"],
            @[@"heart beat animation", @"YSCHeartBeatPulseViewController"],
            @[@"ripple animation", @"YSCRippleAnimationViewController"],
            @[@"wave animation", @"YSCWaveAnimationViewController"],
            @[@"mask animation", @"YSCMaskAnimationViewController"],
            @[@"voiceWave animation", @"YSCVoiceWaveViewController"],
            @[@"waterWave animation", @"YSCWaterWaveViewController"],
            @[@"seawaterWave animation", @"YSCSeaWaterWaveViewController"],
            @[@"emitter animation", @"YSCEmitterAnimationViewController"],
            @[@"replicator animation", @"YSCReplicatorAnimationViewController"],
            @[@"loadGif animation", @"YSCloadGifViewController"],
            @[@"carouselTitle animation", @"YSCCarouselTitleViewController"],
            @[@"refreshTable animation", @"YSCRefreshTableViewController"]
    ];

    for (NSArray *arr in array) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = [arr firstObject];
        item.type = [arr lastObject];
        item.didSelectAction = ^(id data) {
            [weakSelf colorCellAction:data];
        };
        [dataArray addObject:item];
    }

        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)colorCellAction:(id)data {
    AFJCaseItemData *item = data;
    NSLog(@"click %@ item", item.title);

    UIViewController *vc = [[NSClassFromString(item.type) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
