//
//  BMKSegmentView.h
//  BMKCustomMapDemo
//
//  Created by baidu on 2020/7/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BMKSegmentViewDidClickSegmentBlock)(NSInteger idx);

NS_ASSUME_NONNULL_BEGIN

@interface BMKSegmentView : UIView

@property(nonatomic, copy) BMKSegmentViewDidClickSegmentBlock didClickSegmentBlock;

@end

NS_ASSUME_NONNULL_END
