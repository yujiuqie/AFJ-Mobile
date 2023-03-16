//
//  AdvertiseNsObject.m
//  advertiseDemo
//
//  Created by 冯汉栩 on 2019/7/22.
//  Copyright © 2019 zhouhuanqiang. All rights reserved.
//

@implementation AdvertiseCountDownNsObject

+ (void)initAdvertise:(NSArray *)arr {
    [[AdvertiseCountDownNsObject alloc] initAdvertise:arr];
}

- (void)initAdvertise:(NSArray *)arr {
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:@"CountDownAdvertise"]];

    BOOL isExist = [self isFileExistWithFilePath:filePath];
    // 图片存在 显示图片
    if (isExist) {
        AdvertiseCountDownView *advertiseView = [[AdvertiseCountDownView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        advertiseView.filePath = filePath;
        [advertiseView show];
    }
    //下载新图片  自动覆盖就的图片
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [self getAdvertisingImage:arr];
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage:(NSArray *)arr {
    // TODO 请求广告接口
    NSArray *imageArray = arr;
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    // 获取图片名:43-130P5122Z60-50.jpg
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    //下载新图片
    [self downloadAdImageWithUrl:imageUrl imageName:imageName];

}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [kUserDefaults setValue:imageName forKey:@"CountDownAdvertise"];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        } else {
            NSLog(@"保存失败");
        }
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage {
    NSString *imageName = [kUserDefaults valueForKey:@"CountDownAdvertise"];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName {
    if (imageName) {

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];

        return filePath;
    }

    return nil;
}

@end






