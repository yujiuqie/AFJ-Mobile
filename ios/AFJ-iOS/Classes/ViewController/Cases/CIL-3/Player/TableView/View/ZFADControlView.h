//
//  ZFADControlView.h
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2019/5/15.
//  Copyright © 2019 紫枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/ZFPlayerMediaControl.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFADControlView : UIView <ZFPlayerMediaControl>

@property(nonatomic, copy) void (^skipCallback)(void);

@property(nonatomic, copy) void (^fullScreenCallback)(void);

@end

NS_ASSUME_NONNULL_END
