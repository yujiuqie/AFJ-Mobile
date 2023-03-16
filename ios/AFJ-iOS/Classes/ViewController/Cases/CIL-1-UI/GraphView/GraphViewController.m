//
//  DraphViewController.m
//  GraphDemo
//
//  Created by dengjc on 16/7/25.
//  Copyright © 2016年 dengjc. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@property(nonatomic, assign) CGRect rect;

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = self.view.bounds.size.width;
//    CGFloat height = self.view.bounds.size.height;

    _rect = CGRectMake((width - 250) / 2, 200, 250, 200);
    // Do any additional setup after loading the view.
    switch (_style) {
        case YMGraphViewStyleScatter:
            [self drawScatter];
            break;
        case YMGraphViewStylePie:
            [self drawPie];
            break;
        case YMGraphViewStyleHist:
            [self drawHist];
            break;
        case YMGraphViewStyleAnnular:
            [self drawAnnular];
            break;
        case YMGraphViewStyleLine:
            [self drawLine];
            break;
        case YMGraphViewStyleMultiLine:
            [self drawMultiLine];
            break;
        default:
            [self drawFunc];
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawScatter {
    NSMutableArray *scatterArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 200; i++) {
        CGFloat x = arc4random() % 1000;
        CGFloat y = arc4random() % 500;
        [scatterArr addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    }
    YMGraphView *view = [[YMGraphView alloc] initWithFrame:_rect data:scatterArr preferedStyle:YMGraphViewStyleScatter];
    [self.view addSubview:view];
}

- (void)drawPie {
    YMGraphView *view = [[YMGraphView alloc] initWithFrame:_rect data:@[@400, @300, @700, @400, @400, @600] preferedStyle:YMGraphViewStylePie];
//    [view setPieStickOutIndex:3];
    [self.view addSubview:view];
}

- (void)drawHist {
    YMGraphView *view = [[YMGraphView alloc] initWithFrame:_rect data:@[@400, @300, @700, @400, @400, @600] preferedStyle:YMGraphViewStyleHist];
    [self.view addSubview:view];
}

- (void)drawAnnular {
    YMGraphView *view = [[YMGraphView alloc] initWithFrame:_rect data:@[@400, @300, @700, @400, @400, @600] preferedStyle:YMGraphViewStyleAnnular];
    [self.view addSubview:view];
}

- (void)drawLine {
    YMGraphView *view = [[YMGraphView alloc] initWithFrame:_rect
                                                      data:@[[NSValue valueWithCGPoint:CGPointMake(2, 200)],
                                                              [NSValue valueWithCGPoint:CGPointMake(-7, 900)],
                                                              [NSValue valueWithCGPoint:CGPointMake(-3, 700)],
                                                              [NSValue valueWithCGPoint:CGPointMake(8, 1700)],
                                                              [NSValue valueWithCGPoint:CGPointMake(1, 500)]]
                                             preferedStyle:YMGraphViewStyleLine];
    [self.view addSubview:view];
}

- (void)drawMultiLine {
    YMGraphView *view = [[YMGraphView alloc] initWithFrame:_rect
                                                      data:@[@[[NSValue valueWithCGPoint:CGPointMake(2, 200)],
                                                              [NSValue valueWithCGPoint:CGPointMake(7, 900)],
                                                              [NSValue valueWithCGPoint:CGPointMake(3, 700)],
                                                              [NSValue valueWithCGPoint:CGPointMake(8, 1200)],
                                                              [NSValue valueWithCGPoint:CGPointMake(1, 500)]],
                                                              @[[NSValue valueWithCGPoint:CGPointMake(3, 800)],
                                                                      [NSValue valueWithCGPoint:CGPointMake(6, 1200)],
                                                                      [NSValue valueWithCGPoint:CGPointMake(4, 800)],
                                                                      [NSValue valueWithCGPoint:CGPointMake(9, 1500)],
                                                                      [NSValue valueWithCGPoint:CGPointMake(2, 500)]],
                                                              @[[NSValue valueWithCGPoint:CGPointMake(2, 1400)],
                                                                      [NSValue valueWithCGPoint:CGPointMake(6, 1900)],
                                                                      [NSValue valueWithCGPoint:CGPointMake(5, 1400)],
                                                                      [NSValue valueWithCGPoint:CGPointMake(10, 1000)],
                                                                      [NSValue valueWithCGPoint:CGPointMake(1, 1200)]]]
                                             preferedStyle:YMGraphViewStyleMultiLine];
    [view setShowPoint:NO];
    [view setShowGrid:NO];
    [self.view addSubview:view];
}

- (void)drawFunc {
    YMGraphView *view = [YMGraphView drawFuncWithBlock:^(CGFloat x) {
//        return sqrt(1 - x*x) + pow(x, 2.0/3.0);
        return fabs(x) - fabs(x / 2 + 1) - fabs(x / 2 - 1) + (fabs(x / 2 + 2) + fabs(x / 2 - 2) - fabs(x / 2 + 1) - fabs(x / 2 - 1)) * sin(5 * M_PI * x);
//        return pow(x, 2.0/3.0) + sqrt(4 - x*x)*sin(5*M_PI*x);
//        return sin(x) * cos(x);
    }                                             from:-5 to:5 withFrame:_rect];
    [self.view addSubview:view];
}
@end
