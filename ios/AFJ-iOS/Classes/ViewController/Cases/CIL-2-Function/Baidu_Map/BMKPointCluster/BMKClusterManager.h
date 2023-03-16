//
//  BMKClusterManager.h
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/6.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMKClusterQuadtree.h"

/// 标注集群管理者
@interface BMKClusterManager : NSObject

/// 标注集群缓存
@property(nonatomic, strong) NSMutableArray *clusterCaches;

/// 清除标注集群items
- (void)clearClusterItems;

/// 根据地图缩放级别获取标注集群
- (NSArray<BMKCluster *> *)getClusters:(CGFloat)zoomLevel;

@end
