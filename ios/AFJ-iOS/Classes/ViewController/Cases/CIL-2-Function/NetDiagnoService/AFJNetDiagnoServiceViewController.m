//
//  AFJNetDiagnoServiceViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/22.
//

#import "AFJNetDiagnoServiceViewController.h"
#import "LDNetDiagnoService.h"
#import "LDNetDiagnoService.h"
#import "MBProgressHUD.h"
#import "FCFileManager.h"
#import "AFNetworking.h"

static const NSString *downloadUrl = @"http://api.boxfish.cn/data/7729ea6237db7d8d03df36875c1263b7?server=";

@interface AFJNetDiagnoServiceViewController ()
        <
        LDNetDiagnoServiceDelegate,
        UITextFieldDelegate
        >

@property(strong, nonatomic) UITextField *txtfield_dormain;
@property(strong, nonatomic) LDNetDiagnoService *netDiagnoService;
@property(strong, nonatomic) NSString *logInfo;
@property(strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property(strong, nonatomic) UIButton *startBtn;
@property(strong, nonatomic) UITextView *txtView_log;
@property(strong, nonatomic) NSMutableArray *apiArray;
@property(assign, nonatomic) NSInteger apiCheckCount;

@property(strong, nonatomic) NSTimer *timer;
@property(assign, nonatomic) BOOL isRunning;
@property(strong, nonatomic) NSMutableArray *cdnArray;//cn  中国  us_west 美国西部  us_east 美国东部 sg 新加坡  au 澳大利亚 de 德国
@property(assign, nonatomic) NSInteger cdnCheckCount;

@end

@implementation AFJNetDiagnoServiceViewController


#pragma mark -

- (void)fileShow {

    NSArray *filenames = [FCFileManager listFilesInDirectoryAtPath:[FCFileManager pathForCachesDirectory]];

    [filenames enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        NSString *filename = [NSString stringWithFormat:@"\n%lu:,%@\n", (unsigned long) idx, [[obj componentsSeparatedByString:@"/"] lastObject]];
        _logInfo = [_logInfo stringByAppendingString:filename];
    }];
    _logInfo = [_logInfo stringByAppendingString:@"下载完成"];
}

- (void)downLoadFile {
    _cdnCheckCount = 0;
    for (NSString *region in _cdnArray) {

        __weak typeof(self) weakSelf = self;
        NSDate *startTime = [NSDate date];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", downloadUrl, region]];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];

        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *_Nonnull downloadProgress) {

            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.logInfo = [weakSelf.logInfo stringByAppendingString:[NSString stringWithFormat:@"\n节点：%@:,速度：%@,进度：%lf\n", region, [weakSelf downloadSpeed:startTime completedUnitCount:downloadProgress.completedUnitCount], 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount]];

                weakSelf.txtView_log.text = weakSelf.logInfo;
            });

        }                                                             destination:^NSURL *_Nonnull(NSURL *_Nonnull targetPath, NSURLResponse *_Nonnull response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];

            NSString *str1 = [NSString stringWithFormat:@"\n(%@--节点下载完成)\n", region];
            NSDictionary *dictAttr1 = @{NSForegroundColorAttributeName: [UIColor redColor]};
            NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:str1
                                                                        attributes:dictAttr1];
            [attributedString appendAttributedString:attr1];
            weakSelf.logInfo = [weakSelf.logInfo stringByAppendingString:str1];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.txtView_log.text = weakSelf.logInfo;
            });
            weakSelf.cdnCheckCount++;
            NSLog(@"---------%ld", (long) weakSelf.cdnCheckCount);
            if (weakSelf.cdnCheckCount == weakSelf.cdnArray.count) {
                [weakSelf allClear];
            }


            return [documentsDirectoryURL URLByAppendingPathComponent:region];
        }                                                       completionHandler:^(NSURLResponse *_Nonnull response, NSURL *_Nullable filePath, NSError *_Nullable error) {

            if (error != nil) {
                weakSelf.cdnCheckCount++;
                NSLog(@"%@节点下载失败，错误：%@", region, error);
            }
            if (weakSelf.cdnCheckCount == weakSelf.cdnArray.count) {
                [weakSelf allClear];
            }

        }];

        [downloadTask resume];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"网络 - 诊断";

    _apiArray = [NSMutableArray new];
    [_apiArray addObject:@"api.boxfish.cn"];
    [_apiArray addObject:@"storage.boxfish.cn"];
    _cdnArray = [[NSMutableArray alloc] initWithObjects:@"cn", @"us_west", @"us_east", @"sg", @"au", @"de", nil];

    NSArray *filename = [FCFileManager listFilesInDirectoryAtPath:[FCFileManager pathForDocumentsDirectory]];

    [filename enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [FCFileManager removeItemAtPath:obj error:nil];
    }];

//    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    _indicatorView.frame = CGRectMake(0, 0, 30, 30);
//    _indicatorView.hidden = NO;
//    _indicatorView.hidesWhenStopped = YES;
//    [_indicatorView stopAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"copy" style:UIBarButtonItemStylePlain target:self action:@selector(copyToPasteboard)];

