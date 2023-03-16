//
//  YMGraphView.m
//  GraphDemo
//
//  Created by dengjc on 16/7/21.
//  Copyright © 2016年 dengjc. All rights reserved.
//

#import "YMGraphView.h"

static const double kBaseSize = 200.0;
static const double kBaseFont = 12.0;
static const double kAnnularWidth = 40;    //环形图环大小，根据需求自定
static const double kScatterRadius = 2;     //散点图点大小，根据需求自定
static const int NTICK = 5;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

//坐标信息，起点，终点，刻度
typedef struct {
    CGFloat axisMin;
    CGFloat axisMax;
    CGFloat axisInc;
} AxisInfo;

NSComparator sortCmp = ^(id obj1, id obj2) {
    CGPoint point1 = [obj1 CGPointValue];
    CGPoint point2 = [obj2 CGPointValue];
    return [@(point1.x) compare:@(point2.x)];
};

@interface YMGraphView () {
    AxisInfo axisX;
    AxisInfo axisY;

    double kLeftMargin;
    double kBottomMargin;
    double kTotalMarginX;
    double kTotalMarginY;

    double kGridWidth;
    double kGridHeight;

    NSInteger tickX;
    NSInteger tickY;

}

@property(nonatomic, assign) YMGraphViewStyle style;

@property(nonatomic, copy) NSArray *data;

@property(nonatomic, assign) CGSize size;

@property(nonatomic, assign) NSInteger stickOutIndex;
//是否显示网格
@property(nonatomic, assign) BOOL showGrid;
//是否显示数据点，显示为实心小圆点
@property(nonatomic, assign) BOOL showPoint;

@property(nonatomic, strong) CAShapeLayer *animLayer;
//颜色数组，根据需求自定
@property(nonatomic, copy) NSArray *colorArr;


@end

@implementation YMGraphView

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data preferedStyle:(YMGraphViewStyle)preferedStyle {
    if (self = [super initWithFrame:frame]) {
        _size = frame.size;
        _style = preferedStyle;
        _stickOutIndex = -1;
        _showGrid = YES;
        _showPoint = YES;
        kLeftMargin = 0;
        kBottomMargin = 0;
        kTotalMarginX = 0;
        kTotalMarginY = 0;
        _colorArr = @[UIColorFromRGB(0xC0392B), UIColorFromRGB(0x27AE60),
                UIColorFromRGB(0x2980B9), UIColorFromRGB(0x16A085),
                UIColorFromRGB(0x8E44AD), UIColorFromRGB(0xF39C12),
                UIColorFromRGB(0xD35400), UIColorFromRGB(0x7F8C8D),
                UIColorFromRGB(0xBDC3C7), UIColorFromRGB(0x2C3E50)];
        self.backgroundColor = [UIColor whiteColor];
        if (preferedStyle == YMGraphViewStyleLine) {
            _data = [data sortedArrayUsingComparator:sortCmp];
        } else if (preferedStyle == YMGraphViewStyleMultiLine) {
            NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
            [data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
                NSArray *line = [obj sortedArrayUsingComparator:sortCmp];
                [tmpArr addObject:line];
            }];
            _data = [tmpArr copy];
        } else {
            _data = data;
        }
    }
    return self;
}

#pragma mark - configure

- (void)setPieStickOutIndex:(NSInteger)index {
    _stickOutIndex = index;
}

- (void)setShowGrid:(BOOL)showGrid {
    _showGrid = showGrid;
}

- (void)setShowPoint:(BOOL)showPoint {
    _showPoint = showPoint;
}

- (void)drawRect:(CGRect)rect {
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
        case YMGraphViewStyleLine:
            [self drawLine];
            break;
        case YMGraphViewStyleAnnular:
            [self drawAnnular];
            break;
        case YMGraphViewStyleMultiLine:
            [self drawMultiLine];
            break;
        default:
            break;
    }
}

#pragma mark - 散点图

- (void)drawScatter {
    //获取x,y最大最小值
    __block CGFloat minX = CGFLOAT_MAX;
    __block CGFloat maxX = -CGFLOAT_MAX;
    __block CGFloat minY = CGFLOAT_MAX;
    __block CGFloat maxY = -CGFLOAT_MAX;
    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CGPoint objPoint = [obj CGPointValue];
        if (minX > objPoint.x) {
            minX = objPoint.x;
        }
        if (maxX < objPoint.x) {
            maxX = objPoint.x;
        }
        if (minY > objPoint.y) {
            minY = objPoint.y;
        }
        if (maxY < objPoint.y) {
            maxY = objPoint.y;
        }
    }];
