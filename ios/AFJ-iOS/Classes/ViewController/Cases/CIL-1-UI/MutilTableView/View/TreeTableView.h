//
//  TreeTableView.h
//  TreeTableView
//
//  Created by majunjie on 15/7/3.
//  Copyright (c) 2015年 majunjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Node;

@protocol TreeTableCellDelegate <NSObject>

- (void)cellClick:(Node *)node;

@end

@interface TreeTableView : UITableView

@property(nonatomic, weak) id <TreeTableCellDelegate> treeTableCellDelegate;

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data;

@end
