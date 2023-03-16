//
//  Regular.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/3/27.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Regular : NSObject

//纳税号
+ (BOOL)validateTaxNumber:(NSString *)code;

//银行卡账号
+ (BOOL)validateBankCode:(NSString *)code;

//手机号判断
+ (BOOL)validateMobileNH:(NSString *)mobile;

//手机号判断
+ (BOOL)validateMobile:(NSString *)mobile;

//身份证号判断
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

//判断邮箱是否正确
+ (BOOL)validateEmail:(NSString *)email;

//7-12位的数字
+ (BOOL)validateNum:(NSString *)mobile;

@end

NS_ASSUME_NONNULL_END
