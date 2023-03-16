//
//  AFJPagedFlowViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/7.
//

#import "AFJPagedFlowViewController.h"

@interface AFJPagedFlowViewController ()
        <
        FHXNewPagedFlowViewDelegate,
        FHXNewPagedFlowViewDataSource
        >

@property(nonatomic, strong) NSArray *imageArray;

@end

@implementation AFJPagedFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];


    self.imageArray = @[@"fjjwtx (270).jpg", @"fjjwtx (135).jpg", @"fjjwtx (28).jpg", @"fjjwtx (260).jpg", @"fjjwtx (22).jpg"];

    FHXNewPagedFlowView *pageFlowView = [[FHXNewPagedFlowView alloc] initWithFrame:CGRectMake(0, 8, Phone_Width, Phone_Width * 9 / 16)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    //非当前页的透明比例
    pageFlowView.minimumPageAlpha = 0.1;
    //是否开启无限轮播,默认为开启
    pageFlowView.isCarousel = YES;
    //默认为横向
    pageFlowView.orientation = FHXNewPagedFlowViewOrientationHorizontal;
    //是否开启自动滚动， 默认开启
    pageFlowView.isOpenAutoScroll = YES;
    //左右间距
    pageFlowView.leftRightMargin = 40;
    //上下间距
    pageFlowView.topBottomMargin = 60;
    //自动切换视图的时间,默认是5.0
    pageFlowView.autoTime = 1;

    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [bottomScrollView addSubview:pageFlowView];
    [self.view addSubview:bottomScrollView];

    [pageFlowView reloadData];

}


#pragma mark NewPagedFlowView Delegate

- (CGSize)sizeForPageInFlowView:(FHXNewPagedFlowView *)flowView {
    return CGSizeMake(Phone_Width - 60, (Phone_Width - 60) * 9 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图", (long) subIndex + 1);
}

#pragma mark NewPagedFlowView Datasource

- (NSInteger)numberOfPagesInFlowView:(FHXNewPagedFlowView *)flowView {
    return self.imageArray.count;
}

- (UIView *)flowView:(FHXNewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    FHXIndexBannerSubiew *bannerView = (FHXIndexBannerSubiew *) [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[FHXIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Phone_Width, Phone_Width * 9 / 16)];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = [UIImage imageNamed:self.imageArray[index]];

    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(FHXNewPagedFlowView *)flowView {
    NSLog(@"ViewController 滚动到了第%ld页", pageNumber);
}

@end
