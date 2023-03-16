//
//  AFJReactiveCocoaViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/18.
//

#import "AFJReactiveCocoaViewController.h"

#import "AFJCaseItemData.h"
#import "AFJRACBaseViewController.h"
#import "MTTest.h""

@interface AFJReactiveCocoaViewController ()


@property(nonatomic, strong) RACSubject *subject;

@end

@implementation AFJReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"RAC 示例";


    self.tableView.estimatedRowHeight = 60;

    NSMutableArray *dataArray = [NSMutableArray array];
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"RACSignal 信号示例";
        item.didSelectAction = ^(id data) {
            [weakSelf testSignald];
        };
        [dataArray addObject:item];
    }
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"RACDisposable 取消订阅示例";
        item.didSelectAction = ^(id data) {
            [weakSelf testDisposable];
        };
        [dataArray addObject:item];
    }
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"RACSubject (信号与订阅)简单示例";
        item.didSelectAction = ^(id data) {
            [weakSelf testSubject];
        };
        [dataArray addObject:item];
    }
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"RACReplaySubject 先发信号再订阅示例";
        item.didSelectAction = ^(id data) {
            [weakSelf testReplaySubject];
        };
        [dataArray addObject:item];
    }
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"RACMulticastConnection 示例";
        item.didSelectAction = ^(id data) {
            [weakSelf testMulticastConnection];
        };
        [dataArray addObject:item];
    }
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"RACCommand 示例";
        item.didSelectAction = ^(id data) {
            [weakSelf testCommand];
        };
        [dataArray addObject:item];
    }
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"OC 数组转换成 RAC";
        item.didSelectAction = ^(id data) {
            [weakSelf testTuple1];
        };
        [dataArray addObject:item];
    }
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"OC 字典转换成 RAC";
        item.didSelectAction = ^(id data) {
            [weakSelf testTuple2];
        };
        [dataArray addObject:item];
    }
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"RAC 字典转模型";
        item.didSelectAction = ^(id data) {
            [weakSelf testMTTest];
        };
        [dataArray addObject:item];
    }
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"rac_liftSelector 多请求处理示例";
        item.didSelectAction = ^(id data) {
            [weakSelf testRequestData];
        };
        [dataArray addObject:item];
    }
    {
        __weak typeof(self) weakSelf = self;
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"界面相关应用示例";
        item.didSelectAction = ^(id data) {
            [weakSelf testVC];
        };
        [dataArray addObject:item];
    }

        self.dataSource = dataArray;
    [self.tableView reloadData];
}

#pragma mark -

// 第1种: RACSignal 信号类
- (void)testSignald {

    [self showToastWithMessage:@"执行完成，请检查日志"];

    // 1.创建信号 (冷信号)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        // block什么时候调用:当信号被订阅的时候就会调用
        // block作用:在这里面传递数据出去

        // 3.发送数据
        NSLog(@"RACSignal 发送数据 1");
        [subscriber sendNext:@1];
        return nil;
    }];

    // 2.订阅信号 (热信号)
    // x:信号传递出来的数据
    [signal subscribeNext:^(id x) {
        // block什么时候调用:当信号内部,发送数据的时候,就会调用,并且会把值传递给你
        // block作用:在这个block中处理数据

        NSLog(@"RACSignal 接收数据 %@", x);
    }];

    /*
     执行流程:
     1.创建信号RACDynamicSignal
     * 1.1 把didSubscribe保存到RACDynamicSignal
     2.订阅信号
     *  2.1 创建订阅者,把nextBlock保存到订阅者里面去
     *  2.2 就会调用信号的didSubscribe
     3.执行didSubscribe
     *  3.1 拿到订阅者发送订阅者
     * [subscriber sendNext:@1]内部就是拿到订阅者的nextBlock
     * 信号被订阅,就会执行创建信号时didSubscribe
     * 订阅者发送信号,就是调用nextBlock
     */
}

// 第2种: RACDisposable 取消订阅或者清理资源
- (void)testDisposable {

    [self showToastWithMessage:@"执行完成，请检查日志"];

    // 只要订阅者一直在,表示需要一直订阅信号,信号不会自动被取消订阅
    // 1.创建信号
    __block id <RACSubscriber> mSubscriber = nil;
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

        // 3.发送信号
        NSLog(@"RACSignal 发送数据 1");
        [subscriber sendNext:@1];

        // 默认subscriber销毁的时候会触发disposableBlock
        mSubscriber = subscriber;

        RACDisposable *disposable = [RACDisposable disposableWithBlock:^{
            // 当信号取消订阅的时候就会调用
            NSLog(@"信号被取消订阅");
        }];
        return disposable;
    }];

    // 2.订阅信号
    RACDisposable *disposable = [signal subscribeNext:^(id x) {
        NSLog(@"RACSignal 接收数据 %@", x);
    }];

    // 取消订阅(主动取消)
    [disposable dispose];
}

