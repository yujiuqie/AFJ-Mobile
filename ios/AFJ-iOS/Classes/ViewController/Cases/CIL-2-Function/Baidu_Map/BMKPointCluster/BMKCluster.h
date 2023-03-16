//
//  BMKClusterItem.h
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/6.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/// 标注集群
@interface BMKCluster : NSObject

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@property(nonatomic, strong) NSMutableArray<NSValue *> *clusterAnnotations;

@property(nonatomic, readonly) NSUInteger size;

@end



