//
//  BMKClusterQuadtree.h
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/6.
//  Copyright © 2015年 Baidu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BMKCluster.h"

/// 四叉树
@interface BMKQuadItem : NSObject

@property(nonatomic, readonly) CGPoint pt;

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

/// 标注集群四叉树
@interface BMKClusterQuadtree : NSObject

/// 四叉树区域
@property(nonatomic, assign) CGRect rect;

/// 所包含BMKQuadItem
@property(nonatomic, readonly) NSMutableArray<BMKQuadItem *> *quadItems;

- (instancetype)initWithRect:(CGRect)rect;

/// 添加item
- (void)addItem:(BMKQuadItem *)quadItem;

/// 清除items
- (void)clearItems;

/// 获取rect范围内的BMKQuadItem
- (NSArray<BMKQuadItem *> *)searchInRect:(CGRect)searchRect;

@end

