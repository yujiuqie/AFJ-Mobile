//
//  CollectionViewController.m
//  WXSTransition
//
//  Created by 王小树 on 16/5/31.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "DetailViewController.h"
#import "UINavigationController+WXSTransition.h"
@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation CollectionViewController

static NSString *identifier  = @"identifier";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
#pragma mark Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    __weak CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    __weak DetailViewController *weakVC = vc;
    
    if (indexPath.row % 2 == 0) {
        [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionProperty *transition) {
            transition.animationType = WXSTransitionAnimationTypeViewMoveToNextVC;
            transition.animationTime = 0.64;
            transition.startView  = cell.imgView;
            transition.targetView = weakVC.imageView;
        }];
    }else {
        
        [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionProperty *transition) {
            transition.animationType = WXSTransitionAnimationTypeViewMoveNormalToNextVC;
            transition.animationTime = 0.4;
            transition.startView  = cell.imgView;
            transition.targetView = weakVC.imageView;
        }];
    }
    
}

#pragma mark Getter
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
