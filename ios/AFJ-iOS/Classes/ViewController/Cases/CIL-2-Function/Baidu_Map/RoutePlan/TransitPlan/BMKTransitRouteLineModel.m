//
//  BMKTransitRouteLineModel.m
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKTransitRouteLineModel.h"

@implementation BMKTransitRouteLineModel
- (instancetype)initWith:(BMKTransitRouteLine *)routeLine {
    if (self = [super init]) {
        if (routeLine.duration.minutes > 0) {
            _time = [NSString stringWithFormat:@"%d分钟", routeLine.duration.minutes];
        }
        if (routeLine.duration.hours > 0) {
            _time = [NSString stringWithFormat:@"%d小时", routeLine.duration.hours];
        }
        if (routeLine.duration.hours > 0 && routeLine.duration.minutes > 0) {
            _time = [NSString stringWithFormat:@"%d小时%d分", routeLine.duration.hours, routeLine.duration.minutes];
        }
        if (routeLine.distance < 100) {
            _distance = [NSString stringWithFormat:@"%d米", routeLine.distance];
        } else {
            _distance = [NSString stringWithFormat:@"%.1f公里", routeLine.distance / 1000.0];
        }
        int passStationNum = 0;
        int totalPrice = 0;
        int row = 0;
        int rowCount = 0;
        float lastWidth = 113.5 * widthScale;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (BMKTransitStep *step in routeLine.steps) {
            if (step.stepType >= BMK_WAKLING) {
                continue;
            }

            UILabel *label = [[UILabel alloc] init];
            label.text = step.vehicleInfo.title;
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
            NSDictionary *attrs = @{NSFontAttributeName: label.font};
            CGSize size = [label.text sizeWithAttributes:attrs];
            if (lastWidth + size.width + 30 * widthScale > SCREENW) {
                row++;
                rowCount = 0;
                lastWidth = 113.5 * widthScale;
                label.frame = CGRectMake(113.5 * widthScale, 28 * widthScale + 29 * widthScale * row, size.width + 10 * widthScale, 24 * widthScale);
            } else {
                label.frame = CGRectMake(lastWidth, 28 * widthScale + 29 * widthScale * row, size.width + 10 * widthScale, 24 * widthScale);
            }
            label.layer.cornerRadius = 12 * widthScale;
            label.textColor = COLOR(0x3385FF);
            label.layer.masksToBounds = YES;
            label.layer.borderWidth = 1;
            label.layer.borderColor = COLOR(0x3385FF).CGColor;
            label.textAlignment = NSTextAlignmentCenter;
            [tempArray addObject:label];
            passStationNum += step.vehicleInfo.passStationNum;
            totalPrice += step.vehicleInfo.zonePrice;
            lastWidth = label.frame.size.width + label.frame.origin.x + 11 * widthScale;

            UIImageView *center = [[UIImageView alloc] initWithFrame:CGRectMake(label.frame.size.width + label.frame.origin.x + 3 * widthScale, label.frame.origin.y + 7.5 * widthScale, 5 * widthScale, 9 * widthScale)];
            center.image = [UIImage imageNamed:@"next"];
            [tempArray addObject:center];
        }
        if (tempArray.count > 1) {
            [tempArray removeLastObject];
        }
        _tips = [tempArray copy];
        self.cellHeight = 28 * widthScale + 24 * widthScale + row * 29 * widthScale + 12.5 * widthScale + 14 * widthScale + 28 * widthScale;
        NSMutableString *detailStr = [NSMutableString string];
        if (passStationNum > 0) {
            [detailStr appendString:[NSString stringWithFormat:@"%d站", passStationNum]];
        }
        [detailStr appendString:[NSString stringWithFormat:@"·%@上车", routeLine.starting.title]];
        NSDictionary *attrs = @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:14 * widthScale]};
        CGSize size = [detailStr sizeWithAttributes:attrs];
        if (size.width + 150 * widthScale > SCREENW) {
            _detailRow = 2;
            self.cellHeight += 14 * widthScale;
        } else {
            _detailRow = 1;
        }
        _detail = detailStr;

    }
    return self;
}
@end
