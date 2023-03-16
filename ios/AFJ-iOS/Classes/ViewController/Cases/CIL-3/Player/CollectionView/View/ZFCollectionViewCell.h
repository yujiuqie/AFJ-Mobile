//
//  ZFCollectionViewCell.h
//  Player
//
//  Created by 任子丰 on 17/3/22.
//  Copyright © 2017年 任子丰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFTableData.h"

@interface ZFCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) UIImageView *coverImageView;
@property(nonatomic, strong) UIButton *playBtn;
/// 播放按钮block 
@property(nonatomic, copy) void (^playBlock)(UIButton *sender);

@property(nonatomic, strong) ZFTableData *data;

@end
