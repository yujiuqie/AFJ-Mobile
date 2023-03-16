//
//  ZFViewController.m
//  ZFPlayer_Example
//
//  Created by 任子丰 on 2018/6/7.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFViewController.h"
#import "ZFDouYinViewController.h"
#import "ZFTableSectionModel.h"
#import "ZFDouyinCollectionViewController.h"

static NSString *kIdentifier = @"kIdentifier";

@interface ZFViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray <ZFTableSectionModel *> *datas;

@end

@implementation ZFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ZFPlayer";
    [self.view addSubview:self.tableView];
    self.datas = @[].mutableCopy;
    [self.datas addObject:[ZFTableSectionModel sectionModeWithTitle:@"播放器样式（Player style）" items:[self createItemsByPlayerType]]];
    [self.datas addObject:[ZFTableSectionModel sectionModeWithTitle:@"UITableView样式（TableView style）" items:[self createItemsByTableView]]];
    [self.datas addObject:[ZFTableSectionModel sectionModeWithTitle:@"UICollectionView样式（CollectionView style）" items:[self createItemsByCollectionView]]];
    [self.datas addObject:[ZFTableSectionModel sectionModeWithTitle:@"旋转类型（Rotation type）" items:[self createItemsByRotationType]]];
    [self.datas addObject:[ZFTableSectionModel sectionModeWithTitle:@"自定义（Custom）" items:[self createItemsByCustom]]];
    [self.datas addObject:[ZFTableSectionModel sectionModeWithTitle:@"其他（Other）" items:[self createItemsByOther]]];
}

- (NSArray <ZFTableItem *> *)createItemsByPlayerType {
    return @[[ZFTableItem itemWithTitle:@"普通样式,画中画" subTitle:@"Normal style" viewControllerName:@"ZFNormalViewController"],
            [ZFTableItem itemWithTitle:@"UITableView样式" subTitle:@"UITableView style" viewControllerName:@"ZFAutoPlayerViewController"],
            [ZFTableItem itemWithTitle:@"UICollectionView样式" subTitle:@"UICollectionView style" viewControllerName:@"ZFCollectionViewController"],
            [ZFTableItem itemWithTitle:@"UIScrollView样式" subTitle:@"UIScrollView style" viewControllerName:@"ZFScrollViewViewController"]];
}

- (NSArray <ZFTableItem *> *)createItemsByTableView {
    return @[[ZFTableItem itemWithTitle:@"点击播放" subTitle:@"Click to play" viewControllerName:@"ZFNotAutoPlayViewController"],
            [ZFTableItem itemWithTitle:@"自动播放" subTitle:@"Auto play" viewControllerName:@"ZFAutoPlayerViewController"],
            [ZFTableItem itemWithTitle:@"列表明暗播放" subTitle:@"Light and dark style" viewControllerName:@"ZFLightTableViewController"],
            [ZFTableItem itemWithTitle:@"微信朋友圈" subTitle:@"wechat friend circle style" viewControllerName:@"ZFWChatViewController"],
            [ZFTableItem itemWithTitle:@"混合cell样式" subTitle:@"Mix cell style" viewControllerName:@"ZFMixViewController"],
            [ZFTableItem itemWithTitle:@"小窗播放" subTitle:@"Small view style" viewControllerName:@"ZFSmallPlayViewController"],
            [ZFTableItem itemWithTitle:@"抖音样式" subTitle:@"Douyin style" viewControllerName:@"ZFDouYinViewController"],
            [ZFTableItem itemWithTitle:@"HeaderView样式" subTitle:@"Table header style" viewControllerName:@"ZFTableHeaderViewController"]];
}

- (NSArray <ZFTableItem *> *)createItemsByCollectionView {
    return @[[ZFTableItem itemWithTitle:@"抖音个人主页" subTitle:@"Douyin homepage" viewControllerName:@"ZFCollectionViewListController"],
            [ZFTableItem itemWithTitle:@"横向滚动抖音" subTitle:@"Horizontal Douyin style" viewControllerName:@"ZFDouyinCollectionViewController"],
            [ZFTableItem itemWithTitle:@"竖向滚动抖音" subTitle:@"Vertical Douyin style" viewControllerName:@"ZFDouyinCollectionViewController"],
            [ZFTableItem itemWithTitle:@"横向滚动CollectionView" subTitle:@"Horizontal CollectionView" viewControllerName:@"ZFHorizontalCollectionViewController"]];
}

- (NSArray <ZFTableItem *> *)createItemsByRotationType {
    return @[[ZFTableItem itemWithTitle:@"旋转类型" subTitle:@"Rotation type" viewControllerName:@"ZFRotationViewController"],
            [ZFTableItem itemWithTitle:@"旋转键盘" subTitle:@"Rotation keyboard" viewControllerName:@"ZFKeyboardViewController"],
            [ZFTableItem itemWithTitle:@"全屏播放" subTitle:@"Fullscreen play" viewControllerName:@"ZFFullScreenViewController"]];
}

- (NSArray <ZFTableItem *> *)createItemsByCustom {
    return @[[ZFTableItem itemWithTitle:@"自定义控制层" subTitle:@"Custom ControlView" viewControllerName:@"ZFCustomControlViewViewController"]];
}

- (NSArray <ZFTableItem *> *)createItemsByOther {
    return @[[ZFTableItem itemWithTitle:@"广告" subTitle:@"Advertising" viewControllerName:@"ZFADViewController"]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    ZFTableItem *itme = self.datas[indexPath.section].items[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@（%@）", itme.title, itme.subTitle];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.datas[section].title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZFTableItem *itme = self.datas[indexPath.section].items[indexPath.row];
    NSString *vcString = itme.viewControllerName;
    UIViewController *viewController = [[NSClassFromString(vcString) alloc] init];
    if ([vcString isEqualToString:@"ZFDouYinViewController"]) {
        [(ZFDouYinViewController *) viewController playTheIndex:0];
    }
    viewController.navigationItem.title = itme.title;
    viewController.hidesBottomBarWhenPushed = YES;

    if ([vcString isEqualToString:@"ZFDouyinCollectionViewController"] && [itme.title isEqualToString:@"横向滚动抖音"]) {
        ZFDouyinCollectionViewController *douyinVC = (ZFDouyinCollectionViewController *) viewController;
        douyinVC.scrollViewDirection = ZFPlayerScrollViewDirectionHorizontal;
    }
    if ([vcString isEqualToString:@"ZFFullScreenViewController"]) {
        viewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController presentViewController:viewController animated:NO completion:nil];
    } else {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

@end