//坐标规范化，得到坐标轴起点，终点，刻度大小
    axisX = [self getAxisInfo:minX maxValue:maxX];
    axisY = [self getAxisInfo:minY maxValue:maxY];

    tickX = (axisX.axisMax - axisX.axisMin) / axisX.axisInc;
    tickY = (axisY.axisMax - axisY.axisMin) / axisY.axisInc;
//margin
    [self getMargin];
//画x,y轴
    [self drawAxis];
//网格大小
    kGridWidth = (_size.width - kTotalMarginX) / tickX;
    kGridHeight = (_size.height - kTotalMarginY) / tickY;
//X坐标刻度
    [self drawXLabel];
//Y坐标刻度
    [self drawYLabel];
//画线
    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [_colorArr[0] CGColor]);
//        CGContextSetLineDash(context,0, NULL,0);

        CGPoint objPoint = [obj CGPointValue];
        CGFloat x = kLeftMargin + (objPoint.x - axisX.axisMin) * kGridWidth / axisX.axisInc;
        CGFloat y = _size.height - kBottomMargin - (objPoint.y - axisY.axisMin) * kGridHeight / axisY.axisInc;

        CGContextAddArc(context, x, y, kScatterRadius / 2.0, 0, M_PI * 2, 0);
        CGContextSetLineWidth(context, kScatterRadius);
        CGContextStrokePath(context);

    }];

}

#pragma mark - 饼状图

- (void)drawPie {
    CGFloat minValue = MIN(_size.width, _size.height);
    CGFloat lineWidth = minValue / 2.0 - 5 * minValue / kBaseSize;
    if (_stickOutIndex == -1) {
        lineWidth = minValue / 2.0;
    }

    CGPoint center = CGPointMake(_size.width / 2.0, _size.height / 2.0);
    CGFloat radius = lineWidth / 2.0;
    CGFloat stickOutDistance = 5 * minValue / kBaseSize;
    //总数
    __block CGFloat total = 0.0;
    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        total += [obj floatValue];
    }];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);

    __block CGFloat startAngle = 0.0;

    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CGFloat addAngle = 2 * M_PI * [obj floatValue] / total;
        float textAngle = startAngle + addAngle / 2.0;

        //显示百分比
        NSString *textStr = [NSString stringWithFormat:@"%.2f%%", addAngle * 100 / 2 / M_PI];
        CGSize textSize = [textStr sizeWithAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:kBaseFont * minValue / kBaseSize]}];
        CGPoint textPoint;

        CGContextSetStrokeColorWithColor(context, [_colorArr[idx] CGColor]);
        if (_data.count == 1) {
            textPoint = CGPointMake(center.x - textSize.width / 2.0, center.y - textSize.height / 2.0);
            CGContextAddArc(context, center.x, center.y, radius, startAngle, startAngle + addAngle, 0);
        } else {
            //突出显示index
            if (idx == _stickOutIndex) {
                CGContextAddArc(context, center.x + stickOutDistance * cos(textAngle), center.y + stickOutDistance * sin(textAngle), radius, startAngle, startAngle + addAngle, 0);
                textPoint = CGPointMake(center.x + (radius + 2 * stickOutDistance) * cos(textAngle) - textSize.width / 2.0, center.y + (radius + 2 * stickOutDistance) * sin(textAngle) - textSize.height / 2.0);
            } else {
                CGContextAddArc(context, center.x, center.y, radius, startAngle, startAngle + addAngle, 0);
                textPoint = CGPointMake(center.x + radius * cos(textAngle) - textSize.width / 2.0, center.y + radius * sin(textAngle) - textSize.height / 2.0);
            }
        }
        CGContextStrokePath(context);
        [textStr drawAtPoint:textPoint withAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:kBaseFont * minValue / kBaseSize]}];
        startAngle += addAngle;
    }];
}

#pragma mark - 柱状图

