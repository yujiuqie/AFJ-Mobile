//
//  AFJClockSampleViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/26.
//

#import "AFJClockSampleViewController.h"
#import "XLClock.h"
#import "XLFoldClock.h"

@interface AFJClockSampleViewController ()
{
    NSTimer *_timer;
    XLFoldClock *_foldClock;
    XLClock *_clock;
}

@end

@implementation AFJClockSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(_clock){
        [_clock showStartAnimation];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _foldClock.frame = self.view.bounds;
}

- (void)updateTimeLabel {
    _foldClock.date = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setupClockType:(NSInteger)type
{
    if (type == 1) {
        _foldClock = [[XLFoldClock alloc] init];
        _foldClock.frame = self.view.bounds;
        _foldClock.date = [NSDate date];
        [self.view addSubview:_foldClock];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:true];
    }
    else{
        _clock = [[XLClock alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _clock.center = self.view.center;
        [self.view addSubview:_clock];
    }
}

@end
