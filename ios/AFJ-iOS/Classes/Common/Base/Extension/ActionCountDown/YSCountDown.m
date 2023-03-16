//
//  YSCountDown.m
//  YSCountDownDemo
//
//  Created by fenghanxu on 2017/4/21.
//  Copyright © 2017年 fenghanxu. All rights reserved.
//



@implementation YSCountDown {
    dispatch_source_t _timer;
    NSDateFormatter *dateFormatter;

    NSInteger _less;
    UITableView *_myTableView;
    NSArray *_dataList;
    NSMutableArray *_canReloadList;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupLess];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupLess) name:UIApplicationDidBecomeActiveNotification object:nil];
    }

    return self;
}

- (instancetype)initWith:(UITableView *)tableView :(NSArray *)dataList :(NSMutableArray *)canReloadList {
    self = [super init];
    if (self) {
        _myTableView = tableView;
        _dataList = dataList;
        _canReloadList = canReloadList;
        [self setupLess];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupLess) name:UIApplicationDidBecomeActiveNotification object:nil];
    }

    return self;
}

- (void)setupLess {
    //以前用于校准网络获取回来的时间差  保证倒计时与服务器一致
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    [manager POST:@"http://api.k780.com:88/?app=life.time&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
//        //                NSLog(@"%@",responseObject);
//        NSString * webCurrentTimeStr = responseObject[@"result"][@"timestamp"];
//        NSInteger webCurrentTime = webCurrentTimeStr.longLongValue;
//        NSDate * date = [NSDate date];
//        NSInteger nowInteger = [date timeIntervalSince1970];
//        _less = nowInteger - webCurrentTime;
//        NSLog(@" --  与服务器时间的差值 -- %zd",_less);
//
//        if (_dataList) {
//            [self destoryTimer];
//            [self countDownWithPER_SEC:_myTableView :_dataList];
//        }
//
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@ - 网络错误 ! ",error);
//    }];

    _less = 0;
    NSLog(@" --  与服务器时间的差值 -- %zd", _less);

    if (_dataList) {
        [self destoryTimer];
        [self countDownWithPER_SEC:_myTableView :_dataList :_canReloadList];
    }

}

- (void)countDownWithPER_SEC:(UITableView *)tableView :(NSArray *)dataList :(NSMutableArray *)canReloadList {

    _myTableView = tableView;
    _dataList = dataList;
    _canReloadList = canReloadList;
    if (_timer == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                //获取tableview中的cell数组
                NSArray *cells = tableView.visibleCells; //取出屏幕可见ceLl
                //遍历cell数组
                for (UITableViewCell *cell in cells) {

                    NSDate *sjDate = [NSDate date];   //手机时间
                    NSInteger sjInteger = [sjDate timeIntervalSince1970];  // 手机当前时间戳
                    NSString *tempEndTime;
                    if ([dataList[0] isKindOfClass:[NSArray class]]) {
                        //这里不会进来的  用于二维数组的
                        NSInteger section = cell.tag / 1000;
                        NSInteger row = cell.tag % 1000;
                        tempEndTime = dataList[section][row];
                    } else {
                        //把传进来的时间戳组通过cell的tag值  获取结束时间
                        tempEndTime = dataList[cell.tag];
                    }

                    for (UIView *labText in cell.contentView.subviews) {
                        //找到cell的控件表示就找到对应的赋值控件   这种写法便于封装  如果自定义控件要转换成对应的类   就要到入类  不利于封装
                        if (labText.tag == 1314) {
                            UILabel *textLabel = (UILabel *) labText;
                            //转换对应的结束时间
                            NSInteger endTime = tempEndTime.longLongValue + self->_less;
                            //赋值结束时间
                            textLabel.text = [self getNowTimeWithString:endTime :sjInteger];
                            //如果时间倒计时完毕而且可以刷新时间就通过block出去刷新
                            if ([[self getNowTimeWithString:endTime :sjInteger] isEqualToString:@"倒计时结束"] && [self->_canReloadList[cell.tag] isEqualToString:@"可以"]) {
                                self->_canReloadList[cell.tag] = @"不可以";
                                self.block(cell.tag);
                            }
                        }
                    }
                    //NSLog(@" -------- %@ ----  %@",cell.detailTextLabel.text,cell.textLabel.text);
                }
            });
        });
        dispatch_resume(_timer); // 启动定时器
    }

}

/// 滑动过快的时候不会闪
- (NSString *)countDownWithPER_SEC:(NSIndexPath *)indexPath :(NSMutableArray *)canReloadList {
    NSDate *sjDate = [NSDate date];   //手机时间
    NSInteger sjInteger = [sjDate timeIntervalSince1970];  // 手机当前时间戳
    NSString *tempEndTime;
    if ([_dataList[0] isKindOfClass:[NSArray class]]) {

        tempEndTime = _dataList[indexPath.section][indexPath.row];
    } else {

        tempEndTime = _dataList[indexPath.row];
    }

    NSInteger endTime = tempEndTime.longLongValue + _less;

    return [self getNowTimeWithString:endTime :sjInteger];

}

// 传入结束时间 | 计算与当前时间的差值
- (NSString *)getNowTimeWithString:(NSInteger)aTimeString :(NSInteger)startTime {

    NSTimeInterval timeInterval = aTimeString - startTime;
    //    NSLog(@"%f",timeInterval);
    int days = (int) (timeInterval / (3600 * 24));
    int hours = (int) ((timeInterval - days * 24 * 3600) / 3600);
    int minutes = (int) (timeInterval - days * 24 * 3600 - hours * 3600) / 60;
    int seconds = timeInterval - days * 24 * 3600 - hours * 3600 - minutes * 60;

    NSString *dayStr;
    NSString *hoursStr;
    NSString *minutesStr;
    NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d", days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d", hours];
    //分钟
    if (minutes < 10)
        minutesStr = [NSString stringWithFormat:@"0%d", minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d", minutes];
    //秒
    if (seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d", seconds];


    if (_isPlusTime) {
        //新增
        if (hours >= 0 && minutes >= 0 && seconds >= 0) {
            return @"正在倒计时";
        }
        hours = -hours;
        minutes = -minutes;
        seconds = -seconds;
    } else {
        //新增
        if (hours <= 0 && minutes <= 0 && seconds <= 0) {
            return @"倒计时结束";
        }
    }

    //如果有日的时间就显示埋日
    if (days) {
        return [NSString stringWithFormat:@"%02d : %02d : %02d : %02d", days, hours, minutes, seconds];
    }
    //无就直接显示小时
    return [NSString stringWithFormat:@"%02d : %02d : %02d", hours, minutes, seconds];
}

/// 回传时间的变化
- (void)countDownWithPER_SECBlock:(void (^)(void))PER_SECBlock {
    if (_timer == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                PER_SECBlock(); // 回传时间的变化
            });
        });
        dispatch_resume(_timer); // 启动定时器
    }
}

/**
 *  主动销毁定时器
 */
- (void)destoryTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (void)dealloc {
    NSLog(@"%s dealloc", object_getClassName(self));
}

@end