- (void)drawHist {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [_colorArr[0] CGColor]);
    CGContextMoveToPoint(context, 0.5, 0);
    CGContextAddLineToPoint(context, 0, _size.height - 0.5);
    CGContextAddLineToPoint(context, _size.width, _size.height - 0.5);
    CGContextStrokePath(context);

    //柱宽及两柱间隙，自行调整
    CGFloat histoWidth = 2 * _size.width / (_data.count * 3 + 1);
    CGFloat histoDis = histoWidth / 2.0;

    __block CGFloat maxValue = 0;
    __block CGFloat totalValue = 0;
    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        totalValue += [obj floatValue];
        if (maxValue < [obj floatValue]) {
            maxValue = [obj floatValue];
        }
    }];

//    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, histoWidth);
    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CGContextSetStrokeColorWithColor(context, [_colorArr[idx] CGColor]);

        CGFloat startX = histoWidth + 3 * idx * histoDis;
        CGFloat startY = _size.height;
        NSString *textStr = [NSString stringWithFormat:@"%.0f", [obj floatValue]];
        CGSize textSize = [textStr sizeWithAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:11]}];

        CGFloat endY = _size.height - [obj floatValue] * (_size.height - textSize.height) / maxValue;
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, startX, endY);
        CGContextStrokePath(context);

        CGPoint textPoint = CGPointMake(startX - textSize.width / 2.0, endY - textSize.height);
        [textStr drawAtPoint:textPoint withAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:11]}];
    }];

}

#pragma mark - 折线图

- (void)drawLine {
//获取x,y最大最小值
    __block CGFloat minX = [_data[0] CGPointValue].x;
    __block CGFloat maxX = [[_data lastObject] CGPointValue].x;
    __block CGFloat minY = CGFLOAT_MAX;
    __block CGFloat maxY = -CGFLOAT_MAX;
    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CGPoint objPoint = [obj CGPointValue];
        if (minY > objPoint.y) {
            minY = objPoint.y;
        }
        if (maxY < objPoint.y) {
            maxY = objPoint.y;
        }

    }];
//坐标规范化，得到坐标轴起点，终点，刻度大小
    axisX = [self getAxisInfo:minX maxValue:maxX];
    axisY = [self getAxisInfo:minY maxValue:maxY];
//margin
    [self getMargin];
//画x,y轴
    [self drawAxis];
//网格大小
    kGridWidth = (_size.width - kTotalMarginX) / tickX;
    kGridHeight = (_size.height - kTotalMarginY) / tickY;
//X坐标刻度
    [self drawXLabel];
//Y坐标刻度
    [self drawYLabel];
//画线
    [self drawSingleLine:_data lineColor:_colorArr[0]];
}

#pragma mark - annular

- (void)drawAnnular {
    CGFloat minValue = MIN(_size.width, _size.height);
    CGFloat lineWidth = kAnnularWidth;

    CGPoint center = CGPointMake(_size.width / 2.0, _size.height / 2.0);
    CGFloat radius = (minValue - kAnnularWidth) / 2.0;
    //总数
    __block CGFloat total = 0.0;
    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        total += [obj floatValue];
    }];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);

    __block CGFloat startAngle = 0.0;

    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        CGFloat addAngle = 2 * M_PI * [obj floatValue] / total;

        CGContextSetStrokeColorWithColor(context, [_colorArr[idx] CGColor]);

        CGContextAddArc(context, center.x, center.y, radius, startAngle, startAngle + addAngle, 0);

        CGContextStrokePath(context);
        startAngle += addAngle;
    }];
}

#pragma mark - multi line

- (void)drawMultiLine {
    //获取x,y最大最小值
    __block CGFloat minX = CGFLOAT_MAX;
    __block CGFloat maxX = -CGFLOAT_MAX;
    __block CGFloat minY = CGFLOAT_MAX;
    __block CGFloat maxY = -CGFLOAT_MAX;
    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            CGPoint objPoint = [obj CGPointValue];
            if (minX > objPoint.x) {
                minX = objPoint.x;
            }
            if (maxX < objPoint.x) {
                maxX = objPoint.x;
            }
            if (minY > objPoint.y) {
                minY = objPoint.y;
            }
            if (maxY < objPoint.y) {
                maxY = objPoint.y;
            }
        }];
    }];
