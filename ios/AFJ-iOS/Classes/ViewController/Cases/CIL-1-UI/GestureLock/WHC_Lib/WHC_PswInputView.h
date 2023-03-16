//
//  WHC_PswInputView.h
//  WHC_GestureUnlockScreenDemo
//
//  Created by 吴海超 on 15/6/18.
//  Copyright (c) 2015年 吴海超. All rights reserved.
//

/*
 *  qq:712641411
 *  iOSqq群:302157745
 *  gitHub:https://github.com/netyouli
 *  csdn:http://blog.csdn.net/windwhc/article/category/3117381
 */

#import <UIKit/UIKit.h>

@interface WHC_PswInputView : UIView

- (void)addPswCircleFinish:(void (^)())didFinish;

- (void)clearAllPswCircle;

- (void)clearPswCircle;

- (void)showMistakeMsg;
@end
