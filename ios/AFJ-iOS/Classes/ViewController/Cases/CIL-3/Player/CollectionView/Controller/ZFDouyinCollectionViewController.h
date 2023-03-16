//
//  ZFDouyinCollectionViewController.h
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2019/6/4.
//  Copyright © 2019 紫枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/UIScrollView+ZFPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFDouyinCollectionViewController : UIViewController

@property(nonatomic, assign) ZFPlayerScrollViewDirection scrollViewDirection;

- (void)playTheIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