// 第3种：RACSubject 信号提供者
// 信号提供者:既可以充当信号,也可以充当订阅者,发送数据
// 一个信号允许被多次订阅
- (void)testSubject {

    [self showToastWithMessage:@"执行完成，请检查日志"];

    // 1.创建信号
    RACSubject *subject = [RACSubject subject];

    // 2.订阅信号
    [subject subscribeNext:^(id x) {

        NSLog(@"订阅者一接收数据 %@", x);
    }];

    [subject subscribeNext:^(id x) {

        NSLog(@"订阅者二接收数据 %@", x);
    }];

    NSLog(@"RACSubject 发送数据 1");
    // 3.发送信号
    [subject sendNext:@1];

/*
 执行流程:
 1.创建信号
 2.订阅信号
 * 创建订阅者
 * [self subscribe:o]订阅信号,仅仅是把订阅者保存起来.
 3.发送信号
 * 把所有的订阅者遍历出来,一个一个的调用它们nextBlock
 */
}

// 第4种: RACReplaySubject 重复提供信号类(RACSubject的子类)
// 允许先发送信号,在订阅信号
// 重复信号提供者
- (void)testReplaySubject {

    [self showToastWithMessage:@"执行完成，请检查日志"];

    // 1.创建信号
    RACReplaySubject *subject = [RACReplaySubject subject];

    // 2.发送信号
    [subject sendNext:@"123123"];
    [subject sendNext:@"345"];
    [subject sendNext:@"456456"];
    // 1.把值保存到数组
    // 2.遍历所有的订阅者,调用nextBlock

    // 3.订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者一%@", x);
    }];
    // 1.遍历所有值,拿到订阅者去发送
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者二%@", x);
    }];

    /*
     执行流程:
     1.创建信号
     2.订阅信号
     * 创建订阅者,保存nextBlock保存
     * 遍历valuesReceived需要发送的所有值,拿到一个一个值,利用订阅者发送数据
     3.发送信号
     * 把发送的值,保存到数组
     * 把所有的订阅者遍历出来,一个一个的调用它们nextBlock
     */
}

// 第5种：RACMulticastConnection
// 用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用这个类处理
// 一个信号即使被订阅多次,也只是发送一次请求 RACMulticastConnection:用于信号中请求数据,避免多次请求数据
- (void)testMulticastConnection {

    [self showToastWithMessage:@"执行完成，请检查日志"];

    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

        NSLog(@"发送请求");
        // 3.发送信号
        [subscriber sendNext:@"网络数据"];
        return nil;
    }];

    // 2.把信号转换成连接类
    RACMulticastConnection *connect = [signal publish];

    // 3.订阅连接类的信号,注意: 一定是订阅连接类的信号,不再是源信号
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者一 %@", x);
    }];

    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者二 %@", x);
    }];
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者三 %@", x);
    }];

    // 4.连接
    [connect connect];

    /*
     执行流程
     1.创建信号
     * 创建RACDynamicSignal,并且把didSubscribe保存
     2.把信号转换成连接类
     * 创建信号提供者RACSubject
     * [self multicast:subject]:设置原始信号的多点传播subject,本质就是把subject设置为原始信号的订阅者
     * 创建RACMulticastConnection,把原始信号保存到_sourceSignal,把subject保存到_signal
     3.保存订阅者
     4.连接 [connect connect]
     * 订阅_sourceSignal,并且设置订阅者为subject
     5.执行didSubscribe
     6.[subject sendNext]遍历所有的订阅者发送信号
     */
}

// 第6种：RACCommand 用于处理事件的类
// RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，它可以很方便的监控事件的执行过程
// 使用场景:
//      监听按钮点击，网络请求
//      RACCommand使用步骤:创建命令 -> 执行命令
//      RACCommand使用注意点:内部不允许传入一个nil的信号
- (void)testCommand {

    [self showToastWithMessage:@"执行完成，请检查日志"];

    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // signalBlock调用时刻:只要命令一执行就会调用
        // signalBlock作用:处理事件
        NSLog(@"input : %@", input);

        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

            NSLog(@"执行命令过程中,调用 didSubscribe");
            // didSubscribe调用时刻:执行命令过程中,就会调用
            // didSubscribe作用:传递数据

            // subscriber -> [RACReplaySubject subject]
            // RACReplaySubject:把值保存起来,遍历所有的订阅者发送这个值
            NSLog(@"发送数据 1");
            [subscriber sendNext:@1];

            return nil;
        }];
    }];

    // 2.执行命令
    RACReplaySubject *replaySubject = (RACReplaySubject *) [command execute:@"执行命令"];

    // 3.获取命令中产生的数据,订阅信号
    [replaySubject subscribeNext:^(id x) {

        NSLog(@"接收数据 %@", x);
    }];

    /*
     执行流程:
     // 1.创建命令
     * 把signalBlock保存到命令中
     // 2.执行命令
     * 调用命令signalBlock
     * 创建多点传播连接类, 订阅源信号,并且设置源信号的订阅者为RACReplaySubject
     * 返回源信号的订阅者
     */
}

