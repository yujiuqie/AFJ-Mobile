//
//  Regular.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/3/27.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

@implementation Regular
//纳税号
+ (BOOL)validateTaxNumber:(NSString *)code {
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{15,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", pattern];
    BOOL isMatch = [pred evaluateWithObject:code];
    return isMatch;
}

//银行卡账号
+ (BOOL)validateBankCode:(NSString *)code {
    //判断位数
    if (code == nil || [code length] <= 8 || [code length] > 30) {
        return NO;
    }
    //判断是否全是数字
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[code componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![code isEqualToString:filtered]) {
        return NO;
    }
    return YES;
}

//手机号判断
+ (BOOL)validateMobileNH:(NSString *)mobile {
    //判断位数
    if (mobile == nil || [mobile length] <= 0 || [mobile length] > 11) {
        return NO;
    }
    //判断是否全是数字
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[mobile componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![mobile isEqualToString:filtered]) {
        return NO;
    }
    //判断1开头
    NSString *string = [mobile substringToIndex:1];
    if (![string isEqualToString:@"1"]) {
        return NO;
    }
    return YES;
}

//手机号判断
+ (BOOL)validateMobile:(NSString *)mobile {

    /**
     手机号码 13[0-9],14[5|7|9],15[0-3],15[5-9],17[0|1|3|5|6|8],18[0-9]
     移动：134[0-8],13[5-9],147,15[0-2],15[7-9],178,18[2-4],18[7-8]
     联通：13[0-2],145,15[5-6],17[5-6],18[5-6]
     电信：133,1349,149,153,173,177,180,181,189
     虚拟运营商: 170[0-2]电信  170[3|5|6]移动 170[4|7|8|9],171 联通
     上网卡又称数据卡，14号段为上网卡专属号段，中国联通上网卡号段为145，中国移动上网卡号段为147，中国电信上网卡号段为149
     */

    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1(3[0-9]|4[579]|5[0-35-9]|7[01356]|8[0-9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//身份证号判断
+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }

    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


//判断邮箱是否正确
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//7-12位的数字
+ (BOOL)validateNum:(NSString *)mobile {
    //判断位数
    if (mobile == nil || [mobile length] < 7 || [mobile length] > 11) {
        return NO;
    }
    //判断是否全是数字
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[mobile componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![mobile isEqualToString:filtered]) {
        return NO;
    }
    return YES;
}

@end
