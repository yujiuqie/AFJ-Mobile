//
//  DayAxisValueFormatter.h
//  ChartsDemo
//  Copyright © 2016 dcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFJ_iOS-Swift.h"

@interface DayAxisValueFormatter : NSObject <ChartAxisValueFormatter>

- (id)initForChart:(BarLineChartViewBase *)chart;

@end