- (void)testTuple1 {

    [self showToastWithMessage:@"执行完成，请检查日志"];

// RACTuple: 元组类,类似NSArray,用来包装值.
// RACSequence: RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典

    // 包装元组
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"1", @1, @3, @5]];

    // 解包元组
    NSString *str = tuple[0];
    NSString *str2 = tuple.first;
    NSLog(@"解包元组 [0] : %@ - first : %@", str, str2);

    NSArray *arr = @[@"123", @1, @3, @5];
    // ----- OC数组转换成RAC集合 -----
    RACSequence *sequence = arr.rac_sequence;
    // 把集合转换成signal
    RACSignal *signal = sequence.signal;

    // 订阅集合类的信号,只要订阅这个信号,就会遍历集合中所有元素
    [signal subscribeNext:^(id x) {
        NSLog(@"signal 接收数据 %@", x);
    }];

    // 也可以写到一起
    [arr.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"arr.rac_sequence.signal 接收数据 %@", x);
    }];
}

- (void)testTuple2 {

    [self showToastWithMessage:@"执行完成，请检查日志"];

// RACTuple: 元组类,类似NSArray,用来包装值.
// RACSequence: RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典

    // 包装元组
    RACTuple *tuple2 = RACTuplePack(@1, @2, @3);

    // 解包元组
    RACTupleUnpack(NSNumber *n1, NSNumber *n2, NSNumber *n3) = tuple2;
    NSLog(@"解包元组 unpack %@ - %@ - %@", n1, n2, n3);

    // ----- OC字典转换成RAC集合 -----
    NSDictionary *dict = @{@"name": @"xmg", @"age": @18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        //        id value = x[1];
        //        id key = x[0];
        // 宏的参数,存放需要生成的变量名
        // 宏会自动生成参数里面的变量
        RACTupleUnpack(id key, id value) = x;
        NSLog(@"dict.rac_sequence.signal 接收数据 %@ : %@", key, value);
    }];
}

- (void)testMTTest {
    [self showToastWithMessage:@"执行完成，请检查日志"];
    NSArray *array = @[@{@"name": @"关羽", @"ID": @"1"},
            @{@"name": @"张飞", @"ID": @"2"},
            @{@"name": @"赵云", @"ID": @"3"},
            @{@"name": @"马超", @"ID": @"4"},
            @{@"name": @"黄忠", @"ID": @"5"}];
    // map:映射的意思，目的：把原始值value映射成一个新值
    // array: 把集合转换成数组
    // 底层实现：当信号被订阅，会遍历集合中的原始值，映射成新值，并且保存到新的数组里。
    NSArray *musicArray = [[array.rac_sequence map:^id(id value) {
        MTTest *test = [[MTTest alloc] init];
        [test setValuesForKeysWithDictionary:value];
        return test;
    }] array];

    NSLog(@"字典:\n %@", array);
    NSLog(@"模型:\n %@", musicArray);
}

- (void)testRequestData {
    [self showToastWithMessage:@"执行完成，请检查日志"];
//网络请求1
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSLog(@"网络请求1");
        [subscriber sendNext:@"网络请求1"];
        return nil;
    }];

//网络请求2
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSLog(@"网络请求2");
        [subscriber sendNext:@"网络请求2"];
        return nil;
    }];

//网络请求3
    RACSignal *signal3 = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSLog(@"网络请求3");
        [subscriber sendNext:@"网络请求3"];
        return nil;
    }];

    [self rac_liftSelector:@selector(dealDataWithData1:data2:data3:) withSignalsFromArray:@[signal1, signal2, signal3]];

}

- (void)dealDataWithData1:(id)data1 data2:(id)data2 data3:(id)data3 {
    NSLog(@"三个网络请求结束后在这里处理数据");
}

- (void)testVC {
    AFJRACBaseViewController *baseVC = [[AFJRACBaseViewController alloc] initWithNibName:@"AFJRACBaseViewController" bundle:nil];
    [self.navigationController pushViewController:baseVC animated:YES];
}

@end
