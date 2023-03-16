//
//  ZJTest1ViewController.h
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/6/30.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJScrollPageViewDelegate.h"

@interface ZJTest1ViewController : UIViewController <ZJScrollPageViewChildVcDelegate>
@property(copy, nonatomic) void (^click)();
@end
