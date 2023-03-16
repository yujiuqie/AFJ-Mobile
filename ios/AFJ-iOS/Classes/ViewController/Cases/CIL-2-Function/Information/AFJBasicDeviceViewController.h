//
//  AFJBasicDeviceViewController.h
//  ClientTest
//
//  Created by Leon on 2017/5/18.
//  Copyright © 2017年 王鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFJRootViewController.h"

typedef NS_ENUM(NSUInteger, BasicInfoType) {
    BasicInfoTypeHardWare,
    BasicInfoTypeBattery,
    BasicInfoTypeIpAddress,
    BasicInfoTypeCPU,
    BasicInfoTypeDisk,
};

@interface AFJBasicDeviceViewController : AFJRootListViewController

- (instancetype)initWithType:(BasicInfoType)type;

@end