//坐标规范化，得到坐标轴起点，终点，刻度大小
    axisX = [self getAxisInfo:minX maxValue:maxX];
    axisY = [self getAxisInfo:minY maxValue:maxY];

    tickX = (axisX.axisMax - axisX.axisMin) / axisX.axisInc;
    tickY = (axisY.axisMax - axisY.axisMin) / axisY.axisInc;
//margin
    [self getMargin];
//画x,y轴
    [self drawAxis];
//网格大小
    kGridWidth = (_size.width - kTotalMarginX) / tickX;
    kGridHeight = (_size.height - kTotalMarginY) / tickY;
//X坐标刻度
    [self drawXLabel];
//Y坐标刻度
    [self drawYLabel];
//画线
    [_data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [self drawSingleLine:obj lineColor:_colorArr[idx]];
    }];
}

#pragma mark - draw func

+ (instancetype)drawFuncWithBlock:(CGFloat(^)(CGFloat))func from:(CGFloat)from to:(CGFloat)to withFrame:(CGRect)frame {
    NSMutableArray *pointArr = [[NSMutableArray alloc] init];
    CGFloat delta = (to - from) / 200;
    for (int i = 0; i < 200; i++) {
        CGFloat x = from + i * delta;
        CGFloat y = func(x);
        [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    }

    YMGraphView *view = [[YMGraphView alloc] initWithFrame:frame data:pointArr preferedStyle:YMGraphViewStyleLine];
    [view setShowPoint:NO];
    return view;
}

#pragma mark - inner methods

//axis info
- (AxisInfo)getAxisInfo:(CGFloat)minValue maxValue:(CGFloat)maxValue {
    NSInteger nfrac;
    CGFloat range = nicenum(maxValue - minValue, 0);
    AxisInfo tmpAxis;
    tmpAxis.axisInc = nicenum(range / (NTICK - 1), 1);
    tmpAxis.axisMin = floor(minValue / tmpAxis.axisInc) * tmpAxis.axisInc;
    tmpAxis.axisMax = ceil(maxValue / tmpAxis.axisInc) * tmpAxis.axisInc;
    nfrac = MAX(-floor(log10(tmpAxis.axisInc)), 0);/* # of fractional digits to show */

    printf("graphmin=%g graphmax=%g increment=%g\n", tmpAxis.axisMin, tmpAxis.axisMax, tmpAxis.axisInc);

    return tmpAxis;
}

CGFloat expt(CGFloat a, NSInteger n) {
    CGFloat x;
    x = 1.0;
    if (n > 0)
        for (; n > 0; n--)
            x *= a;
    else
        for (; n < 0; n++)
            x /= a;
    return x;
}

CGFloat nicenum(CGFloat x, NSInteger round) {
    NSInteger expv;                /* exponent of x */
    CGFloat f;                /* fractional part of x */
    CGFloat nf;                /* nice, rounded fraction */

    expv = floor(log10(x));
    f = x / expt(10.0, expv);/* between 1 and 10 */
    if (round)
        if (f < 1.5)
            nf = 1.0;
        else if (f < 3.0)
            nf = 2.0;
        else if (f < 7.0)
            nf = 5.0;
        else
            nf = 10.0;
    else if (f <= 1.0)
        nf = 1.0;
    else if (f <= 2.0)
        nf = 2.;
    else if (f <= 5.0)
        nf = 5.0;
    else
        nf = 10.0;
    return nf * expt(10.0, expv);
}

//坐标轴
- (void)drawAxis {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [_colorArr[0] CGColor]);
    CGContextMoveToPoint(context, kLeftMargin, 0);
    CGContextAddLineToPoint(context, kLeftMargin, _size.height - kBottomMargin);
    CGContextAddLineToPoint(context, _size.width, _size.height - kBottomMargin);
    CGContextStrokePath(context);
}

//横虚线
- (void)drawHorizontalDotLine:(CGFloat)y {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5);//线宽度
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGFloat lengths[] = {3, 3};//先画3个点再画3个点
    CGContextSetLineDash(context, 0, lengths, 2);//注意2(count)的值等于lengths数组的长度
    CGContextMoveToPoint(context, kLeftMargin, y);
    CGContextAddLineToPoint(context, _size.width, y);
    CGContextStrokePath(context);
}

