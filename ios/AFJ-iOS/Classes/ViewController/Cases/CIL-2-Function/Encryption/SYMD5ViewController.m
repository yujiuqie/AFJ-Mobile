//
//  SYMD5ViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/26.
//

#import "SYMD5ViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface SYMD5ViewController ()

@end

@implementation SYMD5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MD5";
}


- (void)ecrypt {
    self.plainTextView.text = [self md5:self.codeNumberTF.text];
}

- (void)decrypt {
    [self showToastWithMessage:@"MD5 无解密"];
}


- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
    ];
}

@end
