//
//  AFJAliCrashLogViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/28.
//

#import "AFJAliCrashLogViewController.h"

#import "AFJCaseItemData.h"

@interface AFJAliCrashLogViewController()



@end

@implementation AFJAliCrashLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"测试上报自定义异常";
        item.didSelectAction = ^(id data) {
            //上报自定义信息
//            [AlicloudCrashProvider configCustomInfoWithKey:@"key-Test1" value:@"value-Test1"];//配置项：自定义环境信息（configCustomInfoWithKey/value）
//
//            //按异常类型上报自定义信息
//            [AlicloudCrashProvider setCrashCallBack:^NSDictionary * _Nonnull(NSString * _Nonnull type) {
//                return @{@"key-Test2":@"value-Test2"};//配置项：异常信息（key/value）
//            }];
//            
//            //上报自定义错误
//            NSError *error = [NSError errorWithDomain:@"AFJAliCrashLogViewController" code:10002 userInfo:@{@"errorInfoKeyAFJAliCrashLogViewController":@"errorInfoValueAFJAliCrashLogViewController"}];
//            [AlicloudCrashProvider reportCustomError:error];//配置项：自定义错误信息（errorWithDomain/code/userInfo）
            [weakSelf showToastWithMessage:@"已上传自定义测试异常"];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

@end
