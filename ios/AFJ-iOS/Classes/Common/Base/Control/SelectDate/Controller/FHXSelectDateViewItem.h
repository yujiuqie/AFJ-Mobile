//
//  LMTShareViewItem.h
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHXSelectDateTankuangView.h"


@interface FHXSelectDateViewItem : NSObject

+ (void)SelectDateViewItemWithShowDateType:(showDateType)showDateType Confirm:(void (^)(NSString *dateStr))confirm cancel:(void (^)(void))cancel;
@end
