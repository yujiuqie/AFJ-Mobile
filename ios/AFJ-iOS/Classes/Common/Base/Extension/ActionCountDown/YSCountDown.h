//
//  YSCountDown.h
//  YSCountDownDemo
//
//  Created by fenghanxu on 2017/4/21.
//  Copyright © 2017年 fenghanxu. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^YSCountDownBlock)(NSInteger tag);

@interface YSCountDown : NSObject

//block的作用是  倒计时结束出去刷新页面  未开始->进行中->活动结束
@property(nonatomic, copy) YSCountDownBlock block;

- (void)destoryTimer;

///每秒走一次，回调block    dataList  倒计时时间戳(未来的结束时间)   canReloadList 是否允许刷新(本身进来活动结束的商品是不能刷新的)
- (void)countDownWithPER_SEC:(UITableView *)tableView :(NSArray *)dataList :(NSMutableArray *)canReloadList;

/// 滑动过快的时候时间不会闪  (tableViewcell数据源方法里实现即可)
- (NSString *)countDownWithPER_SEC:(NSIndexPath *)indexPath :(NSMutableArray *)canReloadList;

- (instancetype)initWith:(UITableView *)tableView :(NSArray *)dataList :(NSMutableArray *)canReloadList;

@property(nonatomic, assign) BOOL isPlusTime;

@end
