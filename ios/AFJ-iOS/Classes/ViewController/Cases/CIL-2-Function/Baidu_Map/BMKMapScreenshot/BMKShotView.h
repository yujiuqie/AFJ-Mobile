//
//  BMKShotView.h
//  BMKMapScreenshot
//
//  Created by baidu on 2020/7/20.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMKShotView : UIView

/// 该API仅可以在未使用layer和OpenGL渲染的视图上使用
/// 获得该视图截图
- (UIImage *)snapshot;

@end

NS_ASSUME_NONNULL_END
