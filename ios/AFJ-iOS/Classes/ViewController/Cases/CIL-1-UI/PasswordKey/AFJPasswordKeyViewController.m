//
//  AFJPasswordKeyViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/26.
//

#import "AFJPasswordKeyViewController.h"
#import "LGMenuSegView.h"
#import "LGTextFieldView.h"

#define KeyboardHeight 216

@interface AFJPasswordKeyViewController ()
        <
        UITextFieldDelegate
        >

@property(nonatomic, strong) LGTextFieldView *textField;
@property(nonatomic, strong) UITextField *phoneTextField;

@end

@implementation AFJPasswordKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // [self addTextView];

    //密码
    LGTextFieldView *lgtextField = [[LGTextFieldView alloc] initWithFrame:CGRectMake(40, 120, SCREENW - 80, 50)];
    [self.view addSubview:lgtextField];
    lgtextField.tag = 100;
    lgtextField.delegate = self;
    self.textField = lgtextField;


    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 190, SCREENW - 80, 50)];
    _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTextField.delegate = self;
    _phoneTextField.placeholder = @"输入手机号";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTextField];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // NSLog(@"textFieldShouldBeginEditing");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isKindOfClass:[LGTextFieldView class]]) {
//        LGTextFieldView *textF = (LGTextFieldView *)textField;
//        [textF showNumberKeyboardWhenBeginEditing];
        NSLog(@"LGTextFieldView");
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

}

//自定义键盘时不走这个方法
- (BOOL)textField:(LGTextFieldView *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isKindOfClass:[LGTextFieldView class]]) {
        LGTextFieldView *lgTextF = (LGTextFieldView *) textField;
        NSLog(@"文字为%@", textField.text);
        if ([lgTextF isRightPassWord:string]) {
            return YES;
        } else {
            return NO;
        }
    } else
        return YES;


//    if (range.location>= 11 ){
//        return NO;
//    }else
//
//    return YES;


//    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//
//    if (toBeString.length > 11) {
//
//        textField.text = [toBeString substringToIndex:11];
//
//        return NO;
//
//    }else{
//
//        if ([textField isRightPassWord:string]) {
//                        return YES;
//        }else{
//                        return NO;
//        }
//    }
//
//    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
    //   NSLog(@"输入文字为：%@",self.textField.text);
    [self.phoneTextField resignFirstResponder];

//   BOOL isright =  [self.textField isRightPassWord];
//    if (isright) {
//        NSLog(@"合法");
//    }else{
//        NSLog(@"不合法");
//    }
}

@end
