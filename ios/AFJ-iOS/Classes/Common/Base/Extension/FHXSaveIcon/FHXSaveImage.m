//
//  FHXSaveIcon.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/4/28.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

@implementation FHXSaveImage
//打水印 + 文字
- (UIImage *)imageWaterMar:(UIImage *)image {
    UIImage *icon = [UIImage new];
    UIFont *font = [UIFont systemFontOfSize:20];
    NSDictionary *attri = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor groupTableViewBackgroundColor]};
    icon = [image imageWaterMarkWithString:@"仅供拿货商城使用" point:CGPointMake(50, 20) attribute:attri image:[UIImage imageNamed:@"welcome_logo"] imagePoint:CGPointMake(200, 200) alpha:0.1];
    return icon;
}

//图片转换二进制
- (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

//随机生成图片名
- (NSString *)randomizeString {
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRST";
    NSMutableString *input = [sourceStr mutableCopy];
    NSMutableString *output = [NSMutableString string];

    NSUInteger len = input.length;

    for (NSUInteger i = 0; i < len; i++) {
        NSInteger index = arc4random_uniform((unsigned int) input.length);
        [output appendFormat:@"%C", [input characterAtIndex:index]];
        [input replaceCharactersInRange:NSMakeRange(index, 1) withString:@""];
    }

    return output;
}


- (FHXSaveIconModel *)saveImage:(UIImage *)image withSavePath:(NSString *)savePath withSubSavePath:(NSString *)subSavePath {
    FHXSaveIconModel *model = [FHXSaveIconModel new];
    model.saveImage = image;
    model.savePath = savePath;
    model.subSavePath = subSavePath;

    //图片加水印
    UIImage *waterImage = [self imageWaterMar:image];
    //把图片压缩变为二进制对象
    NSData *fileData = UIImageJPEGRepresentation(waterImage, 0.5);
    if (fileData != nil) {
        model.fileData = fileData;
    }
    //告诉是二进制格式
    NSString *imageType = [self contentTypeForImageData:fileData];
    //文件类型 图片:image/jpg,image/png
    NSString *MimeType = [@"image/" stringByAppendingString:imageType];
    if (MimeType != nil) {
        model.mimeType = MimeType;
    }
    //随机生成图片名
    NSString *filename = [self randomizeString];
    filename = [filename stringByAppendingString:@"."];
    filename = [filename stringByAppendingString:imageType];
    if (filename != nil) {
        model.filename = filename;
    }
    return model;
}

@end
