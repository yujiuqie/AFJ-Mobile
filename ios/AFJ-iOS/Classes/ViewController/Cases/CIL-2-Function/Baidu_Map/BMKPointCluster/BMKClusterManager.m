//
//  BMKClusterManager.m
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/6.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "BMKClusterManager.h"

#define MAX_DISTANCE_IN_DP    500

@interface BMKClusterManager ()

@property(nonatomic, readonly) NSMutableArray<BMKQuadItem *> *quadItems;

@property(nonatomic, readonly) BMKClusterQuadtree *quadtree;

@end

@implementation BMKClusterManager

#pragma mark - Initialization method

- (instancetype)init {
    self = [super init];
    if (self) {

        _clusterCaches = [[NSMutableArray alloc] init];
        for (NSInteger i = 3; i < 22; i++) {
            [_clusterCaches addObject:[NSMutableArray array]];
        }

        _quadtree = [[BMKClusterQuadtree alloc] initWithRect:CGRectMake(0, 0, 1, 1)];
        _quadItems = [[NSMutableArray alloc] init];
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(39.915, 116.404);
        // 此处配置聚合点
        for (NSInteger i = 0; i < 2000; i++) {
            double lat = (arc4random() % 1000) * 0.001f;
            double lon = (arc4random() % 1000) * 0.001f;

            CLLocationCoordinate2D coordinate;
            coordinate = CLLocationCoordinate2DMake(coor.latitude + lat, coor.longitude + lon);
            BMKQuadItem *quadItem = [[BMKQuadItem alloc] init];
            quadItem.coordinate = coordinate;
            @synchronized (_quadtree) {
                [_quadItems addObject:quadItem];
                [_quadtree addItem:quadItem];
            }
        }
    }
    return self;
}

#pragma mark - Clusters

- (void)clearClusterItems {
    @synchronized (_quadtree) {
        [_quadItems removeAllObjects];
        [_quadtree clearItems];
    }
}

- (NSArray<BMKCluster *> *)getClusters:(CGFloat)zoomLevel {
    // 地图比例尺级别
    if (zoomLevel < 4 || zoomLevel > 22) {
        return nil;
    }
    NSMutableArray<BMKCluster *> *results = [NSMutableArray array];

    CGFloat zoomSpecificSpan = MAX_DISTANCE_IN_DP / pow(2, zoomLevel) / 256;
    NSMutableSet *visitedCandidates = [NSMutableSet set];
    NSMutableDictionary *distanceToCluster = [NSMutableDictionary dictionary];
    NSMutableDictionary *itemToCluster = [NSMutableDictionary dictionary];

    @synchronized (_quadtree) {
        for (BMKQuadItem *candidate in _quadItems) {
            // candidate已经添加到另一cluster中
            if ([visitedCandidates containsObject:candidate]) {
                continue;
            }
            BMKCluster *cluster = [[BMKCluster alloc] init];
            cluster.coordinate = candidate.coordinate;

            CGRect searchRect = [self getRectWithPt:candidate.pt span:zoomSpecificSpan];

            NSArray<BMKQuadItem *> *items = [_quadtree searchInRect:searchRect];
            if (items.count == 1) {
                CLLocationCoordinate2D coor = candidate.coordinate;
                NSValue *value = [NSValue value:&coor withObjCType:@encode(CLLocationCoordinate2D)];
                [cluster.clusterAnnotations addObject:value];

                [results addObject:cluster];
                [visitedCandidates addObject:candidate];
                [distanceToCluster setObject:[NSNumber numberWithDouble:0] forKey:[NSNumber numberWithLongLong:candidate.hash]];
                continue;
            }

            for (BMKQuadItem *quadItem in items) {
                NSNumber *existDistache = [distanceToCluster objectForKey:[NSNumber numberWithLongLong:quadItem.hash]];
                CGFloat distance = [self getDistanceSquared:candidate.pt otherPoint:quadItem.pt];
                if (existDistache != nil) {
                    if (existDistache.doubleValue < distance) {
                        continue;
                    }
                    BMKCluster *existCluster = [itemToCluster objectForKey:[NSNumber numberWithLongLong:quadItem.hash]];
                    CLLocationCoordinate2D coor = quadItem.coordinate;
                    NSValue *value = [NSValue value:&coor withObjCType:@encode(CLLocationCoordinate2D)];
                    [existCluster.clusterAnnotations removeObject:value];
                }

                [distanceToCluster setObject:[NSNumber numberWithDouble:distance] forKey:[NSNumber numberWithLongLong:quadItem.hash]];
                CLLocationCoordinate2D coor = quadItem.coordinate;
                NSValue *value = [NSValue value:&coor withObjCType:@encode(CLLocationCoordinate2D)];
                [cluster.clusterAnnotations addObject:value];
                [itemToCluster setObject:cluster forKey:[NSNumber numberWithLongLong:quadItem.hash]];
            }
            [visitedCandidates addObjectsFromArray:items];
            [results addObject:cluster];
        }
    }
    return results;
}

- (CGRect)getRectWithPt:(CGPoint)pt span:(CGFloat)span {
    CGFloat half = span / 2.f;
    return CGRectMake(pt.x - half, pt.y - half, span, span);
}

/// 两点间距离
- (CGFloat)getDistanceSquared:(CGPoint)pt otherPoint:(CGPoint)otherPoint {
    return pow(pt.x - otherPoint.x, 2) + pow(pt.y - otherPoint.y, 2);
}


@end
