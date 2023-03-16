//
//  SelectTimeAreaViewItem.h
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//  弹出界面

#import <Foundation/Foundation.h>

@interface SelectTimeAreaViewItem : NSObject

+ (void)SelectTimeAreaViewItemConfirm:(void (^)(NSString *startStr, NSString *endStr))confirm cancel:(void (^)(void))cancel;

@end
