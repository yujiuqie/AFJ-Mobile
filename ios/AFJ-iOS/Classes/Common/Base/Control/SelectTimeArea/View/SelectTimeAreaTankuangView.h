//
//  SelectTimeAreaTankuangView.h
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTimeAreaTankuangView : UIView

+ (instancetype)SelectTimeAreaTankuangViewWithConfirm:(void (^)(NSString *startStr, NSString *endStr))confirm cancel:(void (^)(void))cancel;

@end
