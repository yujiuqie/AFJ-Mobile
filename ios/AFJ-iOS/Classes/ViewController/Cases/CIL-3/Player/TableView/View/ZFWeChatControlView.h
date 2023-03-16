//
//  ZFWeChatControlView.h
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2020/7/11.
//  Copyright © 2020 紫枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/ZFPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFWeChatControlView : UIView <ZFPlayerMediaControl>

- (void)showCoverViewWithUrl:(NSString *)coverUrl;

@end

NS_ASSUME_NONNULL_END
