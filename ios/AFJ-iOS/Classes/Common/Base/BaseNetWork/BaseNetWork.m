//
//  BaseNetWork.m
//  Frame
//
//  Created by 冯汉栩 on 2021/2/7.
//

@implementation BaseNetWork

+ (instancetype)shareManager {
    static BaseNetWork *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BaseNetWork alloc] init];
    });
    return manager;
}

#pragma mark - get请求方法  --  需要请求头

+ (void)getHeaderWithUrl:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", @"text/javascript", @"text/plain", nil];
    NSDictionary *headerDic = @{@"NH-AGENT-ID": @"2"};//根据公司需求修改  这里只是具个例子
    [manager GET:url parameters:parms headers:headerDic progress:^(NSProgress *_Nonnull downloadProgress) {
    }    success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        success(responseObject);
    }    failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        failture(error);
    }];

}

#pragma mark post请求方法

+ (void)postHeaderWithUrl:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", @"text/javascript", @"text/plain", nil];
    NSDictionary *headerDic = @{@"NH-AGENT-ID": @"2"};//根据公司需求修改  这里只是具个例子
    [manager POST:url parameters:parms headers:headerDic progress:^(NSProgress *_Nonnull uploadProgress) {
    }     success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        success(responseObject);
    }     failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        failture(error);
    }];

}

#pragma mark get请求方法  --  不需要请求头

+ (void)getNoHeaderWithUrl:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];

    [manager GET:url parameters:parms headers:[NSDictionary new] progress:^(NSProgress *_Nonnull downloadProgress) {
    }    success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        success(responseObject);
    }    failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        failture(error);
    }];

}

#pragma mark post请求方法

+ (void)postNOHeaderWithUrl:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", @"text/javascript", @"text/plain", nil];
    [manager POST:url parameters:parms headers:[NSDictionary new] progress:^(NSProgress *_Nonnull uploadProgress) {
    }     success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        success(responseObject);
    }     failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        failture(error);
    }];

}

#pragma mark --上传图片--

+ (void)upLoadToURLString:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                 fileData:(NSData *)fileData //要上传的数据
                     name:(NSString *)name //服务器参数名称 后台给你
                 fileName:(NSString *)fileName //文件名称 图片:xxx.jpg,xxx.png
                 mimeType:(NSString *)mimeType //文件类型 图片:image/jpg,image/png
                 progress:(void (^)(NSProgress *))progress //上传进度
                  success:(void (^)(NSURLSessionDataTask *, id))success
                  failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];//返回json格式
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", @"application/javascript", @"application/json", @"application/x-www-form-urlencoded", nil]];
    NSDictionary *headerDic = @{@"NH-AGENT-ID": @"2"};
    [session POST:URLString parameters:parameters headers:headerDic constructingBodyWithBlock:^(id <AFMultipartFormData> _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
    }    progress:^(NSProgress *_Nonnull uploadProgress) {
        progress(uploadProgress);
    }     success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    }     failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];

}

@end
