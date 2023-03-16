//
//  QRCodeScanVC.m
//  SDBank_iOS
//
//  Created by sdebank on 2021/9/18.
//  Copyright © 2021 Alibaba. All rights reserved.
//

/**
 *  屏幕 高 宽 边界
 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds

#define TOP (SCREEN_HEIGHT-220)/2
#define LEFT (SCREEN_WIDTH-220)/2

#define kScanRect CGRectMake(LEFT, TOP, 220, 220)

@interface QRCodeScanVC () <AVCaptureMetadataOutputObjectsDelegate> {
    int num;
    BOOL upOrdown;
    CAShapeLayer *cropLayer;
}
@property(strong, nonatomic) AVCaptureDevice *device;
@property(strong, nonatomic) AVCaptureDeviceInput *input;
@property(strong, nonatomic) AVCaptureMetadataOutput *output;
@property(strong, nonatomic) AVCaptureSession *session;
@property(strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@property(nonatomic, strong) UIImageView *line;
@property(nonatomic, strong) NSTimer *timer;
//@property (weak, nonatomic) IBOutlet UIButton *localImage;

@end

@implementation QRCodeScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)configView {

//    self.localImage.layer.masksToBounds = YES;
//    self.localImage.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.localImage.layer.borderWidth = 1;

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];

    upOrdown = NO;
    num = 0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP + 10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];


}

- (void)viewWillAppear:(BOOL)animated {

    [self setCropRect:kScanRect];

    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0.3];

}
//- (IBAction)tapLocalScan:(UIButton *)sender {
//    NSLog(@"识别本地图片");
//    NSString *result = [LCQRCodeUtil readQRCodeFromImage:[UIImage imageNamed:@"QRImage"]];
//    NSLog(@"识别本地图片结果:%@",result);
//
//}

- (void)animation1 {
    if (upOrdown == NO) {
        num++;
        _line.frame = CGRectMake(LEFT, TOP + 10 + 2 * num, 220, 2);
        if (2 * num == 200) {
            upOrdown = YES;
        }
    } else {
        num--;
        _line.frame = CGRectMake(LEFT, TOP + 10 + 2 * num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }

}


- (void)setCropRect:(CGRect)cropRect {
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);

    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];


    [cropLayer setNeedsDisplay];

    [self.view.layer addSublayer:cropLayer];
//    [self.view bringSubviewToFront:self.localImage];

}

- (void)setupCamera {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device == nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {

        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    // Input
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];

    // Output
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    //设置扫描区域
    CGFloat top = TOP / SCREEN_HEIGHT;
    CGFloat left = LEFT / SCREEN_WIDTH;
    CGFloat width = 220 / SCREEN_WIDTH;
    CGFloat height = 220 / SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [self.output setRectOfInterest:CGRectMake(top, left, height, width)];

    // Session
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }

    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }

    // 设置条码类型 AVMetadataObjectTypeQRCode
    [self.output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];

    // Preview  添加扫描画面
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];

    // Start   开始扫描
    [self.session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;

    if ([metadataObjects count] > 0) {
        //停止扫描
        [self.session stopRunning];
        [self.timer setFireDate:[NSDate distantFuture]];

        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"扫描结果：%@", stringValue);

        NSArray *arry = metadataObject.corners;
        for (id temp in arry) {
            NSLog(@"%@", temp);
        }

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:stringValue preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            if (self.session != nil && self.timer != nil) {
                [self.session startRunning];
                [self.timer setFireDate:[NSDate date]];
            }

        }]];
        [self presentViewController:alert animated:YES completion:nil];

    } else {
        NSLog(@"无扫描信息");
        return;
    }

}

@end
