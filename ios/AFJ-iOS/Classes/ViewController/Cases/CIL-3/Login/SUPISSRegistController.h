//
//  SUPISSRegistController.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "AFJRootViewController.h"

@interface SUPISSRegistController : AFJRootListViewController
@property(nonatomic, strong) NSString *phoneNum;;

- (instancetype)initWithPhoneNumber:(NSString *)phone zone:(NSString *)zone methodType:(NSUInteger)method;


@end
