//
//  FHXConfirmView.h
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHXConfirmView : UIView

+ (instancetype)ConfirmViewwithConfirm:(void (^)(void))confirm cancel:(void (^)(void))cancel;
@end
