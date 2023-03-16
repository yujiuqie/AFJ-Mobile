//
//  AFJRegularMatchViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/26.
//

#import "AFJRegularMatchViewController.h"
#import "RegularMatch.h"

@interface AFJRegularMatchViewController ()
        <
        UITextFieldDelegate
        >

@property(nonatomic, strong) UITextField *myTextField;
@property(nonatomic, strong) UILabel *myLabel;

@end

@implementation AFJRegularMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, SCREENW - 40, 40)];
    self.myTextField.textColor = [UIColor whiteColor];
    [self.view addSubview:self.myTextField];
    self.myTextField.backgroundColor = [UIColor redColor];

    self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, SCREENW - 40, 100)];
    [self.view addSubview:self.myLabel];

    [self.myTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)theTextField {
    NSLog(@"text changed: %@", theTextField.text);
    [self updateLabel:theTextField.text];
}

- (void)updateLabel:(NSString *)str {
    NSString *result = @"";
    if ([RegularMatch validateEmail:str]) {
        result = [result stringByAppendingFormat:@"| 邮箱 |"];
    }
    if ([RegularMatch validateMobile:str]) {
        result = [result stringByAppendingFormat:@"| 手机 |"];
    }
    if ([RegularMatch validateCarNo:str]) {
        result = [result stringByAppendingFormat:@"| 车牌号 |"];
    }
    if ([RegularMatch validateCarType:str]) {
        result = [result stringByAppendingFormat:@"| 车型 |"];
    }
    if ([RegularMatch validateUserName:str]) {
        result = [result stringByAppendingFormat:@"| 用户名 |"];
    }
    if ([RegularMatch validatePassword:str]) {
        result = [result stringByAppendingFormat:@"| 密码 |"];
    }
    if ([RegularMatch validateNickname:str]) {
        result = [result stringByAppendingFormat:@"| 昵称 |"];
    }
    if ([RegularMatch validateIdentityCard:str]) {
        result = [result stringByAppendingFormat:@"| 身份证 |"];
    }
    if ([RegularMatch validateBankCardNumber:str]) {
        result = [result stringByAppendingFormat:@"| 银行卡 |"];
    }
    if ([RegularMatch validatePayPassword:str]) {
        result = [result stringByAppendingFormat:@"| 支付密码 |"];
    }
    if ([RegularMatch Moneytopay:str]) {
        result = [result stringByAppendingFormat:@"| 金额 |"];
    }

    self.myLabel.text = [result length] == 0 ? @"尚未识别" : result;
}

////邮箱
//+ (BOOL) validateEmail:(NSString *)email;
////手机号码验证
//+ (BOOL) validateMobile:(NSString *)mobile;
////车牌号验证
//+ (BOOL) validateCarNo:(NSString *)carNo;
////车型
//+ (BOOL) validateCarType:(NSString *)CarType;
////用户名
//+ (BOOL) validateUserName:(NSString *)name;
////密码
//+ (BOOL) validatePassword:(NSString *)passWord;
////昵称
//+ (BOOL) validateNickname:(NSString *)nickname;
////身份证号
//+ (BOOL) validateIdentityCard: (NSString *)identityCard;
////银行卡号
//+(BOOL)validateBankCardNumber:(NSString*)CardNumber;
////验证支付密码
//+(BOOL)validatePayPassword:(NSString *)Password;
//+(BOOL)Moneytopay:(NSString*)money;

@end
