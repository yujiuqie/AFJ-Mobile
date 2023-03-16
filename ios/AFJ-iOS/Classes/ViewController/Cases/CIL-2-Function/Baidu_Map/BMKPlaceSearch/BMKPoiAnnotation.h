//
//  BMKPoiAnnotation.h
//  BMKPlaceSearchDemo
//
//  Created by baidu on 2020/7/24.
//  Copyright © 2020 zhangbaojin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMKPoiAnnotation : BMKPointAnnotation

/// 标记顺序
@property(nonatomic, assign) int index;

@end

NS_ASSUME_NONNULL_END
