//
//  AFJWebKitViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/23.
//

#import "AFJWebKitViewController.h"
#import <CommonCrypto/CommonCrypto.h>
#import <SSZipArchive.h>
#import "HybridViewController.h"
#import "TestWebViewController.h"
#import "CustomViewController.h"
#import "CustomTwoViewController.h"
#import "MainH5WidgetViewController.h"
#import "AFJHTMLSampleViewController.h"

@interface AFJWebKitViewController ()

@end

@implementation AFJWebKitViewController

- (void)initDataSource{
    NSMutableArray *dataArray = [NSMutableArray array];

    AFJCaseItemData *model1 = [[AFJCaseItemData alloc] init];
    model1.title = @"百度";
    model1.subtitle = @"https://www.baidu.com";
    model1.link = @"https://www.baidu.com";
    model1.didSelectAction = ^(AFJCaseItemData *model) {
        TestWebViewController *webVC = [[TestWebViewController alloc] initWithURLString:model.link];
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [dataArray addObject:model1];

    AFJCaseItemData *model2 = [[AFJCaseItemData alloc] init];
    model2.title = @"post请求";
    model2.subtitle = @"body={username=zhangsan&password=123456}";
    model2.link = @"http://www.mocky.io/v2/5adef15a3300002500e4d6bb";
    model2.didSelectAction = ^(AFJCaseItemData *model) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:model.link]];
        request.HTTPMethod = @"POST";
        NSString *str = @"username=jxb&password=123456";
        request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];

        JXBWebViewController *webVC = [[JXBWebViewController alloc] initWithURLRequest:request];
    };
    [dataArray addObject:model2];

    AFJCaseItemData *model3 = [[AFJCaseItemData alloc] init];
    model3.title = @"交互测试";
    model3.subtitle = @"使用的本地h5.html文件";
    model3.link = [NSString stringWithFormat:@"file://%@", [[NSBundle mainBundle] pathForResource:@"h5" ofType:@"html"]];
    model3.didSelectAction = ^(AFJCaseItemData *model) {
        JXBWebViewController *webVC = [[JXBWebViewController alloc] initWithURLString:model.link];
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [dataArray addObject:model3];

//    AFJCaseItemData *model4 = [[AFJCaseItemData alloc] init];
//    model4.title = @"请求带cookie";
//    model4.subtitle = @"cookie={key1=value1;key2=value2}";
//    model4.link = @"http://www.baidu.com";
//    model4.cookie = @{@"key1":@"value1", @"key2":@"value2"};
//    model4.didSelectAction = ^(AFJCaseItemData * model) {
//        JXBWebViewController *webVC = [[JXBWebViewController alloc] initWithURL:[NSURL URLWithString:model.link] cookie:model.cookie];
//        [self.navigationController pushViewController:webVC animated:YES];
//    };
//    [dataArray addObject:model4];

    AFJCaseItemData *model5 = [[AFJCaseItemData alloc] init];
    model5.title = @"H5秒开优化方案1 - 模板渲染";
    model5.subtitle = @"服务端下发html模板和数据，客户端负责渲染，适合类似新闻详情页等业务场景";
    model5.didSelectAction = ^(AFJCaseItemData *model) {
        HybridViewController *webVC = [[HybridViewController alloc] init];
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [dataArray addObject:model5];

    AFJCaseItemData *model6 = [[AFJCaseItemData alloc] init];
    model6.title = @"H5秒开优化方案2 - 离线包";
    model6.subtitle = @"将html、css、js等静态资源分离，资源可以做到增量更新，适合所有业务场景";
    model6.didSelectAction = ^(AFJCaseItemData *model) {
        [self requestOfflinePkg];
    };
    [dataArray addObject:model6];

    AFJCaseItemData *model7 = [[AFJCaseItemData alloc] init];
    model7.title = @"新浪网";
    model7.subtitle = @"https://www.sina.com.cn";
    model7.link = @"https://www.sina.com.cn";
    model7.didSelectAction = ^(AFJCaseItemData *model) {
        TestWebViewController *webVC = [[TestWebViewController alloc] initWithURLString:model.link];
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [dataArray addObject:model7];

    AFJCaseItemData *model8 = [[AFJCaseItemData alloc] init];
    model8.title = @"搜狐网";
    model8.subtitle = @"http://www.sohu.com";
    model8.link = @"http://www.sohu.com";
    model8.didSelectAction = ^(AFJCaseItemData *model) {
        TestWebViewController *webVC = [[TestWebViewController alloc] initWithURLString:model.link];
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [dataArray addObject:model8];

    AFJCaseItemData *model9 = [[AFJCaseItemData alloc] init];
    model9.title = @"爱奇艺";
    model9.subtitle = @"https://v.qq.com";
    model9.link = @"https://v.qq.com";
    model9.didSelectAction = ^(AFJCaseItemData *model) {
        TestWebViewController *webVC = [[TestWebViewController alloc] initWithURLString:model.link];
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [dataArray addObject:model9];

    AFJCaseItemData *model10 = [[AFJCaseItemData alloc] init];
    model10.title = @"测试启动时间";
    model10.subtitle = @"";
    model10.link = @"";
    model10.didSelectAction = ^(AFJCaseItemData *model) {
        CustomViewController *webVC = [[CustomViewController alloc] init];
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [dataArray addObject:model10];

    AFJCaseItemData *model11 = [[AFJCaseItemData alloc] init];
    model11.title = @"测试启动时间2";
    model11.subtitle = @"";
    model11.link = @"";
    model11.didSelectAction = ^(AFJCaseItemData *model) {
        CustomTwoViewController *webVC = [[CustomTwoViewController alloc] init];
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [dataArray addObject:model11];
    
    AFJCaseItemData *model12 = [[AFJCaseItemData alloc] init];
    model12.title = @"Cordova 示例";
    model12.subtitle = @"";
    model12.link = @"";
    model12.didSelectAction = ^(AFJCaseItemData *model) {
        MainH5WidgetViewController *webVC = [[MainH5WidgetViewController alloc] init];
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [dataArray addObject:model12];
    
    AFJCaseItemData *model13 = [[AFJCaseItemData alloc] init];
    model13.title = @"HTML 示例";
    model13.subtitle = @"";
    model13.link = @"";
    model13.didSelectAction = ^(AFJCaseItemData *model) {
        AFJHTMLSampleViewController *webVC = [[AFJHTMLSampleViewController alloc] init];
        [self.navigationController pushViewController:webVC animated:YES];
    };
    [dataArray addObject:model13];
    
    self.dataSource = dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *item = [UIBarButtonItem qmui_itemWithTitle:@"Warning" target:self action:@selector(warningAcition)];
    self.navigationItem.rightBarButtonItems = @[item];
}

//下载离线包html+css
- (void)requestOfflinePkg {
    NSString *zipName = @"offline_pkg";
    NSString *zipUrl = [NSString stringWithFormat:@"http://localhost:9090/source/%@.zip", zipName];
    NSURL *url = [NSURL URLWithString:zipUrl];
    NSString *md5 = [self md5:zipUrl];
    NSArray *pathes = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [pathes objectAtIndex:0];
    NSString *zipPath = [NSString stringWithFormat:@"%@/zipDownload/%@", path, md5];
    NSString *unzipPath = [NSString stringWithFormat:@"%@/%@.zip", path, md5];


    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        if (!error) {
            [data writeToFile:unzipPath options:0 error:nil];

            BOOL result = [SSZipArchive unzipFileAtPath:unzipPath toDestination:zipPath];

            //解压缩成功
            if (result) {
                //删除zip
                NSFileManager *fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:unzipPath error:nil];

                //开始渲染
                NSString *filePath = [NSString stringWithFormat:@"file://%@/%@/%@", zipPath, zipName, @"offline.html"];

                dispatch_async(dispatch_get_main_queue(), ^{
                    JXBWebViewController *webVC = [[JXBWebViewController alloc] initWithURLString:filePath];
                    [self.navigationController pushViewController:webVC animated:YES];
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请部署接口服务，步骤见文档" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {

                }];
                [alertController addAction:action];
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }
    }];

    [task resume];
}

- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG) strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)warningAcition {
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}


@end
