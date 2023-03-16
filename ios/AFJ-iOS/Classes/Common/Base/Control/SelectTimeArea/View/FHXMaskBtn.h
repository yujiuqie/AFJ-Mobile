//
//  FHXMaskBtn.h
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHXMaskBtn : UIButton
/**
 *  设置以后已经添加到window上，并且设置了frame
 */
+ (instancetype)zhenZhaoBtnWithComplete:(void (^)(FHXMaskBtn *zheZhaoBtn))complete;

@end
