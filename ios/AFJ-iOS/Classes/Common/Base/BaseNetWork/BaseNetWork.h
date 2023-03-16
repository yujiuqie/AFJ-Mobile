//
//  BaseNetWork.h
//  Frame
//
//  Created by 冯汉栩 on 2021/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNetWork : NSObject

+ (instancetype)shareManager;

//get  有header
+ (void)getHeaderWithUrl:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id json))success failture:(void (^)(id json))failture;

//post 有header
+ (void)postHeaderWithUrl:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id json))success failture:(void (^)(id json))failture;

//get  无header
+ (void)getNoHeaderWithUrl:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id json))success failture:(void (^)(id json))failture;

//post  无header
+ (void)postNOHeaderWithUrl:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture;

//上存图片
+ (void)upLoadToURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                 fileData:(NSData *)fileData //要上传的数据
                     name:(NSString *)name //服务器参数名称 后台给你
                 fileName:(NSString *)fileName //文件名称 图片:xxx.jpg,xxx.png
                 mimeType:(NSString *)mimeType //文件类型 图片:image/jpg,image/png
                 progress:(void (^)(NSProgress *))progress //上传进度
                  success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

NS_ASSUME_NONNULL_END