//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_indicatorView];
//    self.navigationItem.rightBarButtonItem = rightItem;

    _txtfield_dormain =
            [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 180) / 2.0, 79.0f, 180.0f, 50.0f)];
    _txtfield_dormain.delegate = self;
    _txtfield_dormain.textAlignment = NSTextAlignmentCenter;
    _txtfield_dormain.returnKeyType = UIReturnKeyDone;
    _txtfield_dormain.text = _apiArray[0];
    _txtfield_dormain.textColor = [UIColor blackColor];
    [self.view addSubview:_txtfield_dormain];


    _txtView_log = [[UITextView alloc] initWithFrame:CGRectZero];
    _txtView_log.layer.borderWidth = 1.0f;
    _txtView_log.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _txtView_log.backgroundColor = [UIColor whiteColor];
    _txtView_log.font = [UIFont systemFontOfSize:10.0f];
    _txtView_log.textAlignment = NSTextAlignmentLeft;
    _txtView_log.scrollEnabled = YES;
    _txtView_log.editable = NO;
    _txtView_log.frame =
            CGRectMake(0.0f, 120.0f, self.view.frame.size.width, self.view.frame.size.height - 120.0f - 140.f);
    [self.view addSubview:_txtView_log];

    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startBtn.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0, self.view.frame.size.height - 140.0f, 200.0f, 50.0f);
    [_startBtn setBackgroundColor:[UIColor lightGrayColor]];
    [_startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_startBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_startBtn.titleLabel setNumberOfLines:2];
    [_startBtn setTitle:@"开始诊断" forState:UIControlStateNormal];
    [_startBtn addTarget:self
                  action:@selector(startNetDiagnosis)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startBtn];

    // Do any additional setup after loading the view, typically from a nib.
    _netDiagnoService = [[LDNetDiagnoService alloc] initWithAppCode:@"test"
                                                            appName:@"boxfish"
                                                         appVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                                                             userID:@"zhaojian@boxfish.cn"
                                                           deviceID:nil
                                                            dormain:_txtfield_dormain.text
                                                        carrierName:nil
                                                     ISOCountryCode:nil
                                                  MobileCountryCode:nil
                                                      MobileNetCode:nil];
    _netDiagnoService.delegate = self;
    _isRunning = NO;
    _txtView_log.text = @"";
    _logInfo = @"";
}


- (void)startNetDiagnosis {
    if (_apiCheckCount == 0) {
        _txtView_log.text = @"";
        _logInfo = @"";
        _startBtn.userInteractionEnabled = NO;
    }

    if (_apiCheckCount == _apiArray.count) {
        _startBtn.userInteractionEnabled = YES;
        return;
    }
    [_txtfield_dormain resignFirstResponder];

    _txtfield_dormain.text = _apiArray[_apiCheckCount];
    _netDiagnoService.dormain = _txtfield_dormain.text;
    if (!_isRunning) {
        [_indicatorView startAnimating];
        [_startBtn setTitle:@"……" forState:UIControlStateNormal];
        [self add_animation];
        [_startBtn setUserInteractionEnabled:FALSE];
        _isRunning = !_isRunning;
        [_netDiagnoService startNetDiagnosis];
    } else {
        [_indicatorView stopAnimating];
        _isRunning = !_isRunning;
        [_startBtn setTitle:@"Start" forState:UIControlStateNormal];
        [_startBtn setUserInteractionEnabled:FALSE];
        [_netDiagnoService stopNetDialogsis];
    }
}

#pragma mark NetDiagnosisDelegate

- (void)netDiagnosisDidStarted {
    NSLog(@"Start～～～");
}

- (void)netDiagnosisStepInfo:(NSString *)stepInfo {
    _logInfo = [_logInfo stringByAppendingString:stepInfo];
    dispatch_async(dispatch_get_main_queue(), ^{
        _txtView_log.text = _logInfo;
    });
}

- (void)netDiagnosisDidEnd:(NSString *)allLogInfo; {
    _apiCheckCount++;
    dispatch_async(dispatch_get_main_queue(), ^{
        _isRunning = NO;
        _logInfo = [_logInfo stringByAppendingString:@"--------------\n"];
        _txtView_log.text = _logInfo;
    });

    if (_apiCheckCount == _apiArray.count) {
        //可以保存到文件，也可以通过邮件发送回来
        dispatch_async(dispatch_get_main_queue(), ^{
            [self downLoadFile];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startNetDiagnosis];
        });
    }
}

// 复制到剪切板
- (void)copyToPasteboard {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"tips" message:@"It has been copied to the clipboard" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _txtView_log.text;
}

- (void)add_animation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithInt:1];
    animation.toValue = [NSNumber numberWithInt:0];
    animation.autoreverses = YES;
    animation.duration = 3.0;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    [_startBtn.layer addAnimation:animation forKey:@"aAlpha"];
}

- (void)remove_animation {
    [_startBtn.layer removeAllAnimations];
}

- (void)allClear {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end-----");
        [self.timer invalidate];
        self.timer = nil;
        [self.indicatorView stopAnimating];
        [self.startBtn setTitle:@"Start" forState:UIControlStateNormal];
        self.isRunning = NO;
        self.apiCheckCount = 0;
        self.cdnCheckCount = 0;
        [self copyToPasteboard];
        [self remove_animation];
        [self.startBtn setUserInteractionEnabled:TRUE];
    });
}


- (NSString *)downloadSpeed:(NSDate *)startTime completedUnitCount:(int64_t)unitCount {
    NSTimeInterval startSeconds = [startTime timeIntervalSince1970];
    NSDate *now = [NSDate date];
    NSTimeInterval nowSeconds = [now timeIntervalSince1970];
    NSTimeInterval seconds = nowSeconds - startSeconds + 1;
    CGFloat speed = unitCount / seconds / 1000;
    if (speed < 1000) {
        return [NSString stringWithFormat:@"%.2f  kb/s", speed];
    } else {
        return [NSString stringWithFormat:@"%.1f m/s", speed / 1000];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