//竖虚线
- (void)drawVerticalDotLine:(CGFloat)x {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5);//线宽度
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGFloat lengths[] = {3, 3};//先画3个点再画3个点
    CGContextSetLineDash(context, 0, lengths, 2);//注意2(count)的值等于lengths数组的长度
    CGContextMoveToPoint(context, x, 0);
    CGContextAddLineToPoint(context, x, _size.height - kBottomMargin);
    CGContextStrokePath(context);
}


//坐标轴与self边界间的距离
- (void)getMargin {
    tickX = (axisX.axisMax - axisX.axisMin) / axisX.axisInc;
    tickY = (axisY.axisMax - axisY.axisMin) / axisY.axisInc;

    CGSize sizeY = CGSizeZero;
    for (int i = 0; i <= tickY; i++) {
        NSString *yLabel = [NSString stringWithFormat:@"%g", axisY.axisMin + i * axisY.axisInc];
        CGSize textSize = [yLabel sizeWithAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:11]}];
        if (sizeY.width < textSize.width) {
            sizeY = textSize;
        }
    }
    kLeftMargin = sizeY.width;
    kBottomMargin = sizeY.height;

    kTotalMarginX = 2 * kLeftMargin;
    kTotalMarginY = 2 * kBottomMargin;
}

//x轴刻度及grid
- (void)drawXLabel {
    for (int i = 0; i <= tickX; i++) {
        NSString *xLabel = [NSString stringWithFormat:@"%g", axisX.axisMin + i * axisX.axisInc];
        CGSize textSize = [xLabel sizeWithAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:11]}];
        [xLabel drawAtPoint:CGPointMake(kLeftMargin - textSize.width / 2 + i * kGridWidth, _size.height - kBottomMargin) withAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:11]}];
        if (_showGrid && _style != YMGraphViewStyleScatter) {
            [self drawVerticalDotLine:kLeftMargin + (i + 1) * kGridWidth];
        }
    }
}

//y轴刻度及grid
- (void)drawYLabel {
    for (int i = 0; i <= tickY; i++) {
        NSString *yLabel = [NSString stringWithFormat:@"%g", axisY.axisMin + i * axisY.axisInc];
        CGSize textSize = [yLabel sizeWithAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:11]}];

        [yLabel drawAtPoint:CGPointMake(kLeftMargin - textSize.width, _size.height - 2 * kBottomMargin - i * kGridHeight) withAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:11]}];
        if (i != tickY && _showGrid && _style != YMGraphViewStyleScatter) {
            [self drawHorizontalDotLine:kBottomMargin + i * kGridHeight];
        }
    }
}

//画线
- (void)drawSingleLine:(NSArray *)data lineColor:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextSetLineDash(context, 0, NULL, 0);
    CGPoint objPoint = [data[0] CGPointValue];
    __block CGFloat firstPointX = kLeftMargin + (objPoint.x - axisX.axisMin) * kGridWidth / axisX.axisInc;
    __block CGFloat firstPointY = _size.height - kBottomMargin - (objPoint.y - axisY.axisMin) * kGridHeight / axisY.axisInc;
    if (_showPoint) {
        CGContextAddArc(context, firstPointX, firstPointY, 1.5, 0, M_PI * 2, 0);
        CGContextSetLineWidth(context, 3);
        CGContextStrokePath(context);
    } else {
        CGContextMoveToPoint(context, firstPointX, firstPointY);
    }
    [data enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (idx != 0) {
            CGPoint objPoint = [obj CGPointValue];
            CGFloat x = kLeftMargin + (objPoint.x - axisX.axisMin) * kGridWidth / axisX.axisInc;
            CGFloat y = _size.height - kBottomMargin - (objPoint.y - axisY.axisMin) * kGridHeight / axisY.axisInc;
            if (_showPoint) {
                CGContextAddArc(context, x, y, 1.5, 0, M_PI * 2, 0);
                CGContextSetLineWidth(context, 3);
                CGContextStrokePath(context);

                CGContextSetLineWidth(context, 1);
                CGContextMoveToPoint(context, firstPointX, firstPointY);
                CGContextAddLineToPoint(context, x, y);
                CGContextStrokePath(context);
                firstPointX = x;
                firstPointY = y;
            } else {
                CGContextSetLineWidth(context, 1);
                CGContextMoveToPoint(context, firstPointX, firstPointY);
                CGContextAddLineToPoint(context, x, y);
                CGContextStrokePath(context);
                firstPointX = x;
                firstPointY = y;
            }
        }
    }];
}

@end
