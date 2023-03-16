//
//  SelectTimeAreaPickerView.h
//  Frame
//
//  Created by 冯汉栩 on 16/8/13.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTimeAreaPickerView : UIPickerView

/**
 *  初始化的时候，此种方法选中为当前时间
 *
 *  @param outputFormatter 输出的日期格式
 *  @param completion 完成回调，传出了选定日期的字符串
 */
+ (instancetype)SelectTimeAreaViewWithcomplete:(void (^)(NSString *startStr, NSString *endStr))completion;

@end
