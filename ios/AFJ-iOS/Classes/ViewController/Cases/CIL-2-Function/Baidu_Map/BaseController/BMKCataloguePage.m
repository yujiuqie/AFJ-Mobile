//
//  ViewController.m
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/5.
//  Copyright © 2018年 Baidu. All rights reserved.
//

#import "BMKCataloguePage.h"

static NSString *cellIdentifier = @"com.Baidu.BMKCatalogueTableViewCell";

@interface BMKCataloguePage () <UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) UITableView *tableView;
@property(copy, nonatomic) NSArray *titles;
@property(copy, nonatomic) NSArray *images;
@property(copy, nonatomic) NSArray *secondaryTitles;
@end

@implementation BMKCataloguePage

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitle];
    [self configUI];
    [self createTableView];
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = BMKMapVersion;
    self.title = @"百度地图iOS示例中心";
    [self.view addSubview:self.tableView];
}

- (void)createTableView {
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[BMKCatalogueTableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - Config title

- (void)setupTitle {
    _titles = @[@{@"地图显示": @[@"提供不同类型地图展示能力"]
    },
            @{@"地图交互": @[@"增强交互体验"]
            },
            @{@"覆盖物绘制": @[@"丰富覆盖物效果"]
            },
            @{@"轨迹": @[@"点标记平滑移动"]
            },
            @{@"检索": @[@"通过地图检索获取海量POI等"]
            },
            @{@"路线规划": @[@"结合实时交通，为用户提供多种路线规划服务"]
            },
    ];
    _images = @[@"bmk_map",
            @"bmk_interaction",
            @"bmk_mapdraw",
            @"bmk_trajectory",
            @"bmk_search",
            @"bmk_routeplan",
    ];
    _secondaryTitles = @[@[@{@"境外地图": @[@"全球200多个国家和地区详细道路、POI等数据展示",
            @"BMKShowOutsideMapViewController"]},
            @{@"个性化地图": @[@"个性化地图", @"BMKCustomMapController"]},
            @{@"地图选点": @[@"用户通过滑动地图找到目标位置",
                    @"BMKPickUpPointsViewController"]}
    ],
            @[@{@"手势冲突": @[@"地图滑动与view滑动手势共存",
                    @"BMKTabsSwitchViewController"]},
                    @{@"点标记适配屏幕": @[@"最佳视野内显示所有点标记",
                            @"BMKAnnotationViewFitMapViewController"]},
                    @{@"地图截图": @[@"地图与原生View截图融合", @"BMKMapScreenshotController"]}
            ],
            @[@{@"点聚合": @[@"绘制大量点标记时，通过缩小地图聚合显示成一个点",
                    @"BMKClusterAnnotationPage"]},
                    @{@"点标记平移动画": @[@"点击地图平移到指定位置",
                            @"BMKAnnotationMovingViewController"]},
                    @{@"点标记缩放动画": @[@"通过点标记的缩放突出展示指定位置",
                            @"BMKAnnotationScaleViewController"]},
                    @{@"自定义标注图标": @[@"添加自定义标记样式",
                            @"BMKCustomAnnotationViewController"]},
                    @{@"多信息窗展示": @[@"支持多个点标记和信息窗同时展示", @"BMKMultiPaopaoViewController"]},
                    @{@"Overlay点击选中": @[@"支持点、线、圆、多边形等多种覆盖物点击选中", @"BMKOverlayClickedViewController"]}
            ],
            @[@{@"平滑移动": @[@"基于运动、出行场景的点标记平滑移动",
                    @"BMKSmoothMovingViewController"]}
            ],
            @[@{@"地点检索": @[@"结合SUG检索和POI检精准找到期望POI",
                    @"BMKSug_POICitySearchViewController"]}
            ],
            @[@{@"步行路线规划": @[@"融合市内公交换乘路线规划和覆盖物绘制能力",
                    @"BMKWalkRoutePlanViewController"]},
                    @{@"骑行路线规划": @[@"融合步行路线规划和覆盖物绘制能力",
                            @"BMKBikeRoutePlanViewController"]},
                    @{@"市内公交换乘路线规划": @[@"融合骑行路线规划和覆盖物绘制能力",
                            @"BMKTransitRoutePlanViewController"]}
            ],
    ];
}

#pragma mark - e

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMKCatalogueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell refreshUIWithData:_titles images:_images atIndexPath:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BMKSecondaryCataloguePage *page = [[BMKSecondaryCataloguePage alloc] init];
    page.catalogueDatas = [NSArray arrayWithArray:[_secondaryTitles objectAtIndex:indexPath.row]];
    page.currentTitle = [[_titles objectAtIndex:indexPath.row] allKeys].firstObject;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = barButtonItem;
    [self.navigationController pushViewController:page animated:YES];
}

#pragma mark - Lazy loading

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH - kViewTopHeight - KiPhoneXSafeAreaDValue) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

@end
