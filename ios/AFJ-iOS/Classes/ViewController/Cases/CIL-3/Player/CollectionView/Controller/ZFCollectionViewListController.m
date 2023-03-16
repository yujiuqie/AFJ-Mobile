//
//  ZFCollectionViewListController.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2018/7/19.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFCollectionViewListController.h"
#import "ZFCollectionViewCell.h"
#import "ZFTableData.h"
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import "ZFDouYinViewController.h"

static NSString *const reuseIdentifier = @"collectionViewCell";

@interface ZFCollectionViewListController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSMutableArray <ZFTableData *> *dataSource;
@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZFCollectionViewListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.navigationItem.title = @"点击跳转播放";
    [self requestData];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)requestData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    self.dataSource = @[].mutableCopy;
    NSArray *videoList = [rootDict objectForKey:@"list"];
    for (NSDictionary *dataDic in videoList) {
        ZFTableData *data = [[ZFTableData alloc] init];
        [data setValuesForKeysWithDictionary:dataDic];
        [self.dataSource addObject:data];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.data = self.dataSource[indexPath.row];
    cell.playBtn.hidden = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFDouYinViewController *douYinVC = [[ZFDouYinViewController alloc] init];
    [douYinVC playTheIndex:indexPath.item];
    [self.navigationController pushViewController:douYinVC animated:YES];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat margin = 5;
        CGFloat itemWidth = self.view.frame.size.width / 3 - 10;
        CGFloat itemHeight = itemWidth * 4 / 3;
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.sectionInset = UIEdgeInsetsMake(10, margin, 10, margin);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZFCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

@end
