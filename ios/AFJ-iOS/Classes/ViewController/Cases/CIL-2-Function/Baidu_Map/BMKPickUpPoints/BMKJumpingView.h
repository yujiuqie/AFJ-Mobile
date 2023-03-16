//
//  BMKJumpingView.h
//  BMKPickUpPointsDemo
//
//  Created by Baidu on 2020/5/18.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMKJumpingView : BMKAnnotationView

/// 跳起动画
- (void)jump;

/// 落下动画
- (void)fall;

@end

NS_ASSUME_NONNULL_END
