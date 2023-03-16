//
//  FHXFloatWinCell.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/4/17.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FHXFloatWinCell;

@protocol FHXFloatWinCellDelegate <NSObject>

- (void)fhxFloatWinCell:(FHXFloatWinCell *)cell returnPhoneNum:(NSString *)num;

@end

@interface FHXFloatWinCell : UITableViewCell

@property(nonatomic, strong) NSString *model;

@property(nonatomic, weak) id <FHXFloatWinCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
