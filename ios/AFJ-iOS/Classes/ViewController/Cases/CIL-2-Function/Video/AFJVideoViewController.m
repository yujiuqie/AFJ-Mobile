//
//  AFJVideoViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/17.
//

#import "AFJVideoViewController.h"
#import "WAVideoBox.h"
#import "PlayViewController.h"

#import "AFJCaseItemData.h"

@interface AFJVideoViewController ()

@property (nonatomic , copy) NSString *videoPath;

@property (nonatomic , copy) NSString *testOnePath;

@property (nonatomic , copy) NSString *testTwoPath;

@property (nonatomic , copy) NSString *testThreePath;

@property (nonatomic , strong) WAVideoBox *videoBox;



@end

@implementation AFJVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _videoBox = [WAVideoBox new];
  
    _videoPath = [[NSBundle mainBundle] pathForResource:@"nature.mp4" ofType:nil];
  
    _testOnePath = [[NSBundle mainBundle] pathForResource:@"test1.mp4" ofType:nil];
    _testTwoPath = [[NSBundle mainBundle] pathForResource:@"test2.mp4" ofType:nil];
    _testThreePath = [[NSBundle mainBundle] pathForResource:@"test3.mp4" ofType:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"裁剪";
        item.didSelectAction = ^(id data) {
            [weakSelf rangeVideo];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"压缩";
        item.didSelectAction = ^(id data) {
            [weakSelf compressVideo];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"水印";
        item.didSelectAction = ^(id data) {
            [weakSelf addWaterMark];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"旋转";
        item.didSelectAction = ^(id data) {
            [weakSelf rotateVideo];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"换音";
        item.didSelectAction = ^(id data) {
            [weakSelf replaceVideo];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"合并";
        item.didSelectAction = ^(id data) {
            [weakSelf mixVideo];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"混音";
        item.didSelectAction = ^(id data) {
            [weakSelf mixSound];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"变速";
        item.didSelectAction = ^(id data) {
            [weakSelf gearVideo];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"混合操作一";
        item.didSelectAction = ^(id data) {
            [weakSelf showToastWithMessage:@"将1号拼接到video，用2号的音频替换，给视频加一个水印，旋转180度，混上3号的音,速度加快两倍，把生好的视频裁6-12秒，压缩"];
            [weakSelf composeEdit];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"混合操作二";
        item.didSelectAction = ^(id data) {
            [weakSelf showToastWithMessage:@"放入原视频，换成1号的音，再把3号视频放入混音,剪其中8秒; 拼1号视频，给1号水印,剪其中8秒; 拼2号视频，给2号变速; 拼3号视频，旋转180,剪其中8秒; 把最后的视频再做一个变速"];
            [weakSelf magicEdit];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"原视频";
        item.didSelectAction = ^(id data) {
            [weakSelf natureVideo];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"素材1";
        item.didSelectAction = ^(id data) {
            [weakSelf playTest1];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"素材2";
        item.didSelectAction = ^(id data) {
            [weakSelf playTest2];
        };
        [dataArray addObject:item];
    }{
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"素材3";
        item.didSelectAction = ^(id data) {
            [weakSelf playTest3];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

#pragma mari private method

- (NSString *)buildFilePath{
    
    return [NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"%f.mp4", [[NSDate date] timeIntervalSinceReferenceDate]]];
}

- (void)goToPlayVideoByFilePath:(NSString *)filePath{
    PlayViewController *playVc = [PlayViewController new];
    [playVc loadWithFilePath:filePath];
    [self.navigationController pushViewController:playVc animated:YES];
}

#pragma mark 常规操作
- (void)rangeVideo {
    
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [_videoBox appendVideoByPath:_videoPath];
    [_videoBox rangeVideoByTimeRange:CMTimeRangeMake(CMTimeMake(3600, 600), CMTimeMake(3600, 600))];
    
    [_videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

- (void)compressVideo {
    
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [_videoBox appendVideoByPath:_videoPath];
    _videoBox.ratio = WAVideoExportRatio960x540;
    _videoBox.videoQuality = 1; // 有两种方法可以压缩
    [_videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
        wself.videoBox.ratio = WAVideoExportRatio960x540;
        wself.videoBox.videoQuality = 0;
    }];
}

- (void)addWaterMark {
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [_videoBox appendVideoByPath:_videoPath];
    [_videoBox appendImages:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gifTest" ofType:@"gif"]]  relativeRect:CGRectMake(0.6, 0.2, 0.3, 0)];
    
    [_videoBox asyncFinishEditByFilePath:filePath progress:^(float progress) {
        NSLog(@"progress -- %f",progress);
    } complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

- (void)rotateVideo {
    
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [_videoBox appendVideoByPath:_videoPath];
    [_videoBox rotateVideoByDegress:90];
    [_videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

- (void)replaceVideo {
    
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [_videoBox appendVideoByPath:_videoPath];
    [_videoBox replaceSoundBySoundPath:_testOnePath];
    
    [_videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

- (void)mixVideo {
    
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [_videoBox appendVideoByPath:_testThreePath];
    [_videoBox appendVideoByPath:_testTwoPath];
    
    [_videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

- (void)mixSound {
    
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [_videoBox appendVideoByPath:_videoPath];
    [_videoBox dubbedSoundBySoundPath:_testThreePath];
    
    [_videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
    
}

- (void)gearVideo {
    
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [_videoBox appendVideoByPath:_videoPath];
    [_videoBox gearBoxWithScale:3];
    
    [_videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}


#pragma mark 混合操作
- (void)composeEdit {
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    // 将1号拼接到video，用2号的音频替换，给视频加一个水印，旋转180度，混上3号的音,速度加快两倍，把生好的视频裁6-12秒，压缩
    [_videoBox appendVideoByPath:_videoPath];
    [_videoBox appendVideoByPath:_testThreePath];
    [_videoBox replaceSoundBySoundPath:_testTwoPath];
    [_videoBox appendWaterMark:[UIImage imageNamed:@"waterMark"] relativeRect:CGRectMake(0.7, 0.2, 0.2, 0)];
    
    [_videoBox rotateVideoByDegress:180];
    [_videoBox dubbedSoundBySoundPath:_testOnePath];
    [_videoBox gearBoxWithScale:2];
    
    [_videoBox rangeVideoByTimeRange:CMTimeRangeMake(CMTimeMake(2400, 600), CMTimeMake(3600, 600))];
    
    [_videoBox asyncFinishEditByFilePath:filePath progress:^(float progress) {
        NSLog(@"progress --- %f",progress);
    }  complete:^(NSError * error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
    
}


#pragma mark 骚操作
- (void)magicEdit {
    
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    // 放入原视频，换成1号的音，再把3号视频放入混音,剪其中8秒
    // 拼1号视频，给1号水印,剪其中8秒
    // 拼2号视频，给2号变速
    // 拼3号视频，旋转180,剪其中8秒
    // 把最后的视频再做一个变速
    [_videoBox appendVideoByPath:_videoPath];
    [_videoBox replaceSoundBySoundPath:_testOnePath];
    [_videoBox dubbedSoundBySoundPath:_testThreePath];
    [_videoBox rangeVideoByTimeRange:CMTimeRangeMake(kCMTimeZero, CMTimeMake(3600, 600))];
    
    [_videoBox appendVideoByPath:_testOnePath];
    [_videoBox appendWaterMark:[UIImage imageNamed:@"waterMark"] relativeRect:CGRectMake(0.7, 0.2, 0.2, 0)];
    [_videoBox rangeVideoByTimeRange:CMTimeRangeMake(CMTimeMake(3600, 600), CMTimeMake(3600, 600))];
    
    [_videoBox appendVideoByPath:_testTwoPath];
    [_videoBox gearBoxWithScale:2];
    
    [_videoBox appendVideoByPath:_testThreePath];
    [_videoBox rotateVideoByDegress:180];
    [_videoBox rangeVideoByTimeRange:CMTimeRangeMake(kCMTimeZero, CMTimeMake(3600, 600))];
    
    [_videoBox commit];
    [_videoBox gearBoxWithScale:2];
    
    [_videoBox asyncFinishEditByFilePath:filePath progress:^(float progress) {
        NSLog(@"progress --- %f",progress);
    }  complete:^(NSError * error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
    
   
}

- (void)natureVideo {
     [self goToPlayVideoByFilePath:_videoPath];
}

- (void)playTest1 {
    [self goToPlayVideoByFilePath:_testOnePath];
}

- (void)playTest2 {
    [self goToPlayVideoByFilePath:_testTwoPath];
}

- (void)playTest3 {
    [self goToPlayVideoByFilePath:_testThreePath];
}

@end
