//
//  FHXSaveIconModel.h
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/4/28.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHXSaveIconModel : NSObject

@property(nonatomic, copy) NSString *savePath;//后台提供的路径(一级路径)   如：filename
@property(nonatomic, copy) NSString *subSavePath;//二级路径(单图片不需要)多张图片有可能一级路径文件夹里面还有另外的文件夹 如：id_card_img_url/(身份证正面)
@property(nonatomic, strong) NSData *fileData;//图片二进制
@property(nonatomic, copy) NSString *filename;//生成随机图片名
@property(nonatomic, copy) NSString *mimeType;//图片格式
@property(nonatomic, strong) UIImage *saveImage;//图片(原路返回传进来的图片，用于成功上存图片返回URL就显示图片))

@end

NS_ASSUME_NONNULL_END

