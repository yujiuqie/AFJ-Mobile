//
//  XPSchooleMateNoView.h
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    showDateTypeMonth,
    showDateTypeDay,
    showDateTypeHour,
} showDateType;


@interface FHXSelectDateTankuangView : UIView

+ (instancetype)SelectDateTankuangViewWithShowDateType:(showDateType)showDateType Confirm:(void (^)(NSString *dateStr))confirm cancel:(void (^)(void))cancel;

@end
