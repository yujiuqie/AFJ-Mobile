//
//  ZFDouyinCollectionViewCell.h
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2019/6/4.
//  Copyright © 2019 紫枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFTableData.h"
#import "ZFDouYinCellDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZFDouyinCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) ZFTableData *data;

@property(nonatomic, weak) id <ZFDouYinCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
